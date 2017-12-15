#! /usr/local/bin/perl

use DBI;
use Time::Piece;
use Time::Seconds;

BEGIN {
	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );

   #push( @INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5' );
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$ARGV[0] = '20171201';

my $date = $ARGV[0];

my $sdate  = 0;
my $ldate  = 0;
my $period = '';

$period = Time::Piece->strptime( $date, "%Y%m%d" );
$period -= ONE_MONTH;

if ( substr( $date, 6, 2 ) eq '01' ) {

	$period += ONE_WEEK;
	$ldate = $period->strftime("%Y%m");
	$sdate = substr( $date, 0, 6 );
}
else {
	$ldate = $period->strftime("%Y%m");
	$sdate = substr( $date, 0, 6 );
}

$period = $period->strftime("%Y%m");

my %sqls = {};

$sqls{'LTE_INCOLLECT_CARRIER'} = '
  select nr_param_3_val "Company Code", decode(carrier_cd,'
  . "'USA6G','NEX-TECH Wireless', 'USASG', 'SPRINT', 'USAW6', 'T-MOBILE', 'NLDLT','Vodofone Netherland','USACG','ATT','USAVZ','VERIZON' )"
  . ' "Carrier", sum((TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(tot_net_usage_chrg) "Total Charges" '
  . "from IC_ACCUMULATED_USAGE  where prod_cat_id = 'IS' and BP_START_DATE = to_date('$period"
  . "01"
  . "','YYYYMMDD') group by nr_param_3_val, carrier_cd";

print "$sqls{'LTE_INCOLLECT_CARRIER'}\n";

$sqls{'LTE_OUTCOLLECT_CARRIER'} = '
  select nr_param_3_val "Company Code", decode(carrier_cd,'
  . "'USA6G','NEX-TECH Wireless', 'USASG', 'SPRINT', 'USAW6', 'T-MOBILE', 'NLDLT','Vodofone Netherland','USACG','ATT','USAVZ','VERIZON' )"
  . ' "Carrier", sum((TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(tot_net_usage_chrg) "Total Charges" '
  . "from IC_ACCUMULATED_USAGE  where prod_cat_id = 'OS' and BP_START_DATE = to_date('$period"
  . "01"
  . "','YYYYMMDD') group by nr_param_3_val, carrier_cd";

print "$sqls{'LTE_OUTCOLLECT_CARRIER'}\n";

$sqls{'CDMA_INCOLLECT_DATA_ACCRUAL'} = '
  select carrier_cd "Carrier Code", sum((TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(tot_net_usage_chrg) "Total Charges"'
  . "from IC_ACCUMULATED_USAGE  where prod_cat_id = 'IN' and BP_START_DATE = to_date('$period"
  . "16"
  . "','YYYYMMDD') and future_3 != 'Voice' and  sys_creation_date  < to_date('$sdate"
  . "01"
  . "','YYYYMMDD') group by carrier_cd order by Carrier_cd";

print "$sqls{'CDMA_INCOLLECT_DATA_ACCRUAL'}\n";

$sqls{'CDMA_INCOLLECT_DATA_SETTLEMENT'} = '
  select carrier_cd "Carrier Code", sum((TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(tot_net_usage_chrg) "Total Charges"'
  . "from IC_ACCUMULATED_USAGE  where prod_cat_id = 'IN' and BP_START_DATE = to_date('$period"
  . "16"
  . "','YYYYMMDD') and future_3 != 'Voice'  group by carrier_cd order by Carrier_cd";

print "$sqls{'CDMA_INCOLLECT_DATA_SETTLEMENT'}\n";

$sqls{'CDMA_INCOLLECT_DATA_ACCRUAL_CARRIER'} = '
  select t1.carrier_cd "Carrier Code", t2.carrier_name, sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(t1.tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE t1 ,  (select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2   where substr(t1.nr_param_2_val,0,3)  = t2.setlmnt_contract_cd '
  . " and t1.prod_cat_id = 'IN' and t1.BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD')  and t1.future_3 = 'Data' and  t1.sys_creation_date  < to_date('$sdate"
  . "01"
  . "','YYYYMMDD') group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name";

print "$sqls{'CDMA_INCOLLECT_DATA_ACCRUAL_CARRIER'}\n";

$sqls{'CDMA_INCOLLECT_DATA_SETTLEMENT_CARRIER'} = '
  select t1.carrier_cd "Carrier Code", t2.carrier_name, sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(t1.tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE t1 , (select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name  from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2   where substr(t1.nr_param_2_val,0,3)  = t2.setlmnt_contract_cd '
  . " and t1.prod_cat_id = 'IN' and t1.BP_START_DATE = to_date('$period". "16". "','YYYYMMDD')  and t1.future_3 = 'Data' group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name";

print "$sqls{'CDMA_INCOLLECT_DATA_SETTLEMENT_CARRIER'}\n";

$sqls{'CDMA_INCOLLECT_VOICE_ACCRUAL'} = '
  select carrier_cd "Carrier Code",'
  . "'6002201'"
  . ' "GL Account", sum(TOT_CHRG_PARAM_VAL) "Total Usage Minutes", sum(tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE  where prod_cat_id = '
  . "'IN' and BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD') and future_3 = 'Voice' and sys_creation_date  < to_date('$sdate"
  . "01"
  . "','YYYYMMDD') group by carrier_cd order by Carrier_cd";

print "$sqls{'CDMA_INCOLLECT_VOICE_ACCRUAL'}\n";

$sqls{'CDMA_INCOLLECT_VOICE_SETTLEMENT'} = '
  select carrier_cd "Carrier Code",'
  . "'6002201'"
  . ' "GL Account", sum(TOT_CHRG_PARAM_VAL) "Total Usage Minutes", sum(tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE  where prod_cat_id = '
  . "'IN' and BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD') and future_3 = 'Voice' group by carrier_cd order by Carrier_cd";

print "$sqls{'CDMA_INCOLLECT_VOICE_ACCRUAL'}\n";

$sqls{'CDMA_INCOLLECT_VOICE_ACCRUAL_CARRIER'} = '
  select  t1.carrier_cd "Carrier Code", t2.carrier_name, sum(t1.TOT_CHRG_PARAM_VAL) "Total Usage Minutes", sum(t1.tot_net_usage_chrg) "Total Charges" from IC_ACCUMULATED_USAGE t1 , (select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2   where substr(t1.nr_param_2_val,0,3)  = t2.setlmnt_contract_cd '
  ."and t1.prod_cat_id = 'IN' and t1.BP_START_DATE = to_date('$period". "16". "','YYYYMMDD')  and t1.future_3 = 'Voice' and  t1.sys_creation_date  < '01-DEC-2017' group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name";

print "$sqls{'CDMA_INCOLLECT_VOICE_ACCRUAL_CARRIER'}\n";

# $sqls{'CDMA_OUTCOLLECT_DATA_ACCRUAL'} = '


exit(0);

