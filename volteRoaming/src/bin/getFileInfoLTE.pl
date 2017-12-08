#! /usr/local/bin/perl
# use strict;
use DBI;

#Test parameters remove when going to production.
$ARGV[0] = "CDUSAW6USAUD08442,8442,T-Mobile (USAW6),99999,9112.79000,1,.1,20171124";
#
## For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';

#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon2/';

my @argv = split( /,/, $ARGV[0] );

my $dbconn = getBODSPRD();

#my $dbconnb = getSNDPRD();
my $dbconnb = $dbconn;

my $sql    = '';
my $prefix = "LTE";

my $exrate = 1;

if ( index( $argv[0], "NLDLT" ) >= 0 ) {
	$prefix = "NLDLT";
}

$sql = "delete from file_summary where FILE_NAME = '$argv[0]'";

my $sthb = $dbconnb->prepare($sql);
#sthb->execute() or sendErr();

$sql = "delete from rejected_records where FILE_NAME = '$argv[0]'";

$sthb = $dbconnb->prepare($sql);
# thb->execute() or sendErr();

$sql =
"select s_444, error_code, error_desc,cast(S_402 as decimal(19,9)) from em1_record where stream_name='INC' and record_status<>55 and s_444='$argv[0]'";

my $sth = $dbconn->prepare($sql);
# $sth->execute() or sendErr();

while ( my @rows = $sth->fetchrow_array() ) {
	$sql = "Insert into REJECTED_RECORDS (
   TOTAL_CHARGE, FILE_NAME, ERROR_TYPE, ERROR_DESCRIPTION, ERROR_CODE) 
VALUES ( 
  $rows[3],
 '$rows[0]',
 'REJECTED',
 '$rows[2]',
 '$rows[1]')";

	$sthb = $dbconnb->prepare($sql);
#	$sthb->execute() or sendErr();
}

$sql =
"select /*+ PARALLEL(t1,12) */ count(*), sum(charge_amount),sum(charge_parameter),charge_type  from  prm_rom_incol_events_ap t1 where tap_in_file_name = '$argv[0]' group by charge_type";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while ( my @rows = $sth->fetchrow_array() ) {
	for ( my $i = 0 ; $i < @rows ; $i = $i + 1 ) {
		if ( $rows[$i] eq "" ) {
			$rows[$i] = 0;
		}
	}

	my $dropped = ( $argv[3] - $argv[5] );

	my $usage_type        = $prefix . '-' . $rows[3];
	my $file_name_dch     = "";
	my $total_charges_dch = "";
	my $total_records_dch = "";
	my $total_volume_dch  = "";

	my $grep = "";

	if ( $prefix eq "NLDLT" ) {

		$file_name_dch = substr( $argv[0], 2 );
		$grep = " grep $file_name_dch | ";

		if ( index( $usage_type, "-C" ) >= 0 ) {
			$grep = $grep . " grep SMS";
		}
		elsif ( index( $usage_type, "-V" ) >= 0 ) {
			$grep = $grep . " grep GPRS";
		}
		else {
			$grep = $grep . " grep Voice";
		}

		my $hh =
"cat $ENV{'REC_HOME'}/IncollectDCH_GSM.csv | $grep | cut -f 9,10,11,12 ";
		my $output = `$hh`;
		chomp($output);

		my @dchValues = split( "\t", $output );
		chomp(@dchValues);

		$total_charges_dch = $dchValues[2];
		$total_records_dch = $dchValues[3];

		if ( index( $usage_type, "-C" ) >= 0 ) {
			$total_volume_dch = $rows[2];
		}
		elsif ( index( $usage_type, "-V" ) >= 0 ) {
			$total_volume_dch = $dchValues[1] * 1024;
		}
		else {
			$total_volume_dch = $dchValues[0] * 60;
		}

	}
	else {
		$file_name_dch = $argv[0];
		$grep          = " grep $file_name_dch ";
		my $hh =
		  "cat $ENV{'REC_HOME'}/tnsIncollect.csv | $grep | cut -f 9,10,24";

		my @output = `$hh`;
		if ( @output > 1 ) {
			$output[0] = $output[1];
		}

		chomp(@output);
		$output[0] =~ s/"//g;
		$output[0] =~ s/,//g;

		my @dchValues = split( "\t", $output[0] );
		chomp(@dchValues);

		$total_volume_dch  = $rows[2];
		$total_charges_dch = $dchValues[2];
		$total_records_dch = $dchValues[1];

	}

	$sql = " INSERT INTO FILE_SUMMARY (
USAGE_TYPE, 
TOTAL_VOLUME_DCH, 
TOTAL_VOLUME, 
TOTAL_RECORDS_DCH, 
TOTAL_RECORDS, 
TOTAL_CHARGES_DCH, 
TOTAL_CHARGES,
TC_SEND, 
SENDER,
REJECTED_COUNT, 
REJECTED_CHARGES, 
RECEIVER, 
PROCESS_DATE, 
IDENTIFIER, 
FILE_TYPE, 
FILE_NAME_DCH, 
FILE_NAME, 
DUPLICATES, 
DROPPED_TC, 
DROPPED_RECORDS, 
DROPPED_APRM_CHARGES, 
DROPPED_APRM, 
APRM_TOTAL_RECORDS, 
APRM_TOTAL_CHARGES, 
APRM_DIFFERENCE
) 
VALUES ( 
 '$usage_type',
  $total_volume_dch,
  $rows[2],
 $total_records_dch,
 $rows[0],
 $total_charges_dch,
  $rows[1],
 $rows[0],
 '$argv[2]',
 $argv[5],
 $argv[6],
 'USCC',
 to_date($argv[7],'YYYYMMDD'),
 $argv[1],
 'TAP',
 '$file_name_dch',
 '$argv[0]',
 0,
 0,
 0,
 0,
 0,
 $rows[0],
 $rows[1],
 $dropped
)";

	#print $sql. "\n";

	$sthb = $dbconnb->prepare($sql);
	$sthb->execute() or sendErr();
}

$dbconnb->disconnect();
$dbconn->disconnect();

exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "9000#BooGoo");
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getSNDPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "Reptar5000#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

