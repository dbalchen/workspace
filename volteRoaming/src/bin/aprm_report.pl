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

$ARGV[0] = '20180122';

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

$sqls{'LTE_INCOLLECT_SETTLEMENT'} = "
select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date", t1.nr_param_3_val "Company Code",'
.' sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(t1.tot_net_usage_chrg) "Total Charges",'
  . "'6008001', nvl((select sum(au_charge)  from  USC_SAP_EXTRACT_V where Au_Prod_Cat_Id = 'IS' and  "
  . " Au_Bp_Start_Date = to_date('$period"
  . "01','YYYYMMDD')"
  . " and GL_ACCOUNT = 6008001"
  . ' and carrier_cd = t1.nr_param_3_val) ,0) "Data Charges",'
  . " '6008002', nvl((select sum(au_charge)  from  USC_SAP_EXTRACT_V where Au_Prod_Cat_Id = 'IS' "
  . " and  Au_Bp_Start_Date = to_date('$period"
  . "01','YYYYMMDD')"
  . " and GL_ACCOUNT = 6008002 and carrier_cd = t1.nr_param_3_val) ,0) "
  . ' "VoLTE Charges" from IC_ACCUMULATED_USAGE t1 '
  . " where t1.prod_cat_id = 'IS' and t1.BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')"
  . " group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val order by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val";

