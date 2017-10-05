#!/usr/bin/env perl

BEGIN {
	#push(@INC, '/home/common/eps/perl_lib/lib/perl5/');
	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
}

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/monitor/src/';

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

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

# my $cron = new Schedule::Cron(\&scheduledTask,processprefix=>"ac1_control_volume_monitor");
# my $time = "0 4 * * *";
# $cron->add_entry($time);
# $cron->run(detach=>1,pid_file=>"ac1_control_volume_monitor_pid");

sub scheduledTask() {
	chdir("$ENV{'REC_HOME'}");
	my $path    = abs_path . "/";
	my $archive = "$path" . "archive/";
	my $date1   = `date +%Y%m%d%H%M`;
	chomp $date1;
	my $date2 = `date --date="1 days ago" +"%Y%m%d"`;
	chomp $date2;
	my $time = `date +%H%M`;
	chomp $time;
	my $conn = getBODSPRD();

	my $sql =
"select trunc(start_time), L3_PAYMENT_CATEGORY, L9_NT_ROAMING_IND, L9_NETWORK_FLAG, count(*) as RECORDS, SUM(L3_VOLUME) as VOLUME, SUM(L9_DOWNLINK_VOLUME) as DL_VOLUME, SUM(L9_UPLINK_VOLUME) as UL_VOLUME From ape1_rated_event where L3_PAYMENT_CATEGORY = 'PRE' and  l3_call_source in ('L','D') and start_time > sysdate - 7 group by trunc(start_time), L3_PAYMENT_CATEGORY, L9_NT_ROAMING_IND,L9_NETWORK_FLAG order by 1,2";

	my $sth = $conn->prepare($sql);
	$sth->execute() or sendErr();

	my %sumData       = {};
	my $totalRoamRecs = 0;
	my $totalHomeRecs = 0;
	my $totalRoamVol  = 0;
	my $totalHomeVol  = 0;

	while ( my @rows = $sth->fetchrow_array() ) {

		if ( defined $sumData{ $rows[0] } ) {

			my @sumrow = @{ $sumData{ $rows[0] } };

			if ( $rows[2] eq 'Y' ) {
				$totalRoamRecs = $rows[4];
				$totalRoamVol  = $rows[5];
				$totalHomeRecs = $sumrow[4];
				$totalHomeVol  = $sumrow[5];
			}
			else {
				$totalHomeRecs = $rows[4];
				$totalHomeVol  = $rows[5];
				$totalRoamRecs = $sumrow[4];
				$totalRoamVol  = $sumrow[5];
			}

			print
"$rows[0]	$totalRoamRecs	$totalHomeRecs 	$totalRoamVol 	$totalHomeVol\n";

		}
		else {
			$sumData{ $rows[0] } = \@rows;
		}
	}

	$sql =
"select trunc(start_time), l9_ip_address,L9_NT_ROAMING_IND,  count(*) as RECORDS, SUM(L3_VOLUME) as VOLUME, SUM(L9_DOWNLINK_VOLUME) as DL_VOLUME, SUM(L9_UPLINK_VOLUME) as UL_VOLUME From ape1_rated_event  where L3_PAYMENT_CATEGORY = 'PRE' and  l3_call_source in ('L','D') and start_time > sysdate - 7 group by trunc(start_time), l9_ip_address,L9_NT_ROAMING_IND order by 1,2,3";

	$sth = $conn->prepare($sql);
	# $sth->execute() or sendErr();

	while ( my @rows = $sth->fetchrow_array() ) {

	}

	# sendMail();

	#	cleanUp();
	$conn->disconnect();
}

