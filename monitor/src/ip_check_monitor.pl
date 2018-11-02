#!/usr/bin/env perl
#exit(0);

BEGIN {
	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );

  #	push( @INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5' );

}

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/monitor/src/';

#$ENV{'REC_HOME'} = '/apps/ebi/ebiap1/bin/IP_Check/';

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

# use strict;
use MIME::Lite;
use DBI;
use Spreadsheet::WriteExcel;
use FileHandle;
use Cwd qw(abs_path);
use POSIX;

#use List::Uniq ':all';

use List::Util qw(max maxstr min minstr product sum sum0);

scheduledTask();
exit(0);

sub scheduledTask {

	my ( $day, $month, $year ) = (localtime)[ 3, 4, 5 ];
	my $timeStamp =
	  1900 + $year . pad( $month + 1, '0', 2 ) . pad( $day, '0', 2 );

	chdir("$ENV{'REC_HOME'}");

	my $excel_file = "IPCheck_" . $timeStamp . '.xls';

	my $heading = [
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

	my $workbook  = Spreadsheet::WriteExcel->new($excel_file);
	my $worksheet = $workbook->add_worksheet("Oddities");

	my $bold = $workbook->add_format( bold => 1 );
	$worksheet->write( 'A1', $heading, $bold );

	#	my $conn = getBODSPRD();

	my $sql = "
	select to_char(start_time,'YYYYMMDD'),
       l9_ip_address,
       L9_NT_ROAMING_IND,
       count(*) as RECORDS,
       SUM(L3_VOLUME) as VOLUME
    From ape1_rated_event
    where L3_PAYMENT_CATEGORY = 'PRE'
     and l3_call_source in ('L',
                         'D')
     and start_time >= sysdate - 30
   group by to_char(start_time,'YYYYMMDD'),
         l9_ip_address,
         L9_NT_ROAMING_IND
   order by 2,
         1,
         3
	";

	#	$sth = $conn->prepare($sql);
	#	$sth->execute() or sendErr();

	my $ip      = "";
	my %sumData = {};

	#	while ( my @rows = $sth->fetchrow_array() ) {

	open( EVENT, "< /home/dbalchen/Desktop/event.csv" ) || exit(0);

	while ( my $buff = <EVENT> ) {
		chomp($buff);

		my @rows = split( "\t", $buff );

		if ( $ip ne $rows[1] ) {

			if ( $ip ne "" ) {

				# Calculate stats
				analyze( \%sumData );

				print "Woot";
			}
	        %sumData = {};
			$ip = $rows[1];
		}

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

	# Calculate stats

	#	$conn->disconnect();

	my $cntrow = 1;

	$workbook->close;

	#	sendMail( $excel_file, $timeStamp );

}

sub analyze {

	my ($raw) = shift;
	my %rawdata = %{$raw};

	my @home;
	my @roam;

	foreach my $key ( keys %rawdata ) {

		my @key2c = keys %{ $rawdata{$key} };

		@key2c = sort { $a <=> $b } @key2c;

		for ( my $a = 0 ; $a < @key2c ; $a = $a + 1 ) {

			my ( $x1, $x2 ) = ( @{ $rawdata{$key}{ $key2c[$a] } } )[ 0, 2 ];

			push @home, $x1;
			push @roam, $x2;
		}

	}

	if ( @home < 7 ) { return; }

	if ( ( max @home ) < 10000 and max @roam < 10000 ) { return; }

	descStats( \@home );

}

sub descStats {
	my $ptr  = shift;
	my @data = @{$ptr};

	@data = sort { $a <=> $b } @data;

	my $median = 0;
	( my $int, my $frac ) =
	  split( /\./, ( sprintf( "%1.5f", ( @data / 2 ) ) ), 2 );

	if ( $frac > 0 ) {
		$median = $data[$int];
	}
	else {
		$median = ( $data[$int] + $data[ $int - 1 ] ) / 2;
	}
	print "$median\n";

}

sub mean {

	my $ptr   = shift;
	my @stats = @{$ptr};

	my $total = 0;
	foreach (@stats) {
		$total += $_;
	}

	my $mean = ceil( $total / @stats );
	return $mean;
}

sub stdev {

	my $ptr   = shift;
	my @stats = @{$ptr};

	@stats = uniq(@stats);
	@stats = sort { $a <=> $b } @stats;

	if ( @stats > 7 ) {
		pop(@stats);
		shift(@stats);
	}

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

sub sendMail {

	my ( $excel_file, $date ) = @_;

	my $to        = 'ISBillingOperations@uscellular.com';
	my $mime_type = 'multipart/mixed';
	my $from      = 'david.balchen@uscellular.com';
	my $cc        = '';

	#my $from      = 'USCDLISOps-BillingCycleManagement@uscellular.com';
	my $subject = " IP Usage Check for $date ";

	my $msg = MIME::Lite->new(
		From    => $from,
		To      => $to,
		Cc      => $cc,
		Subject => $subject,
		Type    => $mime_type
	) or die " Error creating " . " MIME body : $! \n ";

	$msg->attach(
		Type     => 'application/octet-stream',
		Encoding => 'base64',
		Path     => $ENV{'REC_HOME'} . $excel_file,
		Filename => $excel_file
	) or die " Error attaching file : $! \n ";

	$msg->send();
}

sub getBODSPRD {

	#my $dbPwd = " BODS_SVC_BILLINGOPS ";
	#my 	$dbods = (DBI->connect(" DBI : Oracle : $dbPwd ",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "5000#Reptar" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub pad {

	my ( $padString, $padwith, $length ) = @_;

	while ( length($padString) < $length ) {
		$padString = $padwith . $padString;
	}

	return $padString;

}

