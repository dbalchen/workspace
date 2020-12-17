#! /usr/local/bin/perl

use DBI;
use Time::Piece;
use Time::Seconds;

BEGIN {
	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

# For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$ENV{'REC_HOME'} = '/apps/ebi/ebiap1/bin/roamRecon/';

#$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin/';

#$ARGV[0] = '20190205';

my $date = $ARGV[0];

my $sdate  = 0;
my $ldate  = 0;
my $period = '';

$period = Time::Piece->strptime( $date, "%Y%m%d" );

my $monthname = $period->strftime("%B");
my $yearname  = $period->strftime("%Y");
my $yearmonth = $period->strftime("%Y-%m");

$period -= ONE_MONTH;

my $yearmonthOld = $period->strftime("%Y-%m");

if ( substr( $date, 6, 2 ) eq '05' ) {

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

$sqls{'LTE_INCOLLECT_SETTLEMENT'} =
    "select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date",'
  . " t1.nr_param_3_val "
  . '"Company Code",'
  . 'sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB",'
  . 'sum(t1.tot_net_usage_chrg) "Total Charges",'
  . "'6008001'," . "nvl((
select sum(tot_net_usage_chrg) from IC_ACCUMULATED_USAGE  where prod_cat_id = 'IS' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')"
  . "and to_char(sys_creation_date,'YYYY-MM-DD') = to_char(t1.sys_creation_date,'YYYY-MM-DD') and nr_param_3_val = t1.nr_param_3_val and rate_plan_cd != 'RPINCVoLTEDATCD'
 ) ,0)" . '"Data Charges",' . "'6008002', 
nvl((
select sum(tot_net_usage_chrg) from IC_ACCUMULATED_USAGE  where prod_cat_id = 'IS' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')"
  . " and to_char(sys_creation_date,'YYYY-MM-DD') = to_char(t1.sys_creation_date,'YYYY-MM-DD') and nr_param_3_val = t1.nr_param_3_val and rate_plan_cd = 'RPINCVoLTEDATCD'
) ,0)"
  . ' "VoLTE Charges" '
  . "from IC_ACCUMULATED_USAGE t1  where t1.prod_cat_id = 'IS' and t1.BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')"
  . " group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val order by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val";

$sqls{'LTE_INCOLLECT_CARRIER'} = '
  SELECT t1.nr_param_3_val "Company Code",
         DECODE (t1.carrier_cd,'
  . "            'USAAT', 'ATT Mobility (USAAT)',
                 'USABS', 'ATT Mobility (USABS)',
                 'USACC', 'ATT Mobility (USACC)',
                 'USACG', 'ATT Mobility (USACG)',
                 'USAMF', 'ATT Mobility (USAMF)',
                 'USAPB', 'ATT Mobility (USAPB)',
                 'USAKY', 'Appalachian Wireless (USAKY)',
                 'USACM', 'C-Spire (USACM)',
                 'USA1E', 'Carolina West (USA1E)',
                 'USAXC', 'Inland (USAXC)',
                 'USAJV', 'James Valley (USAJV)',
                 'USA6G', 'Nex-Tech Wireless (USA6G)',
                 'USAPI', 'Pioneer Cellular (USAPI)',
                 'USASG', 'Sprint (USASG)',
                 'USASP', 'Sprint (USASP)',
                 'USASU', 'Sprint (USASU)',
                 'USATM', 'T-Mobile (USATM)',
                 'USAW6', 'T-Mobile (USAW6)',
                 'USAUW', 'United Wireless (USAUW)',
                 'USAVZ', 'Verizon (USAVZ)',
                 'AAZVF', 'Vodafone Malta (AAZVF)',
                 'MLTTL', 'Vodafone Malta (MLTTL)',
                 'NLDLT', 'Vodafone Netherlands (NLDLT)')
           " . ' "Carrier",
         NVL (
             (SELECT SUM ( (TOT_CHRG_PARAM_VAL / 1024) / 1024)
                FROM IC_ACCUMULATED_USAGE t3
               WHERE     prod_cat_id = ' . "'IS'" . "
                     AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
                     AND rate_plan_cd != 'RPINCVoLTEDATCD'
                     AND t1.carrier_cd = t3.carrier_cd
                     AND t1.nr_param_3_val = t3.nr_param_3_val),
             0)" . '
             "Total LTE Usage MB",
         NVL (
             (SELECT SUM (tot_net_usage_chrg) tuc
                FROM IC_ACCUMULATED_USAGE t4
               WHERE     prod_cat_id = ' . "'IS'" . "
                     AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
                     AND rate_plan_cd != 'RPINCVoLTEDATCD'
                     AND t1.carrier_cd = t4.carrier_cd
                     AND t1.nr_param_3_val = t4.nr_param_3_val),
             0)" . '
             "Total LTE Charges",
         NVL (
             (SELECT SUM ( (TOT_CHRG_PARAM_VAL / 1024) / 1024)
                FROM IC_ACCUMULATED_USAGE t2
               WHERE     prod_cat_id = ' . "'IS'" . "
                     AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
                     AND rate_plan_cd = 'RPINCVoLTEDATCD'
                     AND t1.carrier_cd = t2.carrier_cd
                     AND t1.nr_param_3_val = t2.nr_param_3_val),
             0)" . '
             "Total VoLTE Usage MB",
         NVL (
             (SELECT SUM (tot_net_usage_chrg) tuc
                FROM IC_ACCUMULATED_USAGE t3
               WHERE     prod_cat_id = ' . "'IS'" . "
                     AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
                     AND rate_plan_cd = 'RPINCVoLTEDATCD'
                     AND t1.carrier_cd = t3.carrier_cd
                     AND t1.nr_param_3_val = t3.nr_param_3_val),
             0)" . '
             "Total VoLTE Charges"
    FROM IC_ACCUMULATED_USAGE t1
   WHERE     prod_cat_id = ' . "'IS'" . "
         AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
