#! /usr/local/bin/perl
# use strict;
use DBI;

#Test parameters remove when going to production.
#$ARGV[0] = "/inf_nas/apm1/prod/aprmoper/var/usc/DISP/DISP_RM_000064260_20161026_023328.ASC.done";

# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";


my $hh = "wc -l < $ARGV[0]";

my $totalRecs = `$hh`;chomp($totalRecs);
my $filename = (split('/',$ARGV[0]))[-1];

my $disp_file_seq = (split('_',$filename))[2];

$disp_file_seq =~ s/^0+//g;


my $dbconn = getBODSPRD();
my $dbconnb = getSNDPRD();

my $sql = "delete from file_summary where IDENTIFIER = $disp_file_seq";
my $sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql = "delete from rejected_records where IDENTIFIER = $disp_file_seq";
$sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();


$sql = "select /*+ PARALLEL(t1,12) */  TAP_OUT_FILE_NAME, count(*), sum(Data_vol_incoming) + sum(Data_vol_incoming),sum(TOT_NET_CHARGE_RC)  from prm_rom_outcol_events_ap where disp_file_seq = $disp_file_seq group by TAP_OUT_FILE_NAME";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my $report = $filename.'.rpt.csv';

#open( RPT, ">$report" ) || errorExit("Could not open error file.... Fail!!!!");

#print RPT "$filename\t$disp_file_seq\t$totalRecs\n";

while (my @rows = $sth->fetchrow_array() ) {

    print RPT $rows[0]."\t".$disp_file_seq."\t"."\t".$rows[1]."\t".$rows[2]."\n";
    
my $file_name_dch = $argv[0];
my $total_volume_dch = $rows[2];
my $total_charges_dch = $argv[4];
my $total_records_dch =  $argv[3];

    
$sql = "
INSERT INTO ENTERPRISE_GEN_SANDBOX.FILE_SUMMARY (
USAGE_TYPE, 
TOTAL_VOLUME_DCH, 
TOTAL_VOLUME, 
TOTAL_RECORDS_DCH, 
TOTAL_RECORDS, 
TOTAL_CHARGES_DCH, 
TOTAL_CHARGES,
TC_SEND, SENDER, 
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
 'DISP_RM',
  $total_volume_dch,
  $rows[2],
 $total_records_dch,
 $argv[3],
 $total_charges_dch,
  $argv[4],
 0,
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
}

#close(RPT);

$dbconn->disconnect();

exit(0);


sub getBODSPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "BooG00900#" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

