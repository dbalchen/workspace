#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
$ARGV[0] = "SDIRI_FCIBER";
$ARGV[1] = '20170103';
# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $filetype = $ARGV[0].'%'.$ARGV[1].'%';

my $dbconn = getBODSPRD();
my $dbconnb = getSNDPRD();

# clean up Database

my $sql = "delete from APRM where DATE_PROCESSED = to_date($ARGV[1],'YYYYMMDD')";
$sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql = 'select /*+ PARALLEL(h1,12) */ home_company, carrier_cd, bp_start_date, count(*), sum(usage),sum(TOTAL_CHRG_AMOUNT) from USC_ROAM_EVNTS where (ciber_file_name_1||ciber_file_name_2 like '."'".$filetype."') and generated_rec < 2 group by home_company, carrier_cd, bp_start_date order by home_company";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();


my $filename = $ARGV[0].$ARGV[1].'.arpm.csv';
    
# open( RPT, ">$filename" ) || errorExit("Report Failed!!!!");

while (my @rows = $sth->fetchrow_array() ) {

#  print RPT "$rows[0]\t$rows[1]\t$rows[2]\t$rows[3]\t$rows[4]\t$rows[5]\n";

  $sql = "
INSERT INTO ENTERPRISE_GEN_SANDBOX.APRM (
   USAGE_TYPE, 
TOTAL_VOLUME, 
TOTAL_CHARGES, 
   RECORD_COUNT, 
MARKET_CODE, 
FILE_TYPE, 
   DATE_PROCESSED, 
CLEARINGHOUSE, 
CARRIER_CODE, 
   BP_START_DATE) 
VALUES ( 
 '$ARGV[0]', 
 $rows[4],  
 $rows[5],
 $rows[3],
 '$rows[1]',
 'CIBER',
 to_date($ARGV[1],'YYYYMMDD'),
 'SYNIVERSE',
 '$rows[0]',
 '$rows[2]'
)";


#  DCH #

  my $total_volume_dch = $rows[4];
  my $total_charges_dch = $rows[5];
  my $record_count_dch = $rows[3];

  $sql = "
  INSERT INTO ENTERPRISE_GEN_SANDBOX.APRM (
   USAGE_TYPE, TOTAL_VOLUME_DCH, TOTAL_VOLUME, 
   TOTAL_CHARGES_DCH, TOTAL_CHARGES, SERVE_BID, 
   RECORD_COUNT_DCH, RECORD_COUNT, MARKET_CODE, 
   FILE_TYPE, DATE_PROCESSED, CLEARINGHOUSE, 
   CARRIER_CODE, BP_START_DATE) 
VALUES ( 
  '$ARGV[0]',
   $total_volume_dch,
   $rows[4],
   $total_charges_dch,
   $rows[5],
   '00000',
   $record_count_dch,
   $rows[3],
   '$rows[1]',
   'CIBER',
 to_date($ARGV[1],'YYYYMMDD'),
 'SYNIVERSE',
  '$rows[0]',
  '$rows[2]'
)";

  $sthb = $dbconnb->prepare($sql);
  $sthb->execute() or sendErr();

}

#close(RPT);
$dbconn->disconnect();
$dbconnb->disconnect();

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

sub getSNDPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "BooG00900#" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}
