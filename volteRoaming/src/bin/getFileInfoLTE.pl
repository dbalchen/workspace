#! /usr/local/bin/perl
# use strict;
use DBI;

#Test parameters remove when going to production.
# $ARGV[0] = "20161003";

# For test only.....
# my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
# $ENV{ORACLE_HOME} = $ORACLE_HOME;
# $ENV{ORACLE_SID}  = $ORACLE_SID;
# $ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my @argv = split(/,/,@ARGV[0]);

my $prefix = "LTE";

if (index($argv[0],"NLDLT") >= 0) {
  $prefix = "NLDLT";
}

my $dbconn = getBODSPRD();
my $dbconnb = getSNDPRD();

my $sql = "delete from file_summary where FILE_NAME = '$argv[0]'";
my $sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql = "delete from rejected_records where FILE_NAME = '$argv[0]'";
$sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql = "select s_444, error_code, error_desc,cast(S_402 as decimal(19,9)) from em1_record where stream_name='INC' and record_status<>55 and s_444='$argv[0]'";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while (my @rows = $sth->fetchrow_array() ) {
  $sql = "
INSERT INTO ENTERPRISE_GEN_SANDBOX.REJECTED_RECORDS (
   TOTAL_CHARGE, FILE_NAME, ERROR_TYPE, ERROR_DESCRIPTION, ERROR_CODE) 
VALUES ( 
  $rows[3],
 '$rows[0]',
 'REJECTED',
 '$rows[2]',
 '$rows[1]'
)";

  $sthb = $dbconnb->prepare($sql);
  $sthb->execute() or sendErr();
}

$sql = "select /*+ PARALLEL(t1,12) */ count(*), sum(charge_amount),sum(charge_parameter),charge_type  from  prm_rom_incol_events_ap t1 where tap_in_file_name = '$argv[0]' group by charge_type";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while (my @rows = $sth->fetchrow_array() ) {
for (my $i = 0; $i < @rows; $i = $i + 1) {
  if ($rows[$i] eq "") {
    $rows[$i] = 0;
  }
}


my $dropped = ($argv[3] - $argv[5]);
my $file_name_dch = $argv[0];
my $total_volume_dch = $rows[2];
my $total_charges_dch = $rows[1];
my $total_records_dch =  $rows[0];;
my $usage_type = $prefix.'-'.$rows[3];

$sql = "
INSERT INTO ENTERPRISE_GEN_SANDBOX.FILE_SUMMARY (
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
  $argv[4],
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

$sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();
}

$dbconnb->disconnect();
$dbconn->disconnect();


exit(0);

sub getBODSPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "BooG00900#" );
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

