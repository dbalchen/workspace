#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
#For test only.....
# my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
# my $ORACLE_SID  = "bodsprd";
# $ENV{ORACLE_HOME} = $ORACLE_HOME;
# $ENV{ORACLE_SID}  = $ORACLE_SID;
# $ENV{PATH}  = "$ENV{PATH}:$ORACLE_HOME/bin";
#
#$ARGV[0] = 'NLDLT';
#$ARGV[1] = '20170707';

my $clearinghouse = 'TNS';
my %sqls          = {};

$sqls{'LTE'} = "
select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(charge_amount), sum(charge_parameter),
charge_type,max(exchange_rate) from prm_rom_incol_events_ap t1 where tap_in_file_name in (
select unique(file_name) from file_summary where usage_type like '%LTE%' and process_date = to_date($ARGV[1],'YYYYMMDD'))
and bp_start_date >= add_months(to_date(substr($ARGV[1],0,6),'YYYYMM'),-1)
group by carrier_cd, bp_start_date,charge_type";

$sqls{'NLDLT'} = "
select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(charge_amount), sum(charge_parameter),charge_type, max(exchange_rate) 
from prm_rom_incol_events_ap t1 where 
tap_in_file_name in (select unique(file_name) from file_summary where usage_type like '%NLDLT%' and process_date = to_date($ARGV[1],'YYYYMMDD'))
and bp_start_date >= add_months(to_date(substr($ARGV[1],0,6),'YYYYMM'),-1)
 group by carrier_cd, bp_start_date,charge_type
";

$sqls{'DISP_RM'} = "
select /*+ PARALLEL(t1,12) */ carrier_cd, bp_start_date, count(*), sum(tot_net_charge_lc), sum(charging_param) 
from prm_rom_outcol_events_ap t1 where tap_out_file_name in
(select unique(file_name) from file_summary where usage_type like '%DISP%' and process_date = to_date($ARGV[1],'YYYYMMDD'))
and bp_start_date >= add_months(to_date(substr($ARGV[1],0,6),'YYYYMM'),-1)
 group by carrier_cd, bp_start_date
";

if ( $ARGV[0] eq "NLDLT" ) {
	$clearinghouse = 'Syniverse';
}

my $dbconn = getBODSPRD();

#my $dbconnb = getSNDPRD();
my $dbconnb = $dbconn;

my $sqlT = "delete from APRM where usage_type like '$ARGV[0]" . '%'
  . "' and DATE_PROCESSED = to_date($ARGV[1],'YYYYMMDD') ";
$sthb = $dbconnb->prepare($sqlT);
$sthb->execute() or sendErr();

my $sql = $sqls{ $ARGV[0] };
my $sth = $dbconn->prepare($sql);

$sth->execute() or sendErr();

while ( my @rows = $sth->fetchrow_array() ) {

	my $total_volume_dch  = $rows[4];
	my $total_charges_dch = $rows[3];
	my $record_count_dch  = $rows[2];
	my $usage_type        = $ARGV[0] . "-" . $rows[5];

	my $exrate = 1;
	if ( $ARGV[0] ne 'DISP_RM' ) {
		$exrate = $rows[6];
	}

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
  '$usage_type',
   $total_volume_dch,
   $rows[4],
   $total_charges_dch,
   $rows[3]/$exrate,
   '00000',
   $record_count_dch,
   $rows[2],
   '$rows[0]',
   'TAP',
 to_date($ARGV[1],'YYYYMMDD'),
 '$clearinghouse',
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
	my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );

	# my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "9000#GooBoo");
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