GROUP BY nr_param_3_val, carrier_cd
ORDER BY nr_param_3_val, carrier_cd";

$sqls{'LTE_OUTCOLLECT_CARRIER'} = '
  SELECT t1.nr_param_3_val "Company Code",
         DECODE (t1.carrier_cd,'
  . "            'USAAT', 'ATT Mobility (USAAT)',
                 'USABS', 'ATT Mobility (USABS)',
                 'USACC', 'ATT Mobility (USACC)',
                 'USACG', 'ATT Mobility (USACG)',
                 'USAMF', 'ATT Mobility (USAMF)',
                 'USAPB', 'ATT Mobility (USAPB)',
                 'USAKY', 'Appalachian Wireless (USAKY)',
                 'USACM', 'C-Spire (USACM)',
                 'USA1E', 'Carolina West (USA1E)',
                 'USAXC', 'Inland (USAXC)',
                 'USAJV', 'James Valley (USAJV)',
                 'USA6G', 'Nex-Tech Wireless (USA6G)',
                 'USAPI', 'Pioneer Cellular (USAPI)',
                 'USASG', 'Sprint (USASG)',
                 'USASP', 'Sprint (USASP)',
                 'USASU', 'Sprint (USASU)',
                 'USATM', 'T-Mobile (USATM)',
                 'USAW6', 'T-Mobile (USAW6)',
                 'USAUW', 'United Wireless (USAUW)',
                 'USAVZ', 'Verizon (USAVZ)',
                 'AAZVF', 'Vodafone Malta (AAZVF)',
                 'MLTTL', 'Vodafone Malta (MLTTL)',
                 'NLDLT', 'Vodafone Netherlands (NLDLT)')
           " . ' "Carrier",
         NVL (
             (SELECT SUM ( (TOT_CHRG_PARAM_VAL / 1024) / 1024)
                FROM IC_ACCUMULATED_USAGE t3
               WHERE     prod_cat_id = ' . "'OS'" . "
                     AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
                     AND rate_plan_cd not like 'RPOUTSVoLTE%'
                     AND t1.carrier_cd = t3.carrier_cd
                     AND t1.nr_param_3_val = t3.nr_param_3_val),
             0)" . '
             "Total LTE Usage MB",
         NVL (
             (SELECT SUM (tot_net_usage_chrg) tuc
                FROM IC_ACCUMULATED_USAGE t4
               WHERE     prod_cat_id = ' . "'OS'" . "
                     AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
                     AND rate_plan_cd not like 'RPOUTSVoLTE%'
                     AND t1.carrier_cd = t4.carrier_cd
                     AND t1.nr_param_3_val = t4.nr_param_3_val),
             0)" . '
             "Total LTE Charges",
         NVL (
             (SELECT SUM ( (TOT_CHRG_PARAM_VAL / 1024) / 1024)
                FROM IC_ACCUMULATED_USAGE t2
               WHERE     prod_cat_id = ' . "'OS'" . "
                     AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
                     AND rate_plan_cd like 'RPOUTSVoLTE%'
                     AND t1.carrier_cd = t2.carrier_cd
                     AND t1.nr_param_3_val = t2.nr_param_3_val),
             0)" . '
             "Total VoLTE Usage MB",
         NVL (
             (SELECT SUM (tot_net_usage_chrg) tuc
                FROM IC_ACCUMULATED_USAGE t3
               WHERE     prod_cat_id = ' . "'OS'" . "
                     AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
                     AND rate_plan_cd like 'RPOUTSVoLTE%'
                     AND t1.carrier_cd = t3.carrier_cd
                     AND t1.nr_param_3_val = t3.nr_param_3_val),
             0)" . '
             "Total VoLTE Charges"
    FROM IC_ACCUMULATED_USAGE t1
   WHERE     prod_cat_id = ' . "'OS'" . "
         AND BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')" . "
