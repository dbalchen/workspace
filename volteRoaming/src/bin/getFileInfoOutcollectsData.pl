#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
#$ARGV[0] = "20170112";

# For test only.....
# my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
# $ENV{ORACLE_HOME} = $ORACLE_HOME;
# $ENV{ORACLE_SID}  = $ORACLE_SID;
# $ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";


my $dbconn = getBRMPRD();
#my $dbconnb = getSNDPRD();
my $dbconnb = getBODSPRD();

my $sql = "delete from file_summary where usage_type = 'DATA_CIBER' and process_date = to_date($ARGV[0],'YYYYMMDD')";

my $sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql = "delete from aprm where usage_type = 'DATA_CIBER' and date_processed = to_date($ARGV[0],'YYYYMMDD')";
$sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql = "select count(*), t2.clearinghouse, sum(t1.amount) as REVENUE, sum(message_accounting_digits) as DATA_VOLUME 
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and t1.process_date = to_date($ARGV[0],'YYYYMMDD') group by t2.clearinghouse";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while (my @rows = $sth->fetchrow_array() ) {

  my $total_volume_dch = $rows[3];
  my $total_records_dch =  $rows[0];
  my $total_charges_dch = $rows[2];

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
 'DATA_CIBER',
  $total_volume_dch,
  $rows[3],
 $total_records_dch,
 $rows[0],
 $total_charges_dch,
  $rows[2],
 0,
 'USCC',
 0,
 0,
 '$rows[1]',
 to_date($ARGV[0],'YYYYMMDD'),
 0,
 'DATA',
 'Online Data',
 'Online Data',
 0,
 0,
 0,
 0,
 0,
 $rows[0],
 $rows[2],
 0
)";

  $sthb = $dbconnb->prepare($sql);
  $sthb->execute() or sendErr();
}

$sql = "select TRIM(REGEXP_REPLACE(t1.PARTNER,',')) as PARTNER, ADD_MONTHS(t1.settlement_date+1,-1),t2.clearinghouse, sum(t1.amount) as REVENUE, sum(message_accounting_digits) as DATA_VOLUME, count(*) 
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and t1.process_date = to_date('$ARGV[0]','YYYYMMDD') group by TRIM(REGEXP_REPLACE(t1.PARTNER,',')),t2.clearinghouse, t1.settlement_date order by 1,2";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while (my @rows = $sth->fetchrow_array() ) {
  my $total_volume_dch = $rows[4];
  my $total_charges_dch = $rows[3];
  my $record_count_dch = $rows[5];

  $sql = "
  INSERT INTO APRM (
   USAGE_TYPE, 
   TOTAL_VOLUME_DCH, 
   TOTAL_VOLUME, 
   TOTAL_CHARGES_DCH, 
   TOTAL_CHARGES, 
   SERVE_BID, 
   RECORD_COUNT_DCH, 
   RECORD_COUNT, 
   MARKET_CODE, 
   FILE_TYPE, 
   DATE_PROCESSED, 
   CLEARINGHOUSE, 
   CARRIER_CODE, 
   BP_START_DATE
) 
VALUES ( 
  'DATA_CIBER',
   $total_volume_dch,
   $rows[4],
   $total_charges_dch,
   $rows[3],
   '00000',
   $record_count_dch,
   $rows[5],
   '$rows[0]',
   'Data',
 to_date($ARGV[0],'YYYYMMDD'),
  '$rows[2]',
  '$rows[0]',
  '$rows[1]'
)";

  $sthb = $dbconnb->prepare($sql);
  $sthb->execute() or sendErr();
}

$dbconnb->disconnect();
$dbconn->disconnect();


exit(0);

sub getBRMPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:brmprd", "md1dbal1", "BooGoo900#" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

sub getSNDPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "BooGoo900#" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

sub getBODSPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "BooGoo900#" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}