sub mean() {
	my $total = 0;
	foreach (@stats) {
		$total += $_;
	}
	my $mean = ceil( $total / $#stats );
	return $mean;
}

sub stdev() {
	if ( $#stats == 1 ) {
		return 0;
	}
	my $mean  = &mean($stats);    # calculate the mean or average
	my $sqsum = 0;
	for (@stats) {
		$sqsum += ( ( $_ - $mean )**2 )
		  ;    # calculate the variance, take each difference, square it...
	}
	$sqsum /= $#stats;    # average the result
	my $stdev = ceil( sqrt($sqsum) )
	  ;    # calculate standard deviation, take the square root of variance
	       # print "$extid\t mean: $mean\t stdev: $stdev\n";
	return $stdev;
}

sub volumeChart() {
	@exid5 = @exid;
	my $workbook = Spreadsheet::WriteExcel->new($xlsout)
	  or die "failed to create new workbook: $!";
	my $worksheet = $workbook->add_worksheet();
	my $bold      = $workbook->add_format( bold => 1 );
	my $font      = $workbook->add_format( font => 'Arial 8' );
	$worksheet->write_row( 0, 0, [ '', '' ], $font );
	my $chart1  = 1;
	my $cntsht  = 1;
	my $cntrow  = 0;
	my $cntcol  = 0;
	my $cntdata = 0;
	$extid = shift(@exid5);

	while ($extid) {
		foreach (@xlsin) {
			my @x = split( ',', $xlsin[$cntdata] );
			if ( $extid eq $x[0] ) {
				my @cols = split( ',', $xlsin[$cntdata] );
				my @fix_cols = grep( s/\s*$//g, @cols );
				$worksheet->write_row( $cntrow, $cntcol, \@fix_cols );
				$cntrow++;
				$cntdata++;
			}
		}
		$cntrow = 0;
		$cntcol = $cntcol + 3;
		$extid  = shift(@exid5);
	}
	@exid5 = @exid;
	my $x = $#exid * 3 + 3;
	my @columns;
	for ( my $i = 1 ; $i <= $x ; $i++ ) {
		push( (@columns), ( &num2alpha($i) ) );
	}
	my $font = $workbook->add_format( font => 'Arial 8' );
	foreach $chrt (@exid) {
		$chart1 = $workbook->add_chart( type => 'line', name => $chrt );
		$extid = shift(@exid5);
		my $scaler = join( ",", @xlsin );
		my $cntrow = () = $scaler =~ /$extid/g;
		my $column = shift @columns;
		$column = shift @columns;
		my $c        = '!' . $column . '$2:';
		my $x_values = '=Sheet' . "$cntsht" . $c . $column . '$' . "$cntrow";
		$column   = shift @columns;
		$c        = '!' . $column . '$2:';
		$y_values = '=Sheet' . "$cntsht" . $c . $column . '$' . "$cntrow";
		$chart1->add_series(
			categories => $x_values,
			values     => $y_values,
			name       => $externalId{$chrt},
		);
		$chart1->set_title( name => 'USAGE RECORD VOLUME', );    # record count
		$chart1->set_x_axis( name => 'DATE', );
		$chart1->set_y_axis( name => 'COUNT', );
		$chart1++;
	}
	$cntsht++;
}

sub sendMail() {

	# my $to = 'ISBillingOperations@uscellular.com';
	my $to      = 'david.smith@uscellular.com';
	my $cc      = '';
	my $from    = 'USCDLISOps-BillingCycleManagement@uscellular.com';
	my $subject = "AC1_CONTROL Record Volume Monitor Report for $date1";

	my $msg = MIME::Lite->new(
		From    => $from,
		To      => $to,
		Cc      => $cc,
		Subject => $subject,
		Data    => $af_out
	);

	$msg->attach(
		Type => "application/vnd.ms-excel",

		# Type => "text/plain",
		Path        => $path . $xlsout1,
		Filename    => $xlsout1,
		Disposition => "attachment"
	);

	$msg->send();
}

sub sendErr() {

	# my $to = 'ISBillingOperations@uscellular.com';
	my $to      = 'david.balchen@uscellular.com';
	my $cc      = '';
	my $from    = 'USCDLISOps-BillingCycleManagement@uscellular.com';
	my $subject = "AC1_CONTROL Record Volume Monitor Report FAILED!";
	my $message .=
"Failed to create AC1_CONTROL Record Volume Monitor Report for $date!: $!, $?, $@\n";
	$message .= print "File: ", __FILE__, " Line: ", __LINE__, "\n";
	$message .= warn("ac1_control_volume_monitor.pl");

	my $msg = MIME::Lite->new(
		From    => $from,
		To      => $to,
		Cc      => $cc,
		Subject => $subject,
		Data    => $message
	);

	$msg->send();

	exit;
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

sub cleanUp() {
	chdir("/home/common/eps/ac1/");
	$cmd = "mv ac1*volume*xls $archive";
	system($cmd);
}