GROUP BY nr_param_3_val, carrier_cd
ORDER BY nr_param_3_val, carrier_cd";

$sqls{'LTE_OUTCOLLECT_SETTLEMENT'} =
    "select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date",'
  . " t1.nr_param_3_val "
  . '"Company Code",'
  . 'sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024) "Total Usage MB",'
  . 'sum(t1.tot_net_usage_chrg) "Total Charges",'
  . "'5438001'," . "nvl((
select sum(tot_net_usage_chrg) from IC_ACCUMULATED_USAGE  where prod_cat_id = 'OS' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')"
  . "and to_char(sys_creation_date,'YYYY-MM-DD') = to_char(t1.sys_creation_date,'YYYY-MM-DD') and nr_param_3_val = t1.nr_param_3_val and rate_plan_cd not like 'RPOUTSVoLTE%'
 ) ,0)" . '"Data Charges",' . "'5438002', 
nvl((
select sum(tot_net_usage_chrg) from IC_ACCUMULATED_USAGE  where prod_cat_id = 'OS' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')"
  . " and to_char(sys_creation_date,'YYYY-MM-DD') = to_char(t1.sys_creation_date,'YYYY-MM-DD') and nr_param_3_val = t1.nr_param_3_val and rate_plan_cd like 'RPOUTSVoLTE%'
) ,0)"
  . ' "VoLTE Charges" '
  . " from IC_ACCUMULATED_USAGE t1  where t1.prod_cat_id = 'OS' and t1.BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD')"
  . " group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val order by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val";

$sqls{'GSM_INCOLLECT_SETTLEMENT'} = "
select to_char(t1.sys_creation_date,'YYYY-MM-DD') "
  . '"Creation Date", t1.nr_param_3_val "Company Code",'
  . ' decode(t1.carrier_cd, '
  . "'USA6G','NEX-TECH Wireless', 'USASG', 'SPRINT', 'USAW6', 'T-MOBILE', 'NLDLT','Vodofone Netherland')"
  . '"Carrier",'
  . "'6008001', sum((t1.TOT_CHRG_PARAM_VAL/1024)/1024)"
  . ' "Total Usage MB",  sum(tot_net_usage_chrg) "Data Charges SDR", '
  . "'6002202', (nvl((select sum(TOT_CHRG_PARAM_VAL)   from IC_ACCUMULATED_USAGE  where prod_cat_id = 'II' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD') and rate_plan_cd = 'RPINCGSMSMSCD' and  t1.nr_param_3_val =   nr_param_3_val)	,0)) "
  . ' "Total Texts" ,'
  . " (nvl((select  sum(tot_net_usage_chrg)   from IC_ACCUMULATED_USAGE  where prod_cat_id = 'II' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD') and rate_plan_cd = 'RPINCGSMSMSCD' and  t1.nr_param_3_val =   nr_param_3_val)  ,0)) "
  . '"Text Charges" , '
  . "'6002201',(nvl((select sum(TOT_CHRG_PARAM_VAL)   from IC_ACCUMULATED_USAGE  where prod_cat_id = 'II' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD') and rate_plan_cd = 'RPINCGSMVOICETOTCD' and  t1.nr_param_3_val =   nr_param_3_val),0)) "
  . '"Total Minutes",'
  . "(nvl(   (select  sum(tot_net_usage_chrg)   from IC_ACCUMULATED_USAGE  where prod_cat_id = 'II' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD') and rate_plan_cd = 'RPINCGSMVOICETOTCD' and  t1.nr_param_3_val =   nr_param_3_val),0)) "
  . ' "Voice Charges" '
  . " from IC_ACCUMULATED_USAGE t1 where prod_cat_id = 'II' and BP_START_DATE = to_date('$period"
  . "01','YYYYMMDD') and  rate_plan_cd = 'RPINCGSMDATACD' group by to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val, t1.carrier_cd order by  to_char(t1.sys_creation_date,'YYYY-MM-DD'),t1.nr_param_3_val";

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
  . " prod_cat_id = 'RO' and bp_start_date = to_date('$period"
  . "16 ','YYYYMMDD') and future_3 = 'Voice'  and t1.rate_plan_cd != 'RPOUROTOT' and  t1.sys_creation_date  < to_date('$sdate"
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
my $dbconnb = '';             # getBRMPRD();