$sqls{'LTE_INCOLLECT_CARRIER'} = '
  select nr_param_3_val "Company Code", decode(carrier_cd,'
  . "'USA6G','NEX-TECH Wireless', 'USASG', 'SPRINT', 'USAW6', 'T-MOBILE', 'NLDLT','Vodofone Netherland','USACG','ATT','USAVZ','VERIZON' )"
  . ' "Carrier", sum((TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(tot_net_usage_chrg) "Total Charges" '
  . "from IC_ACCUMULATED_USAGE  where prod_cat_id = 'IS' and BP_START_DATE = to_date('$period"
  . "01"
  . "','YYYYMMDD') group by nr_param_3_val, carrier_cd order by nr_param_3_val, carrier_cd";
  
$sqls{'LTE_OUTCOLLECT_CARRIER'} = '
  select nr_param_3_val "Company Code", decode(carrier_cd,'
  . "'USA6G','NEX-TECH Wireless', 'USASG', 'SPRINT', 'USAW6', 'T-MOBILE', 'NLDLT','Vodofone Netherland','USACG','ATT','USAVZ','VERIZON' )"
  . ' "Carrier", sum((TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(tot_net_usage_chrg) "Total Charges" '
  . "from IC_ACCUMULATED_USAGE  where prod_cat_id = 'OS' and BP_START_DATE = to_date('$period"
  . "01"
  . "','YYYYMMDD') group by nr_param_3_val, carrier_cd order by nr_param_3_val, carrier_cd";

$sqls{'LTE_OUTCOLLECT_SETTLEMENT'} = "
select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date", t1.nr_param_3_val "Company Code",'
  .' sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(t1.tot_net_usage_chrg) "Total Charges",'
  . "'5438001', nvl((select sum(au_charge)  from  USC_SAP_EXTRACT_V where Au_Prod_Cat_Id = 'OS' and  "
  . " Au_Bp_Start_Date = to_date('$period"
  . "01','YYYYMMDD')"
  . " and GL_ACCOUNT = 5438001"
  . ' and carrier_cd = t1.nr_param_3_val) ,0) "Data Charges",'
  . " '5438002', nvl((select sum(au_charge)  from  USC_SAP_EXTRACT_V where Au_Prod_Cat_Id = 'OS' "
  . " and  Au_Bp_Start_Date = to_date('$period"
  . "01','YYYYMMDD')"
  . " and GL_ACCOUNT = 5438002 and carrier_cd = t1.nr_param_3_val) ,0) "
  . ' "VoLTE Charges" from IC_ACCUMULATED_USAGE t1 '
  . " where t1.prod_cat_id = 'OS' and t1.BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')"
  . " group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val order by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val";

$sqls{'GSM_INCOLLECT_SETTLEMENT'} = "
select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date", t1.nr_param_3_val "Company Code",'
  .' decode(t1.carrier_cd, '
  . "'USA6G','NEX-TECH Wireless', 'USASG', 'SPRINT', 'USAW6', 'T-MOBILE', 'NLDLT','Vodofone Netherland')"
  . '"Carrier",'
  . "'6008001', sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024)"
  . ' "Total Usage MB",  sum(tot_net_usage_chrg) "Data Charges SDR", '
  . "'6002202', (nvl((select sum(TOT_CHRG_PARAM_VAL)   from IC_ACCUMULATED_USAGE  where prod_cat_id = 'II' and BP_START_DATE = '01-DEC-2017' and rate_plan_cd = 'RPINCGSMSMSCD' and  t1.nr_param_3_val =   nr_param_3_val)	,0)) "
  . ' "Total Texts" ,'
  . " (nvl((select  sum(tot_net_usage_chrg)   from IC_ACCUMULATED_USAGE  where prod_cat_id = 'II' and BP_START_DATE = '01-DEC-2017' and rate_plan_cd = 'RPINCGSMSMSCD' and  t1.nr_param_3_val =   nr_param_3_val)  ,0)) "
  . '"Text Charges" , '
  . "'6002201',(nvl((select sum(TOT_CHRG_PARAM_VAL)   from IC_ACCUMULATED_USAGE  where prod_cat_id = 'II' and BP_START_DATE = '01-DEC-2017' and rate_plan_cd = 'RPINCGSMVOICETOTCD' and  t1.nr_param_3_val =   nr_param_3_val),0)) "
  . '"Total Minutes",'
  . "(nvl(   (select  sum(tot_net_usage_chrg)   from IC_ACCUMULATED_USAGE  where prod_cat_id = 'II' and BP_START_DATE = '01-DEC-2017' and rate_plan_cd = 'RPINCGSMVOICETOTCD' and  t1.nr_param_3_val =   nr_param_3_val),0)) "
  . ' "Voice Charges" '
  . " from IC_ACCUMULATED_USAGE t1 where prod_cat_id = 'II' and BP_START_DATE = '01-DEC-2017' and  rate_plan_cd = 'RPINCGSMDATACD' group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val, t1.carrier_cd order by  to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val";

$sqls{'CDMA_INCOLLECT_DATA_ACCRUAL'} = "
select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date", carrier_cd "Carrier Code",'
  . " '6008001',"
  . 'sum((TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(tot_net_usage_chrg) "Total Charges"'
  . "from IC_ACCUMULATED_USAGE t1 where prod_cat_id = 'IN' and BP_START_DATE = to_date('$period"
  . "16"
  . "','YYYYMMDD') and future_3 != 'Voice' and  sys_creation_date  < to_date('$sdate"
  . "01"
  . "','YYYYMMDD') group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.carrier_cd   order by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.carrier_cd";

$sqls{'CDMA_INCOLLECT_DATA_ACCRUAL_CARRIER'} = '
  select t1.carrier_cd "Carrier Code", t2.carrier_name, sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(t1.tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE t1 ,  (select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2   where substr(t1.nr_param_2_val,0,3)  = t2.setlmnt_contract_cd '
  . " and t1.prod_cat_id = 'IN' and t1.BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD')  and t1.future_3 = 'Data' and  t1.sys_creation_date  < to_date('$sdate"
  . "01"
  . "','YYYYMMDD') group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name";

$sqls{'CDMA_INCOLLECT_VOICE_ACCRUAL'} = "
select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date", carrier_cd "Carrier Code",'
  . "'6002201'"
  . ' "GL Account", sum(TOT_CHRG_PARAM_VAL) "Total Usage Minutes", sum(tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE t1 where prod_cat_id = '
  . "'IN' and BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD') and future_3 = 'Voice' and sys_creation_date  < to_date('$sdate"
  . "01"
  . "','YYYYMMDD') group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),carrier_cd order by to_char(t1.sys_creation_date,'YYYY-MM-DD'),Carrier_cd";

$sqls{'CDMA_INCOLLECT_VOICE_ACCRUAL_CARRIER'} = '
  select t1.carrier_cd "Carrier Code", t2.carrier_name, sum((t1.TOT_CHRG_PARAM_VAL)) "Total Usage Minutes", sum(t1.tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE t1 ,  (select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2   where substr(t1.nr_param_2_val,0,3)  = t2.setlmnt_contract_cd '
  . " and t1.prod_cat_id = 'IN' and t1.BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD')  and t1.future_3 = 'Voice' and  t1.sys_creation_date  < to_date('$sdate"
  . "01"
  . "','YYYYMMDD') group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name";

$sqls{'CDMA_OUTCOLLECT_VOICE_ACCRUAL'} = "
select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date",t1.carrier_cd "Carrier Code",'
  . " '5430001' "
  . ' "GL Account",sum(t1.tot_chrg_param_val) "Total Usage Minutes", sum(t1.tot_net_usage_chrg) "Total Air Charges",'
  . "'5410101' "
  . ' "GL Account Toll",nvl('
  . "(select sum(tot_net_usage_chrg) from ic_accumulated_usage where prod_cat_id = 'RO' and bp_start_date = to_date('$period"
  . "16 ','YYYYMMDD') and future_3 = 'Voice' "
  . " and rate_plan_cd = 'RPOUROTOLL' and carrier_cd = t1.carrier_cd  and  to_char(sys_creation_date,'YYYY-MM-DD') =  to_char(t1.sys_creation_date,'YYYY-MM-DD') ),0)"
  . ' "Total Toll Charges",'
  . " '4080401' "
  . ' "GL Account Tax",nvl('
  . "(select sum(tot_net_usage_chrg) from ic_accumulated_usage where prod_cat_id = 'RO' and bp_start_date = to_date('$period"
  . "16 ','YYYYMMDD') and future_3 = 'Voice'  
           and rate_plan_cd = 'RPROUROTAX' and carrier_cd = t1.carrier_cd  and  to_char(sys_creation_date,'YYYY-MM-DD') =  to_char(t1.sys_creation_date,'YYYY-MM-DD') ),0)"
  . ' "Total Tax Charges" '
  . "from ic_accumulated_usage t1 where prod_cat_id = 'RO' and bp_start_date = to_date('$period"
  . "16 ','YYYYMMDD') and future_3 = 'Voice'  and t1.rate_plan_cd = 'RPOUROAIR' "
  . " and  t1.sys_creation_date  < to_date('$sdate" . "01"
  . "','YYYYMMDD')"
  . " group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.carrier_cd   order by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.carrier_cd";

$sqls{'CDMA_OUTCOLLECT_VOICE_ACCRUAL_CARRIER'} = '
select  t1.carrier_cd "Carrier Code", t2.carrier_name,  t1.rate_plan_cd "Rate Plan",'
  . "decode( t1.rate_plan_cd,'RPOUROAIR','5430001','RPOUROTOLL','5410101','RPROUROTAX','4080401')"
  . '"GL Account", sum(t1.tot_chrg_param_val) "Total Usage Minutes", sum(t1.tot_net_usage_chrg) "Total Charges"  from ic_accumulated_usage t1,'
  . "(select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2 "
  . " where substr(t1.nr_param_1_val,0,3)  = t2.setlmnt_contract_cd and "
  . " prod_cat_id = 'RO' and bp_start_date = '16-DEC-2017' and future_3 = 'Voice'  and t1.rate_plan_cd != 'RPOUROTOT' and  t1.sys_creation_date  < to_date('$sdate"
  . "01"
  . "','YYYYMMDD')"
  . " group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name, t1.rate_plan_cd "
  . "order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name, t1.rate_plan_cd";

# CDMA Settlement

$sqls{'CDMA_INCOLLECT_DATA_SETTLEMENT'} = "
  select to_char(sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date",'
  . 'carrier_cd "Carrier Code",'
  . "'6008001' "
  . ' "GL Account",'
  . 'sum((TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(tot_net_usage_chrg) "Total Charges"'
  . "from IC_ACCUMULATED_USAGE  where prod_cat_id = 'IN' and BP_START_DATE = to_date('$period"
  . "16"
  . "','YYYYMMDD') and future_3 != 'Voice'  group by to_char(sys_creation_date,'YYYY-MM-DD'),carrier_cd order by  to_char(sys_creation_date,'YYYY-MM-DD'),Carrier_cd";

$sqls{'CDMA_INCOLLECT_DATA_SETTLEMENT_CARRIER'} = '
  select t1.carrier_cd "Carrier Code", t2.carrier_name, sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB", sum(t1.tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE t1 , (select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name  from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2   where substr(t1.nr_param_2_val,0,3)  = t2.setlmnt_contract_cd '
  . " and t1.prod_cat_id = 'IN' and t1.BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD')  and t1.future_3 = 'Data' group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name";

$sqls{'CDMA_INCOLLECT_VOICE_SETTLEMENT'} = "
  select  to_char(sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date",'
  . 'carrier_cd "Carrier Code",'
  . "'6002201' "
  . ' "GL Account", sum(TOT_CHRG_PARAM_VAL) "Total Usage Minutes", sum(tot_net_usage_chrg) "Total Charges"  from IC_ACCUMULATED_USAGE  where prod_cat_id = '
  . "'IN' and BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD') and future_3 = 'Voice' group by to_char(sys_creation_date,'YYYY-MM-DD'),carrier_cd order by  to_char(sys_creation_date,'YYYY-MM-DD'),Carrier_cd";

$sqls{'CDMA_INCOLLECT_VOICE_SETTLEMENT_CARRIER'} = '
  select  t1.carrier_cd "Carrier Code", t2.carrier_name, sum(t1.TOT_CHRG_PARAM_VAL) "Total Usage Minutes", sum(t1.tot_net_usage_chrg) "Total Charges" from IC_ACCUMULATED_USAGE t1 , (select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2   where substr(t1.nr_param_2_val,0,3)  = t2.setlmnt_contract_cd '
  . "and t1.prod_cat_id = 'IN' and t1.BP_START_DATE = to_date('$period" . "16"
  . "','YYYYMMDD')  and t1.future_3 = 'Voice' group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name";

$sqls{'CDMA_OUTCOLLECT_VOICE_SETTLEMENT_CARRIER'} = '
select  t1.carrier_cd "Carrier Code", t2.carrier_name,  t1.rate_plan_cd "Rate Plan",'
  . "decode( t1.rate_plan_cd,'RPOUROAIR','5430001','RPOUROTOLL','5410101','RPROUROTAX','4080401')"
  . '"GL Account", sum(t1.tot_chrg_param_val) "Total Usage Minutes", sum(t1.tot_net_usage_chrg) "Total Charges"  from ic_accumulated_usage t1,'
  . "(select setlmnt_contract_cd, max(Sid_Commercial_Name) carrier_name from pc9_sid group by setlmnt_contract_cd order by setlmnt_contract_cd)  t2 "
  . " where substr(t1.nr_param_1_val,0,3)  = t2.setlmnt_contract_cd and "
  . " prod_cat_id = 'RO' and bp_start_date = to_date('$period" . "16"
  . " ','YYYYMMDD') and future_3 = 'Voice'  and t1.rate_plan_cd != 'RPOUROTOT' "
  . " group by carrier_cd, Nr_Param_2_Val, t2.Carrier_Name, t1.rate_plan_cd "
  . "order by Carrier_cd, Nr_Param_2_Val, t2.Carrier_Name, t1.rate_plan_cd";

$sqls{'CDMA_OUTCOLLECT_VOICE_SETTLEMENT'} = "
select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date",t1.carrier_cd "Carrier Code",'
  . " '5430001' "
  . ' "GL Account",sum(t1.tot_chrg_param_val) "Total Usage Minutes", sum(t1.tot_net_usage_chrg) "Total Air Charges",'
  . "'5410101' "
  . ' "GL Account Toll",nvl('
  . "(select sum(tot_net_usage_chrg) from ic_accumulated_usage where prod_cat_id = 'RO' and bp_start_date = to_date('$period"
  . "16 ','YYYYMMDD') and future_3 = 'Voice' "
  . " and rate_plan_cd = 'RPOUROTOLL' and carrier_cd = t1.carrier_cd  and  to_char(sys_creation_date,'YYYY-MM-DD') =  to_char(t1.sys_creation_date,'YYYY-MM-DD') ),0)"
  . ' "Total Toll Charges",'
  . " '4080401' "
  . ' "GL Account Tax",nvl('
  . "(select sum(tot_net_usage_chrg) from ic_accumulated_usage where prod_cat_id = 'RO' and bp_start_date = to_date('$period"
  . "16 ','YYYYMMDD') and future_3 = 'Voice'  
           and rate_plan_cd = 'RPROUROTAX' and carrier_cd = t1.carrier_cd  and  to_char(sys_creation_date,'YYYY-MM-DD') =  to_char(t1.sys_creation_date,'YYYY-MM-DD') ),0)"
  . ' "Total Tax Charges" '
  . "from ic_accumulated_usage t1 where prod_cat_id = 'RO' and bp_start_date = to_date('$period"
  . "16 ','YYYYMMDD') and future_3 = 'Voice'  and t1.rate_plan_cd = 'RPOUROAIR' 
 group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.carrier_cd   order by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.carrier_cd";

my $dbconn  = getBODSPRD();
my $dbconnb = getBRMPRD();

my @aprmArray = ();

if ( substr( $date, 6, 2 ) eq '01' ) {

	@aprmArray = (
		'LTE_INCOLLECT_SETTLEMENT',
		'LTE_INCOLLECT_CARRIER',
		'LTE_OUTCOLLECT_SETTLEMENT',
		'LTE_OUTCOLLECT_CARRIER',
		'GSM_INCOLLECT_SETTLEMENT',
		'CDMA_INCOLLECT_DATA_ACCRUAL',
		'CDMA_INCOLLECT_DATA_ACCRUAL_CARRIER',
		'CDMA_INCOLLECT_VOICE_ACCRUAL',
		'CDMA_INCOLLECT_VOICE_ACCRUAL_CARRIER',
		'CDMA_OUTCOLLECT_VOICE_ACCRUAL',
		'CDMA_OUTCOLLECT_VOICE_ACCRUAL_CARRIER'
	);

}
else {
	@aprmArray = (
#		'CDMA_INCOLLECT_VOICE_SETTLEMENT',
#		'CDMA_INCOLLECT_VOICE_SETTLEMENT_CARRIER',
#		'CDMA_INCOLLECT_DATA_SETTLEMENT',
#		'CDMA_INCOLLECT_DATA_SETTLEMENT_CARRIER',
		'CDMA_OUTCOLLECT_VOICE_SETTLEMENT',
		'CDMA_OUTCOLLECT_VOICE_SETTLEMENT_CARRIER'
	);
}

readAprm( \@aprmArray, $dbconn, $dbconnb, $date );

$dbconn->disconnect();
$dbconnb->disconnect();

exit(0);

sub readAprm {
	my ( $sqlList, $conn, $conn2, $timeStamp ) = @_;

	my $excel_file = "Aprm_" . $timeStamp . '.xls';
	my $workbook   = Spreadsheet::WriteExcel->new($excel_file);

	my %tab = {};

	$tab{'CDMA_INCOLLECT_VOICE_SETTLEMENT'} = "CDMA Voice Incollect Settlement";

	$tab{'CDMA_INCOLLECT_VOICE_SETTLEMENT_CARRIER'} =
	  "CDMA Voice Incollect by Carrier";

	$tab{'CDMA_INCOLLECT_DATA_SETTLEMENT'} = "CDMA Data Incollect Settlement";

	$tab{'CDMA_INCOLLECT_DATA_SETTLEMENT_CARRIER'} =
	  "CDMA Data Incollect by Carrier";

	$tab{'CDMA_OUTCOLLECT_VOICE_SETTLEMENT'} =
	  "CDMA Voice Outcollect Settlment";

	$tab{'CDMA_OUTCOLLECT_VOICE_SETTLEMENT_CARRIER'} =
	  "Voice Outcollect by Carrier";

	$tab{'LTE_INCOLLECT_SETTLEMENT'} = "LTE Incollect Settlement";

	$tab{'LTE_INCOLLECT_CARRIER'} = "LTE Incollect by Carrier";

	$tab{'LTE_OUTCOLLECT_SETTLEMENT'} = "LTE Outcollect Settlement";

	$tab{'LTE_OUTCOLLECT_CARRIER'} = "LTE Outcollect by Carrier";

	$tab{'GSM_INCOLLECT_SETTLEMENT'} = "GSM Incollect Settlement";

	$tab{'CDMA_INCOLLECT_VOICE_ACCRUAL'} = "CDMA Voice Incollect Accrual";

	$tab{'CDMA_INCOLLECT_VOICE_ACCRUAL_CARRIER'} =
	  "CDMA Voice Incollect by Carrier";

	$tab{'CDMA_INCOLLECT_DATA_ACCRUAL'} = "CDMA Data Incollect Accrual";

	$tab{'CDMA_INCOLLECT_DATA_ACCRUAL_CARRIER'} =
	  "CDMA Data Incollect by Carrier";

	$tab{'CDMA_OUTCOLLECT_VOICE_ACCRUAL'} = "CDMA Voice Outcollect Accrual";

	$tab{'CDMA_OUTCOLLECT_VOICE_ACCRUAL_CARRIER'} =
	  "Voice Outcollect by Carrier";

	my %headings = {};

	$headings{'CDMA_INCOLLECT_VOICE_SETTLEMENT'} = [
		'Creation Date',
		'Carrier Code',
		'GL Account',
		'Total Usage Minutes',
		'Total Charges'
	];

	$headings{'CDMA_INCOLLECT_VOICE_SETTLEMENT_CARRIER'} =
	  [ 'Carrier Code', 'Carrier Name', 'Total Usage Minutes',
		'Total Charges' ];

	$headings{'CDMA_INCOLLECT_DATA_SETTLEMENT'} = [
		'Creation Date',
		'Carrier Code',
		'GL Account',
		'Total Usage MB',
		'Total Charges'
	];

	$headings{'CDMA_INCOLLECT_DATA_SETTLEMENT_CARRIER'} =
	  [ 'Carrier Code', 'Carrier Name', 'Total Usage MB', 'Total Charges' ];

	$headings{'CDMA_OUTCOLLECT_VOICE_SETTLEMENT'} = [
		'Creation Date',
		'Carrier Code',
		'GL Account',
		'Total Usage Minutes',
		'Total Charges Air',
		'GL Account Toll',
		'Total Charges Toll',
		'GL Account Tax',
		'Total Charges Tax'
	];

	$headings{'CDMA_OUTCOLLECT_VOICE_SETTLEMENT_CARRIER'} = [
		'Carrier Code',
		'CARRIER_NAME',
		'Rate Plan',
		'GL Account',
		'Total Usage Minutes',
		'Total Charges'
	];

	$headings{'CDMA_INCOLLECT_VOICE_ACCRUAL'} = [
		'Creation Date',
		'Carrier Code',
		'GL Account',
		'Total Usage Minutes',
		'Total Charges'
	];

	$headings{'CDMA_INCOLLECT_VOICE_ACCRUAL_CARRIER'} =
	  [ 'Carrier Code', 'Carrier Name', 'Total Usage Minutes',
		'Total Charges' ];

	$headings{'CDMA_INCOLLECT_DATA_ACCRUAL'} = [
		'Creation Date',
		'Carrier Code',
		'GL Account',
		'Total Usage MB',
		'Total Charges'
	];

	$headings{'CDMA_INCOLLECT_DATA_ACCRUAL_CARRIER'} =
	  [ 'Carrier Code', 'Carrier Name', 'Total Usage MB', 'Total Charges' ];

	$headings{'CDMA_OUTCOLLECT_VOICE_ACCRUAL'} = [
		'Creation Date',
		'Carrier Code',
		'GL Account',
		'Total Usage Minutes',
		'Total Charges Air',
		'GL Account Toll',
		'Total Charges Toll',
		'GL Account Tax',
		'Total Charges Tax'
	];

	$headings{'CDMA_OUTCOLLECT_VOICE_ACCRUAL_CARRIER'} = [
		'Carrier Code',
		'CARRIER_NAME',
		'Rate Plan',
		'GL Account',
		'Total Usage Minutes',
		'Total Charges'
	];

	$headings{'GSM_INCOLLECT_SETTLEMENT'} = [
		'Creation Date',
		'Company Code',
		'Carrier',
		'DATA GL',
		'Total Usage MB',
		'Data Charges',
		'TEXT GL',
		'Total Texts',
		'Text Charges',
		'VOICE GL',
		'Total Minutes',
		'Voice Charges'
	];

	$headings{'LTE_INCOLLECT_SETTLEMENT'} = [
		'Creation Date',
		'Carrier Code',
		'Total Usage MB',
		'Total Charges',
		'GL Data',
		'Data Charges',
		'GL VoLTE',
		'VoLTE Charges'
	];
	$headings{'LTE_INCOLLECT_CARRIER'} = [
		'Carrier Code',
		'Carrier',
		'Total Usage MB',
		'Total Charges'
	];

	$headings{'LTE_OUTCOLLECT_SETTLEMENT'} = [
		'Creation Date',
		'Carrier Code',
		'Total Usage MB',
		'Total Charges',
		'GL Data',
		'Data Charges',
		'GL VoLTE',
		'Total Charges'
	];
	$headings{'LTE_OUTCOLLECT_CARRIER'} = [
		'Carrier Code',
		'Carrier',
		'Total Usage MB',
		'Total Charges'
	];

	foreach my $wsql ( @{$sqlList} ) {

		my $worksheet = $workbook->add_worksheet( $tab{$wsql} );
		my $bold = $workbook->add_format( bold => 1 );
		$worksheet->write( 'A1', $headings{$wsql}, $bold );

		my $sth = '';
		my $sql = $sqls{$wsql};

		print "$sql\n";

		if (   ( $wsql eq 'CDMA_A_OUT_DATA' )
			|| ( $wsql eq 'CDMA_S_OUT_DATA' ) )
		{
			$sth = $conn2->prepare($sql);
			$sth->execute() or sendErr();
		}

		else {

			$sth = $conn->prepare($sql);
			$sth->execute() or sendErr();

		}

		my $cntrow = 1;
		while ( my @rows = $sth->fetchrow_array() ) {
			my @fix_cols = grep( s/\s*$//g, @rows );

			$worksheet->write_row( $cntrow, 0, \@fix_cols );
			$cntrow++;
		}

	}
	$workbook->close;

}

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "#5000Reptar" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getBRMPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:brmprd", "md1dbal1", "#5000Reptar" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

