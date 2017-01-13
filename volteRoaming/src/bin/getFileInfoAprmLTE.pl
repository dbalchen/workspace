#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production. 
# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}  = "$ENV{PATH}:$ORACLE_HOME/bin";

my %sqls = {};

$sqls{'LTE'} = "select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(charge_amount), sum(charge_parameter),charge_type from prm_rom_incol_events_ap t1 where process_date = to_date($ARGV[1],'YYYYMMDD') and carrier_cd != 'NLDLT' group by carrier_cd, bp_start_date,charge_type";

$sqls{'NLDLT'} = "select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(charge_amount), sum(charge_parameter),charge_type from prm_rom_incol_events_ap t1 where process_date = to_date($ARGV[1],'YYYYMMDD') and carrier_cd = 'NLDLT' group by carrier_cd, bp_start_date,charge_type";

$sqls{'DISP_RM'} = "select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(tot_net_charge_lc), sum(charging_param) from prm_rom_outcol_events_ap t1 where process_date = to_date($ARGV[1],'YYYYMMDD') and carrier_cd != 'NLDLT' group by carrier_cd, bp_start_date";

my $dbconn = getBODSPRD();
my $dbconnb = getSNDPRD();

my $sqlT = "delete from APRM where DATE_PROCESSED = to_date($ARGV[1],'YYYYMMDD')";
$sthb = $dbconnb->prepare($sqlT);
$sthb->execute() or sendErr();

my $sql = $sqls{$ARGV[0]};
my $sth = $dbconn->prepare($sql);

$sth->execute() or sendErr();

#my $filename = $ARGV[0].$ARGV[1].'.arpm.csv';
    
#open( RPT, ">$filename" ) || errorExit("Report Failed!!!!");

while (my @rows = $sth->fetchrow_array() ) {

  #    print RPT "$rows[0]\t$rows[1]\t$rows[2]\t$rows[3]\t$rows[4]\t$rows[5]\n";

  my $total_volume_dch = $rows[4];
  my $total_charges_dch = $rows[3];
  my $record_count_dch = $rows[2];
  my $usage_type = $ARGV[0]."-".$rows[5];
  $sql = "
  INSERT INTO ENTERPRISE_GEN_SANDBOX.APRM (
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
  '$usage_type',
   $total_volume_dch,
   $rows[4],
   $total_charges_dch,
   $rows[3],
   '00000',
   $record_count_dch,
   $rows[2],
   '$rows[0]',
   'TAP',
 to_date($ARGV[1],'YYYYMMDD'),
 'TNS',
  '$rows[0]',
  '$rows[1]'
)";

  $sthb = $dbconnb->prepare($sql);
  $sthb->execute() or sendErr();
}

# close(RPT);

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
