#! /usr/local/bin/perl
# use strict;
use DBI;

#Test parameters remove when going to production.
#$ARGV[0] = "/inf_nas/apm1/prod/aprmoper/var/usc/DISP/DISP_RM_000139209_20180305_182400.ASC.done";

#For test only.....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";
#$ENV{'REC_HOME'}  = '/home/dbalchen/workspace/volteRoaming/src/bin';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
$ENV{'REC_HOME'} = '/apps/ebi/ebiap1/bin/roamRecon/';

my $filename = ( split( '/', $ARGV[0] ) )[-1];

my $disp_file_seq = ( split( '_', $filename ) )[2];

$disp_file_seq =~ s/^0+//g;

my $process_date = ( split( '_', $filename ) )[3];

my $dbconn = getBODSPRD();

#my $dbconnb = getSNDPRD();
my $dbconnb = $dbconn;

my $sql =
"select /*+ PARALLEL(t1,12) */  TAP_OUT_FILE_NAME, count(*), sum(Data_vol_incoming) + sum(Data_vol_outgoing),sum(TOT_NET_CHARGE_RC), carrier_cd,service_type  
from prm_rom_outcol_events_ap
 where  tap_out_file_name in (select /*+ PARALLEL(t1,12) */  TAP_OUT_FILE_NAME  from prm_rom_outcol_events_ap where disp_file_seq = $disp_file_seq group by TAP_OUT_FILE_NAME )
  group by TAP_OUT_FILE_NAME, carrier_cd,service_type ";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while ( my @rows = $sth->fetchrow_array() ) {

	my $total_charges_dch = '';
	my $total_records_dch = '';
	my $total_volume_dch  = '';

	if ( !$rows[0] ) {
		next;
	}

	else {

		
		$sql =
"delete from file_summary where FILE_NAME = '$rows[0]' and PROCESS_DATE = to_date($process_date,'YYYYMMDD') and usage_type = 'DISP_RM-$rows[5]'";
		$sthb = $dbconnb->prepare($sql);
		$sthb->execute() or sendErr();

		my $grep = " grep $rows[0] ";

		my $hh =
		  "cat $ENV{'REC_HOME'}/tnsOutcollect.csv | $grep | cut -f 9,10,24";

		my $output = `$hh`;
		chomp($output);
		$output =~ s/"//g;
		$output =~ s/,//g;

		my @dchValues = split( "\t", $output );
		chomp(@dchValues);

		$total_volume_dch = $dchValues[0];
		$total_charges_dch = $dchValues[2];
		$total_records_dch = $dchValues[1];

		if ( $total_volume_dch eq "" || $total_volume_dch eq "-" ) {
			$total_volume_dch = 0;
		}
		
		if ( $total_charges_dch eq "" || $total_charges_dch eq "-" ) {
			$total_charges_dch = 0;
		}

		if ( $total_records_dch eq "" || $total_records_dch eq "-" ) {
			$total_records_dch = 0;
		}

	}
	my $file_name_dch = $rows[0];

	my $usage_type = "DISP_RM-$rows[5]";
	
	$sql = "
INSERT INTO FILE_SUMMARY (
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
 $rows[1],
 $total_charges_dch,
  $rows[3],
 0,
 'USCC',
 0,
 0,
 '$rows[4]',
 to_date($process_date,'YYYYMMDD'),
 $disp_file_seq,
 'TAP',
 '$file_name_dch',
 '$rows[0]',
 0,
 0,
 0,
 0,
 0,
 $rows[1],
 $rows[3],
 0
)";

	$sthb = $dbconnb->prepare($sql);
	$sthb->execute() or sendErr();
}

# print $sql."\n";

$dbconnb->disconnect();
$dbconn->disconnect();

exit(0);

sub getBODSPRD {

	my $dbPwd = "BODS_DAV_BILLINGOPS";
	my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );

	#my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "9000#GooBoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getSNDPRD {
		
	my $dbPwd = "SND_SVC_BILLINGOPS";
	my $dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	# my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "9000#GooBoo");
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

