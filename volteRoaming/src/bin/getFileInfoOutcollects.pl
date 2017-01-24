#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
# $ARGV[0] = "/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output/CIBER_CIBER_20161113002356_383238_0027.dat.done";

# $ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';

# For test only.....
# my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
# my $ORACLE_SID  = "bodsprd";
# $ENV{ORACLE_HOME} = $ORACLE_HOME;
# $ENV{ORACLE_SID}  = $ORACLE_SID;
# $ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";


my $hh = "cat $ARGV[0] | grep '^22' | sort -u | cut -b 72-81,219-224,330-335 | $ENV{'REC_HOME'}/addMultiUp.pl";
my $ttemp = ""; $ttemp = `$hh`; chomp($ttemp);
my ($fileTotal,$filesum,$usage) = split("\t",$ttemp);

my $filename = (split('/',$ARGV[0]))[-1];
my $filename2 = $filename;
$filename2 =~ s/.done//;

my $dbconn = getBODSPRD();

my $dbconnb = getSNDPRD();

my $dateTime = substr($filename,index($filename,"R_2")+2,8);

my $sql = "delete from file_summary where FILE_NAME = '$filename2'";
my $sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql =
  "select file_name, identifier from ac1_control_hist where file_name like ?";

my $sth = $dbconn->prepare($sql);

$sth->bind_param( 1, $filename2 );
$sth->execute() or sendErr();
my @fileId = $sth->fetchrow_array();

$sql = "select /*+ PARALLEL(t1,12) */ 'APRM_SUCCESS', count(*), cast(sum(TOTAL_CHRG_AMOUNT) as decimal (18,2))
         from usc_roam_evnts t1 where generated_rec < 2 and prod_id = 3 
         and ciber_file_name_1|| ciber_file_name_2  = '$filename2'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my @aprm = $sth->fetchrow_array();

my $total_volume_dch = $usage;
my $total_records_dch = $fileTotal;
my $total_charges_dch = $filesum;
my $file_name_dch = $filename;

$sql = "
INSERT INTO ENTERPRISE_GEN_SANDBOX.FILE_SUMMARY (USAGE_TYPE, TOTAL_VOLUME_DCH, TOTAL_VOLUME, TOTAL_RECORDS_DCH, TOTAL_RECORDS, TOTAL_CHARGES_DCH, 
   TOTAL_CHARGES, TC_SEND, SENDER, REJECTED_COUNT, REJECTED_CHARGES, RECEIVER, PROCESS_DATE, IDENTIFIER, FILE_TYPE, FILE_NAME_DCH, FILE_NAME, DUPLICATES, 
   DROPPED_TC, DROPPED_RECORDS, DROPPED_APRM_CHARGES, DROPPED_APRM, APRM_TOTAL_RECORDS, APRM_TOTAL_CHARGES, APRM_DIFFERENCE) 
VALUES ( 
 'CIBER_CIBER',
  $total_volume_dch,
  $usage,
  $total_records_dch,
  $fileTotal,
  $total_charges_dch,
  $filesum,
  0,
  'USCC',
  0,
  0.00,
  'Syniverse',
 to_date($dateTime,'YYYYMMDD'),
 $fileId[1],
 'CIBER',
 '$file_name_dch',
 '$filename',
 0,
 0,
 0,
 0,
 0,
 $aprm[1],
 $aprm[2],
 0
)";

$sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();
$dbconnb->disconnect();
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

sub getSNDPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "BooG00900#" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}
