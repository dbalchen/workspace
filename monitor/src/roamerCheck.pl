#!/usr/bin/env perl


BEGIN {
#	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
	push(@INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5');

}

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/monitor/src/';
$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/IP_Check/';

# For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

# use strict;
use MIME::Lite;
use DBI;
use Schedule::Cron;
use Spreadsheet::WriteExcel;
use FileHandle;
use Cwd qw(abs_path);
use POSIX;
use List::Uniq ':all';

&scheduledTask();

 my $cron = new Schedule::Cron(\&scheduledTask,processprefix=>"ip_check_monitor");
 my $time = "0 8 * * *";
 $cron->add_entry($time);
 $cron->run(detach=>1,pid_file=>"ip_check_monitor_pid");

exit(0);

sub scheduledTask() {

	my($day, $month, $year)=(localtime)[3,4,5];
	my $timeStamp = ($month+1)."_".$day."_".($year+1900);

	chdir("$ENV{'REC_HOME'}");

	my $excel_file = "IPCheck_" . $timeStamp . '.xls';

	my $heading    = [
		'DATE',
		'IP',
		'Home Total',
		'Roam Total',
		'Home Mean',
		'Roam Mean',
		'Home STD',
		'Roam STD',
		'Home Per',
		'Roam Per'
	];

	my $cntrow    = 1;
	my $workbook  = Spreadsheet::WriteExcel->new($excel_file);
	my $worksheet = $workbook->add_worksheet("Oddities");

	my $bold = $workbook->add_format( bold => 1 );
	$worksheet->write( 'A1', $heading, $bold );

	my $conn = getBODSPRD();

	$sql =
"select to_char(start_time,'YYYYMMDD'), l9_ip_address,L9_NT_ROAMING_IND,  count(*) as RECORDS, SUM(L3_VOLUME) as VOLUME, SUM(L9_DOWNLINK_VOLUME) as DL_VOLUME, SUM(L9_UPLINK_VOLUME) as UL_VOLUME From ape1_rated_event  where L3_PAYMENT_CATEGORY = 'PRE' and  l3_call_source in ('L','D') and start_time > sysdate - 30 group by to_char(start_time,'YYYYMMDD'), l9_ip_address,L9_NT_ROAMING_IND order by 1,2,3";

	$sth = $conn->prepare($sql);
	$sth->execute() or sendErr();

	my %sumData = {};

	while ( my @rows = $sth->fetchrow_array() ) {

		#	open( EVENT, "< /home/dbalchen/Desktop/event.csv" ) || exit(0);
		#	#
		#	while ( $buff = <EVENT> ) {
		#		chomp($buff);
		#		#
		#		my @rows = split( "\t", $buff );

		if ( defined $sumData{ $rows[1] }{ $rows[0] } ) {

			my @sumrow = @{ $sumData{ $rows[1] }{ $rows[0] } };

			if ( $rows[2] eq 'Y' ) {

				$sumrow[2] = $rows[3] + $sumrow[2];
				$sumrow[3] = $rows[4] + $sumrow[3];

			}
			else {

				$sumrow[0] = $rows[3] + $sumrow[0];
				$sumrow[1] = $rows[4] + $sumrow[1];

			}

			$sumData{ $rows[1] }{ $rows[0] } = \@sumrow;
		}
		else {

			my @sumrow = ( 0, 0, 0, 0 );

			if ( $rows[2] eq 'Y' ) {
				$sumrow[2] = $rows[3];
				$sumrow[3] = $rows[4];
			}
			else {
				$sumrow[0] = $rows[3];
				$sumrow[1] = $rows[4];
			}

			$sumData{ $rows[1] }{ $rows[0] } = \@sumrow;
		}
	}

	foreach my $key ( keys %sumData ) {

		my @homeTot;
		my @roamTot;

		my @key2c = keys %{ $sumData{$key} };
		@key2c = sort { $a <=> $b } @key2c;

		for ( my $a = 0 ; $a < @key2c ; $a = $a + 1 ) {

			my ( $x1, $x2 ) = ( @{ $sumData{$key}{ $key2c[$a] } } )[ 0, 2 ];

			push @homeTot, $x1;
			push @roamTot, $x2;
		}

		if ( @homeTot > 10 ) {

			my ( $home_mean, $home_std ) = stdev( \@homeTot );
			my ( $roam_mean, $roam_std ) = stdev( \@roamTot );

			for ( my $a = 0 ; $a < @homeTot ; $a = $a + 1 ) {

				my $hper = analyze( $homeTot[$a], $home_mean, $home_std );
				my $rper = analyze( $roamTot[$a], $roam_mean, $roam_std );

				if (
					   ( $hper || $rper )
					&& ( $homeTot[$a] > 100 )
					&& (   ( $hper > 40 or $hper < -40 )
						|| ( $rper > 40 or $rper < -40 ) )
				  )
				{
					my $rows = [
						"$key2c[$a]",   "$key",
						"$homeTot[$a]", "$roamTot[$a]",
						"$home_mean",   "$roam_mean",
						"$home_std",    "$roam_std",
						"$hper",        "$rper"
					];

					if (   ( $hper < -100 || $hper > 100 )
						|| ( $rper < -100 || $rper > 100 ) )
					{
						$worksheet->write_row( $cntrow, 0, $rows, $bold );
					}
					else {
						$worksheet->write_row( $cntrow, 0, $rows );
					}
					$cntrow++;

				}

			}
		}
	}

	$conn->disconnect();

	$workbook->close;

	sendMail( $excel_file, $timeStamp );
}

sub analyze {

	my ( $total, $mean, $std ) = @_;

	if ( $mean == 0 ) {
		return (0);
	}
	elsif ( ( $total + $std ) < $mean ) {
		my $point = 100 * ( -1 * ( 1 - ( ( $total + $std ) / $mean ) ) );
		return ($point);
	}
	elsif ( ( $total - $std ) > $mean ) {
		my $point = ( 100 * ( ( ( $total - $std ) / $mean ) ) ) - 100;
		return ($point);
	}
	else { return (0); }

}

sub mean() {

	my $ptr   = shift;
	my @stats = @{$ptr};

	my $total = 0;
	foreach (@stats) {
		$total += $_;
	}

	my $mean = ceil( $total / @stats );
	return $mean;
}

sub stdev() {

	my $ptr   = shift;
	my @stats = @{$ptr};

	@stats = sort { $a <=> $b } @stats;

	my $mean = &mean( \@stats );    # calculate the mean or average

	if ( @stats == 1 ) {
		return ( $mean, 0 );
	}

	my $sqsum = 0;

	foreach (@stats) {
		$sqsum += ( $mean - $_ )**2;
	}

	my $stdev = ( $sqsum / ( @stats - 1 ) )**0.5;

	return ( $mean, $stdev );
}

sub sendMail() {

	my ( $excel_file, $date ) = @_;

	# my $to = 'ISBillingOperations@uscellular.com';
	my $mime_type = 'multipart/mixed';
	my $to        = 'david.balchen@uscellular.com';
	my $cc        = '';
	my $from      = 'USCDLISOps-BillingCycleManagement@uscellular.com';
	my $subject   = "IP Usage Check for $date";

	my $msg = MIME::Lite->new(
		From    => $from,
		To      => $to,
		Cc      => $cc,
		Subject => $subject,
		Type    => $mime_type
	) or die "Error creating " . "MIME body: $!\n";

	$msg->attach(
		Type     => 'application/octet-stream',
		Encoding => 'base64',
		Path     => $ENV{'REC_HOME'} . $excel_file,
		Filename => $excel_file
	) or die "Error attaching file: $!\n";

	$msg->send();
}

#sub getBODSPRD{
#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
#	unless (defined $dbods) {sendErr();}
#	return $dbods;
#}

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "9000#BooGoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