my @aprmArray = ();

my $message = "Everyone,\n\nAttached is the";
my $title   = "";

if ( substr( $date, 6, 2 ) eq '05' ) {

	$message = $message
	  . " APRM CDMA Accrual and 4G Settlement Report for $monthname 5th  $yearname.\nThe report covers the Billing Period Start Date of $yearmonthOld-01 and $yearmonthOld-16.\n\nDave";

	$title =
	  "APRM CDMA Accrual and 4G Settlement Report for $monthname 5th $yearname";

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

	$message = $message
	  . " APRM CDMA Settlement Report for $monthname 22nd  $yearname.\nThe report covers the Billing Period Start Date of $yearmonthOld-16.\n\nDave";

	$title = "APRM CDMA Settlement Report for $monthname 22nd $yearname";

	@aprmArray = (
		'CDMA_INCOLLECT_VOICE_SETTLEMENT',
		'CDMA_INCOLLECT_VOICE_SETTLEMENT_CARRIER',
		'CDMA_INCOLLECT_DATA_SETTLEMENT',
		'CDMA_INCOLLECT_DATA_SETTLEMENT_CARRIER',
		'CDMA_OUTCOLLECT_VOICE_SETTLEMENT',
		'CDMA_OUTCOLLECT_VOICE_SETTLEMENT_CARRIER'
	);
}

my $excel_file = readAprm( \@aprmArray, $dbconn, $title );

$dbconn->disconnect();

#$dbconnb->disconnect();

my @email = (
	'david.balchen@uscellular.com',
	'ISBillingOperations@uscellular.com',
	'Ilham.Elgarni@uscellular.com',
	'Heather.Jeschke@uscellular.com',
	'david.smith@uscellular.com',
	'Miguel.Jones@uscellular.com'
);

#my @email = ( 'david.balchen@uscellular.com', 'david.smith@uscellular.com');

foreach my $too (@email) {
	sendMsg( $too, $message, $title, $excel_file );
}

exit(0);

sub readAprm {
	my ( $sqlList, $conn, $title ) = @_;

	my $excel_file = $title . '.xls';
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
		'Total LTE Usage MB',
		'Total LTE Charges',
		'Total VoLTE Usage MB',
		'Total VoLTE Charges'
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
		'Total LTE Usage MB',
		'Total LTE Charges',
		'Total VoLTE Usage MB',
		'Total VoLTE Charges'
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

	return $excel_file;

}

sub getBODSPRD {

	my $dbPwd = "BODS_SVC_BILLINGOPS";

	my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );

	#my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "Bo0Go09000#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getBRMPRD {

#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
#   my $dbods = DBI->connect( "dbi:Oracle:brmprd", "md1dbal1", "Bo0Go09000#" );'

	my $dbPwd = "BODS_SVC_BILLINGOPS";
	my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );

	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub pad {

	my ( $padString, $padwith, $length ) = @_;

	while ( length($padString) < $length ) {
		$padString = $padwith . $padString;
	}

	return $padString;

}

sub sendMsg() {

	my ( $to, $message, $title, $excel_file ) = @_;
	my $mime_type = 'multipart/mixed';
	my $from      = "david.balchen\@uscellular.com";
	my $subject   = $title;
	my $cc        = '';

   #  $message = "You'll find the report attached to this email\n\n" . $message;

	my $msg = MIME::Lite->new(
		From    => $from,
		To      => $to,
		Cc      => $cc,
		Subject => $subject,
		Type    => $mime_type
	  )
	  or die "Error creat
ing " . "MIME body: $!\n";

	$msg->attach(
		Type => 'TEXT',
		Data => $message
	) or die "Error adding text message: $!\n";

	$msg->attach(
		Type     => 'application/octet-stream',
		Encoding => 'base64',
		Path     => $ENV{'REC_HOME'} . $excel_file,
		Filename => $excel_file
	) or die "Error attaching file: $!\n";

	$msg->send();
}
