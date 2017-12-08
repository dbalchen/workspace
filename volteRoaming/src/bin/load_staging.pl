#! /usr/local/bin/perl
use DBI;
use Time::Piece;
use Time::Seconds;

## For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$ARGV[0] = '20171201';
$ARGV[1] = "SAP";
my @reports = split( ',', $ARGV[1] );

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

%sqls = {};

$sqls{'LTE'} =
"select /*+ PARALLEL(t1,12) */  'Settlement',carrier_cd, 'LTE', 'Incollect','Data',sum(tot_net_usage_chrg),sum(tot_net_usage_chrg),nr_param_3_val, bp_start_date
from IC_ACCUMULATED_USAGE  where prod_cat_id = 'IS' and BP_START_DATE = to_date('$period"
  . "01"
  . "','YYYYMMDD') and core_reserved_2 in (
select  unique(file_name) from file_summary where file_type = 'TAP' and usage_type like 'LTE%'and process_date >=add_months(to_date('$date', 'YYYYMMDD'),-1)
 and process_date < to_date('$sdate" . "04" . "','YYYYMMDD') )
 group by  nr_param_3_val, carrier_cd, bp_start_date order by  nr_param_3_val, carrier_cd, bp_start_date";


$sqls{'LTEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'LTE' and roaming = 'Incollect' and period = to_date('$period"
  . "01','YYYYMMDD')";

$sqls{'LTEDCH'} =
"select  file_name,'Data','LTE','Incollect', add_months(to_date('$date', 'YYYYMMDD'),-1),'Settlement', receiver, 
decode(sender,'Sprint (USASG)','USASG','T-Mobile (USAW6)','USAW6','Vodafone Netherland (NLDLT)', 'NLDLT','Nex-Tech Wireless (USA6G)','USA6G'), 
sum(total_charges_dch),sum(total_charges_dch) from file_summary 
where file_type = 'TAP' and usage_type like 'LTE%' and process_date >=add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date < to_date('$sdate" . "04" . "','YYYYMMDD')
and file_name in (select unique(tap_in_file_name) from prm_rom_incol_events_ap  where carrier_cd != 'NLDLT' and generated_rec <  2 and bp_start_date = to_date('$period"
  . "01','YYYYMMDD'))
group by file_name,sender,receiver ";
 
 $sqls{'DISP_RM'} =
"select /*+ PARALLEL(t1,12) */ 'Settlement',carrier_cd, 'LTE','Outcollect','Data', sum(tot_net_usage_chrg),sum(tot_net_usage_chrg),nr_param_3_val, bp_start_date
from IC_ACCUMULATED_USAGE  where prod_cat_id = 'OS' and BP_START_DATE = to_date('$period"
  . "01"
  . "','YYYYMMDD') and core_reserved_2 in (select  unique(file_name)  from file_summary where file_type = 'TAP' 
 and usage_type = 'DISP_RM'  and process_date >=add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date < to_date('$sdate"
  . "04"
  . "','YYYYMMDD')) 
 group by nr_param_3_val,carrier_cd, bp_start_date";
 
$sqls{'DISP_RMDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'LTE' and roaming = 'Outcollect' and period = to_date('$period"
  . "01','YYYYMMDD')";

$sqls{'DISP_RMDCH'} =
"select file_name,'Data','LTE','Outcollect', add_months(to_date('$date', 'YYYYMMDD'),-1),'Settlement', sender, receiver, sum(total_charges_dch),sum(total_charges_dch) from file_summary 
where file_type = 'TAP' and usage_type = 'DISP_RM' and process_date >=add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date < to_date('$sdate" . "01" . "','YYYYMMDD')
and file_name in (select unique(tap_out_file_name) from prm_rom_outcol_events_ap  where carrier_cd != 'NLDLT' and generated_rec <  2 and bp_start_date = to_date('$period"
  . "01','YYYYMMDD'))
group by file_name,sender,receiver";

$sqls{'NLDLT'} = "
select /*+ PARALLEL(t1,12) */ 'Settlement',t1.serving_bid, 'GSM', 'Incollect',decode(t1.charge_type,'V', 'Data','C', 'SMS', 'O', 'Voice'),
sum((t1.charge_amount * t1.exchange_rate)/t2.from_to_cross_rate), sum(t1.charge_amount * t1.exchange_rate), 'NLDLT', t1.bp_start_date 
from prm_rom_incol_events_ap t1, ICG_CROSS_RATE t2
where t1.bp_start_date = t2.bp_start_date and t2.from_crncy_cd = 'EUR'
 and to_crncy_cd = 'USD' and T2.CARRIER_CD = 'NLDLT' 
and t1.generated_rec <  2  and t1.carrier_cd = 'NLDLT'  and t1.BP_START_DATE= to_date('$period"
  . "01"
  . "','YYYYMMDD') and t1.TAP_IN_FILE_NAME in  
(select unique(file_name) from file_summary where  file_type = 'TAP' and sender like '%NLDLT%' and process_date >= add_months(to_date('$date', 'YYYYMMDD'),-1) 
and process_date < to_date('$date','YYYYMMDD')  ) group by t1.serving_bid, t1.carrier_cd, t1.charge_type, t1.bp_start_date";

$sqls{'NLDLTDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'GSM' and roaming = 'Incollect' and period = to_date('$period"
  . "01','YYYYMMDD')";

$sqls{'NLDLTDCH'} =
"select file_name, decode(usage_type,'NLDLT-V', 'Data','NLDLT-C', 'SMS', 'NLDLT-O', 'Voice'),'GSM', 'Incollect', add_months(to_date('$date', 'YYYYMMDD'),-1),'Settlement' 
,receiver, 'NLDLT',sum(TOTAL_CHARGES_DCH),sum(TOTAL_CHARGES_DCH )
  from file_summary  where file_type = 'TAP' and sender like '%NLDLT%'
  and process_date >= add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date < to_date('$date','YYYYMMDD') 
  and file_name in (select unique(tap_in_file_name) from prm_rom_incol_events_ap  where carrier_cd = 'NLDLT' and generated_rec <  2 and bp_start_date = to_date('$period"
  . "01','YYYYMMDD'))
  group by  file_name,sender,receiver,usage_type";

$sqls{'CDMA_A_IN_VOICE'} =
" select  /*+ PARALLEL(h1,12) */ 'Accrual', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where ciber_file_name_1||ciber_file_name_2 in
   (select unique(file_name)  from file_summary where usage_type = 'SDIRI_FCIBER' and process_date > to_date('$ldate"
  . "15" . "','YYYYMMDD')  
   and process_date < to_date('$date','YYYYMMDD')) and generated_rec < 2  and BP_START_DATE = to_date('$period"
  . "16','YYYYMMDD')
   group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_A_IN_VOICEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Incollect' and month_type = 'Accrual' and usage_type = 'Voice' and period = to_date('$period"
  . "16','YYYYMMDD')";

$sqls{'CDMA_S_IN_VOICE'} =
" select  /*+ PARALLEL(h1,12) */ 'Settlement', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date 
  from USC_ROAM_EVNTS where ciber_file_name_1||ciber_file_name_2 in
   (select unique(file_name)  from file_summary where usage_type = 'SDIRI_FCIBER' and process_date >= to_date('$sdate"
  . "01" . "','YYYYMMDD')  
   and process_date <= to_date('$sdate" . "22"
  . "','YYYYMMDD')) and generated_rec < 2  and BP_START_DATE = to_date('$period"
  . "16','YYYYMMDD')
   group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_IN_VOICEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Incollect' and month_type = 'Settlement' and usage_type = 'Voice' and period = to_date('$period"
  . "16','YYYYMMDD')";

$sqls{'CDMA_A_IN_DATA'} =
" select  /*+ PARALLEL(h1,12) */  'Accrual', serve_sid,'CDMA','Incollect','Data',sum(TOTAL_CHRG_AMOUNT),sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date 
   from USC_ROAM_EVNTS where ciber_file_name_1||ciber_file_name_2 in
   (select unique(file_name)  from file_summary where usage_type = 'SDATACBR_FDATACBR' and process_date > to_date('$ldate"
  . "15" . "','YYYYMMDD')  
   and process_date < to_date('$date','YYYYMMDD')) and generated_rec < 2  and BP_START_DATE = to_date('$period"
  . "16','YYYYMMDD')
   group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_A_IN_DATADEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Incollect' and month_type = 'Accrual' and usage_type = 'Data' and period = to_date('$period"
  . "16','YYYYMMDD')";

$sqls{'CDMA_S_IN_DATA'} =
"select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Incollect','Data',sum(TOTAL_CHRG_AMOUNT),sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date 
   from USC_ROAM_EVNTS where ciber_file_name_1||ciber_file_name_2 in
   (select unique(file_name)  from file_summary where usage_type = 'SDATACBR_FDATACBR' and process_date >= to_date('$sdate"
  . "01" . "','YYYYMMDD')  
   and process_date <= to_date('$sdate" . "22"
  . "','YYYYMMDD')) and generated_rec < 2  and BP_START_DATE = to_date('$period"
  . "16','YYYYMMDD')
   group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_IN_DATADEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Incollect' and month_type = 'Settlement' and usage_type = 'Data' and period = to_date('$period"
  . "16','YYYYMMDD')";

$sqls{'CDMA_A_OUT_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Accrual', serve_sid,'CDMA','Outcollect','Voice',sum(TOTAL_CHRG_AMOUNT),sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date 
from USC_ROAM_EVNTS where  ciber_file_name_1||ciber_file_name_2 in
(select unique(file_name)  from file_summary where usage_type = 'CIBER_CIBER' and process_date >= to_date('$ldate"
  . "16" . "','YYYYMMDD')  
   and process_date < to_date('$date','YYYYMMDD')) and generated_rec < 2  and BP_START_DATE = to_date('$period"
  . "16','YYYYMMDD')
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_A_OUT_VOICEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Outcollect' and month_type = 'Accrual' and usage_type = 'Voice' and period = to_date('$period"
  . "16','YYYYMMDD')";

$sqls{'CDMA_S_OUT_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Outcollect','Voice',sum(TOTAL_CHRG_AMOUNT),sum(TOTAL_CHRG_AMOUNT), carrier_cd, bp_start_date 
        from USC_ROAM_EVNTS where  ciber_file_name_1||ciber_file_name_2 in
(select unique(file_name)  from file_summary where usage_type = 'CIBER_CIBER' and process_date >= to_date('$sdate"
  . "01" . "','YYYYMMDD')  
   and process_date <= to_date('$sdate" . "22"
  . "','YYYYMMDD')) and generated_rec < 2  and BP_START_DATE = to_date('$period"
  . "16','YYYYMMDD')
   group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_OUT_VOICEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Outcollect' and month_type = 'Settlement' and usage_type = 'Voice' and period = to_date('$period"
  . "16','YYYYMMDD')";

$sqls{'CDMA_A_OUT_DATA'} = "
SELECT 
          SUBSTR(T2.SITENUM,1,3),
          TRIM(REGEXP_REPLACE(T1.PARTNER,',')),
          COUNT(*),
          SUM(AMOUNT),
          SUM(MESSAGE_ACCOUNTING_DIGITS),
          SUM(ACTUAL_USAGE_VOLUME),
          SUM(ACTUAL_DATA_VOLUME)
     FROM DATA_OUTCOLLECT T1, BSID_TO_SERVE_SID T2
    WHERE TO_CHAR(T1.SETTLEMENT_DATE, 'YYYYMMDD') = TO_CHAR(to_date('$sdate"
  . "15','YYYYMMDD'), 'YYYYMMDD')
      AND TO_CHAR(T1.PROCESS_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(to_date('$sdate','YYYYMM'),-1),'YYYYMM')
      AND TRIM(REGEXP_REPLACE(T1.PARTNER,',')) IN (SELECT DISTINCT TRIM(PARTNER) FROM ROAMING_PARTNER WHERE BSID_TYPE = '835-B' AND UPPER(CLEARINGHOUSE) = 'SYNIVERSE' )
      AND SUBSTR(T1.BSID,1,11) = TRIM(T2.BSID)
   GROUP BY SUBSTR(T2.SITENUM,1,3), TRIM(REGEXP_REPLACE(T1.PARTNER,','))
   UNION 
   SELECT SUBSTR(T2.SITENUM,1,3),
          TRIM(REGEXP_REPLACE(T1.PARTNER,',')),
          COUNT(*),
          SUM(AMOUNT),
          SUM(MESSAGE_ACCOUNTING_DIGITS),
          SUM(ACTUAL_USAGE_VOLUME),
          SUM(ACTUAL_DATA_VOLUME)  
     FROM DATA_OUTCOLLECT T1, BSID_TO_SERVE_SID T2
    WHERE TO_CHAR(T1.SETTLEMENT_DATE, 'YYYYMMDD') = TO_CHAR(to_date('$sdate"
  . "15','YYYYMMDD'), 'YYYYMMDD')
      AND TO_CHAR(T1.PROCESS_DATE, 'YYYYMM') = TO_CHAR(ADD_MONTHS(to_date('$sdate','YYYYMM'),-1),'YYYYMM')
      AND TRIM(REGEXP_REPLACE(T1.PARTNER,',')) IN (SELECT DISTINCT TRIM(PARTNER) FROM ROAMING_PARTNER WHERE BSID_TYPE = '835-A')
      AND SUBSTR(T1.BSID,1,8) || SUBSTR(T1.BSID,10,3) = TRIM(T2.BSID)
   GROUP BY SUBSTR(T2.SITENUM,1,3), TRIM(REGEXP_REPLACE(T1.PARTNER,','))
   UNION
   SELECT SUBSTR(T2.SITENUM,1,3),
          TRIM(REGEXP_REPLACE(T1.PARTNER,',')),
          COUNT(*),
          SUM(AMOUNT),
          SUM(MESSAGE_ACCOUNTING_DIGITS),
          SUM(ACTUAL_USAGE_VOLUME),
          SUM(ACTUAL_DATA_VOLUME)  
     FROM DATA_OUTCOLLECT T1, BSID_TO_SERVE_SID T2
    WHERE TO_CHAR(T1.SETTLEMENT_DATE, 'YYYYMMDD') = TO_CHAR(to_date('$sdate"
  . "15','YYYYMMDD'), 'YYYYMMDD')
      AND T1.PROCESS_DATE < to_date('$sdate" . "02','YYYYMMDD')
      AND TRIM(REGEXP_REPLACE(T1.PARTNER,',')) IN (SELECT DISTINCT TRIM(PARTNER) FROM ROAMING_PARTNER WHERE BSID_TYPE = '835-B' AND UPPER(CLEARINGHOUSE) = 'TNS' )
      AND SUBSTR(T1.BSID,1,11) = TRIM(T2.BSID)
   GROUP BY SUBSTR(T2.SITENUM,1,3), TRIM(REGEXP_REPLACE(T1.PARTNER,','))";

$sqls{'CDMA_A_OUT_DATADEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Outcollect' and month_type = 'Accrual' and usage_type = 'Data' and period = to_date('$period"
  . "16','YYYYMMDD')";

$sqls{'CDMA_S_OUT_DATA'} = "
SELECT SUBSTR(T2.SITENUM,1,3),
          TRIM(REGEXP_REPLACE(T1.PARTNER,',')),
          COUNT(*),
          SUM(AMOUNT),
          SUM(MESSAGE_ACCOUNTING_DIGITS),
          SUM(ACTUAL_USAGE_VOLUME),
          SUM(ACTUAL_DATA_VOLUME)
     FROM DATA_OUTCOLLECT T1, BSID_TO_SERVE_SID T2
    WHERE TO_CHAR(T1.SETTLEMENT_DATE, 'YYYYMMDD') = TO_CHAR(to_date('$sdate"
  . "15','YYYYMMDD'), 'YYYYMMDD')
     AND TO_CHAR(T1.PROCESS_DATE, 'YYYYMM') = TO_CHAR(to_date('$sdate','YYYYMM'),'YYYYMM')
      AND TRIM(REGEXP_REPLACE(T1.PARTNER,',')) IN (SELECT DISTINCT TRIM(PARTNER) FROM ROAMING_PARTNER WHERE BSID_TYPE = '835-B')
      AND SUBSTR(T1.BSID,1,11) = TRIM(T2.BSID)
   GROUP BY SUBSTR(T2.SITENUM,1,3), TRIM(REGEXP_REPLACE(T1.PARTNER,','))
   UNION 
   SELECT SUBSTR(T2.SITENUM,1,3),
          TRIM(REGEXP_REPLACE(T1.PARTNER,',')),
          COUNT(*),
          SUM(AMOUNT),
          SUM(MESSAGE_ACCOUNTING_DIGITS),
          SUM(ACTUAL_USAGE_VOLUME),
          SUM(ACTUAL_DATA_VOLUME)  
     FROM DATA_OUTCOLLECT T1, BSID_TO_SERVE_SID T2
       WHERE TO_CHAR(T1.SETTLEMENT_DATE, 'YYYYMMDD') = TO_CHAR(to_date('$sdate"
  . "15','YYYYMMDD'), 'YYYYMMDD')
     AND TO_CHAR(T1.PROCESS_DATE, 'YYYYMM') = TO_CHAR(to_date('$sdate','YYYYMM'),'YYYYMM')
      AND TRIM(REGEXP_REPLACE(T1.PARTNER,',')) IN (SELECT DISTINCT TRIM(PARTNER) FROM ROAMING_PARTNER WHERE BSID_TYPE = '835-A')
      AND SUBSTR(T1.BSID,1,8) || SUBSTR(T1.BSID,10,3) = TRIM(T2.BSID)
   GROUP BY SUBSTR(T2.SITENUM,1,3), TRIM(REGEXP_REPLACE(T1.PARTNER,','))
";

$sqls{'CDMA_S_OUT_DATADEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Outcollect' and month_type = 'Settlement' and usage_type = 'Data' and period = to_date('$period"
  . "16','YYYYMMDD')";

my $dbconn = getBODSPRD();

my $dbconnb = $dbconn;

# my $dbconnb = getSNDPRD();

my $dbconnc = getBRMPRD();

my @aprmArray = ();

if ( substr( $date, 6, 2 ) eq '01' ) {

	@aprmArray = (
		'LTE',
		'DISP_RM',
		'NLDLT',
		'CDMA_A_IN_VOICE',
		'CDMA_A_IN_DATA',
		'CDMA_A_OUT_VOICE',
		'CDMA_A_OUT_DATA'
	);

}
else {
	@aprmArray = (
		'CDMA_S_IN_VOICE',
		'CDMA_S_IN_DATA',
		'CDMA_S_OUT_VOICE',
		'CDMA_S_OUT_DATA'
	);
}

my @dchArray = ( 
'LTE',
'NLDLT', 
'DISP_RM' 
);

foreach my $report (@reports) {

	if ( $report eq "APRM" ) {
		loadAprm( \@aprmArray, $dbconn, $dbconnb, $dbconnc );
	}
	elsif ( $report eq "SAP" ) {
		loadSAP( $dbconnb, $date );
	}
	elsif ( $report eq "DCH" ) {
		loadDCH( \@dchArray, $date, $dbconn, $dbconnb, $ldate );
	}
}

$dbconn->disconnect();
$dbconnb->disconnect();
$dbconnc->disconnect();

exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "9000#BooGoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getSNDPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "9000#BooGoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getBRMPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:brmprd", "md1dbal1", "9000#BooGoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub loadAprm {

	my ( $sqlList, $conn, $conn2, $conn3 ) = @_;

	foreach my $wsql ( @{$sqlList} ) {

		my $sth    = '';
		my $sqldel = $wsql . "DEL";
		$sqldel = $sqls{$sqldel};

		print "$sqldel\n";

		$conn2 = $dbconnb->prepare($sqldel);
		$conn2->execute() or sendErr();

		my $sql = $sqls{$wsql};

		print "$sql\n";

		if (   ( $wsql eq 'CDMA_A_OUT_DATA' )
			|| ( $wsql eq 'CDMA_S_OUT_DATA' ) )
		{
			$sth = $conn3->prepare($sql);
			$sth->execute() or sendErr();

			my %sumData = {};

			while ( my @rows = $sth->fetchrow_array() ) {

				if ( defined $sumData{ $rows[0] } ) {
					$sumData{ $rows[0] } = $sumData{ $rows[0] } + $rows[3];
				}
				else {
					$sumData{ $rows[0] } = $rows[3];
				}
			}

			for my $key ( keys %sumData ) {

				my @rows = [];

				if ( $wsql eq 'CDMA_A_OUT_DATA' ) {
					$rows[0] = "Accrual";
				}
				else {
					$rows[0] = "Settlement";
				}

				$rows[2] = "CDMA";
				$rows[3] = "Outcollect";
				$rows[4] = "Data";
				$rows[5] = $sumData{$key};
				$rows[6] = $sumData{$key};
				$rows[7] = "0" . $key;
				$rows[8] = $ldate . "16";

				if ( $sumData{$key} eq '' ) {
					next;
				}

				my $sql = "INSERT INTO APRM_STAGING (
   							USAGE_TYPE, TECHNOLOGY, ROAMING, 
   							PERIOD, MONTH_TYPE, COMPANY_CODE, 
   							BID, AMOUNT_USD, AMOUNT_EUR) 
							VALUES ( 
							 '$rows[4]'      /* USAGE_TYPE */,
							 '$rows[2]' 	   /* TECHNOLOGY */,
							 '$rows[3]'      /* ROAMING */,
							  to_date('$rows[8]','YYYYMMDD'),
							 '$rows[0]'      /* MONTH_TYPE */,
							 '$rows[7]'      /* COMPANY_CODE */,
							 '$rows[1]'      /* BID */,
 							  $rows[5]     /* AMOUNT_USD */,
 							  $rows[6]    /* AMOUNT_EUR */ )";

#				 print "$sql\n";
				$conn2 = $dbconnb->prepare($sql);
				$conn2->execute() or sendErr();

			}

		}
		else {

			$sth = $conn->prepare($sql);
			$sth->execute() or sendErr();

			while ( my @rows = $sth->fetchrow_array() ) {

				if ( $rows[5] eq '' ) {
					next;
				}
				my $sql = "INSERT INTO APRM_STAGING (
   						USAGE_TYPE, TECHNOLOGY, ROAMING, 
   						PERIOD, MONTH_TYPE, COMPANY_CODE, 
   						BID, AMOUNT_USD, AMOUNT_EUR) 
						VALUES ( 
						 '$rows[4]'      /* USAGE_TYPE */,
 						 '$rows[2]' 	   /* TECHNOLOGY */,
 						 '$rows[3]'      /* ROAMING */,
						 '$rows[8]'      /* PERIOD */,
 						 '$rows[0]'      /* MONTH_TYPE */,
 						 '$rows[7]'      /* COMPANY_CODE */,
 						 '$rows[1]'      /* BID */,
 						  $rows[5]     /* AMOUNT_USD */,
 						  $rows[6]    /* AMOUNT_EUR */ )";

#				 print "$sql\n";
				$conn2 = $dbconnb->prepare($sql);
				$conn2->execute() or sendErr();

			}

		}

	}

}

#sub updateAPRM {
#	my ( $dbconnb, $ref ) = @_;
#
#	my @rows = @{$ref};
#
#	my $sql = "INSERT INTO APRM_STAGING (
#   USAGE_TYPE, TECHNOLOGY, ROAMING,
#   PERIOD, MONTH_TYPE, COMPANY_CODE,
#   BID, AMOUNT_USD, AMOUNT_EUR)
#VALUES (
# '$rows[4]'      /* USAGE_TYPE */,
# '$rows[2]' 	   /* TECHNOLOGY */,
# '$rows[3]'      /* ROAMING */,
# '$rows[8]'      /* PERIOD */,
# '$rows[0]'      /* MONTH_TYPE */,
# '$rows[7]'      /* COMPANY_CODE */,
# '$rows[1]'      /* BID */,
# $rows[5]     /* AMOUNT_USD */,
# $rows[6]    /* AMOUNT_EUR */ )";
#
#	my $conn2 = $dbconnb->prepare($sql);
#	$conn2->execute() or sendErr();
#}

sub loadDCH {

	my ( $sqlList, $date, $conn, $connb, $ldate ) = @_;

	$date  = substr( $date,  0, 6 ) . "01";
	$ldate = substr( $ldate, 0, 6 ) . "01";

	my @results = [];

	my $sql =
"delete from DCH_STAGING where technology != 'CDMA' and PERIOD = to_date('$ldate','YYYYMMDD')";
	my $sth = $connb->prepare($sql);

	print "$sql\n";

	 $sth->execute() or sendErr();

	foreach my $wsql ( @{$sqlList} ) {

		my $sth    = '';
		my $sqldch = $wsql . "DCH";
		$sqldch = $sqls{$sqldch};

		print "$sqldch\n";

		$sth = $conn->prepare($sqldch);
		$sth->execute() or sendErr();

		while ( my @rows = $sth->fetchrow_array() ) {
			my $sql = "INSERT INTO DCH_STAGING (
   						FILENAME, USAGE_TYPE, TECHNOLOGY, ROAMING, 
   						PERIOD, MONTH_TYPE, COMPANY_CODE, 
   						BID, AMOUNT_USD, AMOUNT_EUR) 
							VALUES ( 
 								'$rows[0]',
 								'$rows[1]'      /* USAGE_TYPE */,
 								'$rows[2]' 	   /* TECHNOLOGY */,
 								'$rows[3]'      /* ROAMING */,
 								'$rows[4]'      /* PERIOD */,
 								'$rows[5]'      /* MONTH_TYPE */,
 								'$rows[6]'      /* COMPANY_CODE */,
 								'$rows[7]'      /* BID */,
 								 $rows[8]     /* AMOUNT_USD */,
								 $rows[9]    /* AMOUNT_EUR */ )";

			my $sth = $connb->prepare($sql);
			$sth->execute() or sendErr();

		}
	}
}

sub loadSAP {

	my ( $conn2, $date ) = @_;

	my @results = [];

	my $sapfile = "";

	if ( substr( $date, 6, 2 ) eq '01' ) {
		$sapfile = "/home/dbalchen/Desktop/SAP_IO_Roaming_Month_End.csv";
	}
	else {
		$sapfile = "/home/dbalchen/Desktop/SAP_IO_Roaming_Mid_Month.csv";
	}

	my $hh = "cat  $sapfile | cut -f 2,4,6,7 | sort -u |";

	if ( !open( SAPLIST, "$hh" ) ) {
		errorExit("Cannot create SAPLIST: $!\n");
	}

	while ( my $buff = <SAPLIST> ) {
		chomp($buff);

		my ( $gl, $cocd, $docdate, $header ) = split( "\t", $buff );

		$hh =
"cat $sapfile | grep $gl | grep $cocd | grep $docdate | grep '$header' | cut -f 3";

		# print "$hh\n";
		my $month_type = "Settlement";
		@results = `$hh`;
		chomp(@results);

		my $total = 0;

		for ( my $a = 0 ; $a < @results ; $a = $a + 1 ) {
			$total = $total + $results[$a];
		}
		my $technology = "";
		my $roaming    = "";
		my $data_type  = "";

		if ( ( index( $header, "GLLTIY3" ) >= 0 ) && ( $gl == 6008001 ) ) {
			$technology = "LTE";
			$roaming    = "Incollect";
			$data_type  = "Data";

			# modification made
			$total = $total;# / 2;
		}

		elsif ( ( index( $header, "GLLTOY3" ) >= 0 ) && ( $gl == 5438001 ) ) {
			$technology = "LTE";
			$roaming    = "Outcollect";
			$data_type  = "Data";

			# modification made
			$total = $total;# / 2;
		}

		elsif ( ( index( $header, "GLLTIY3" ) >= 0 ) && ( $gl == 6008002 ) ) {
			$technology = "VoLTE";
			$roaming    = "Incollect";
			$data_type  = "Data";

			#Maybe
		}

		elsif ( ( index( $header, "GLLTOY3" ) >= 0 ) && ( $gl == 5438002 ) ) {
			$technology = "VoLTE";
			$roaming    = "Outcollect";
			$data_type  = "Data";

			#Maybe
		}

		elsif ( ( index( $header, "GLGSIY3" ) >= 0 ) && ( $gl == 6002201 ) ) {
			$technology = "GSM";
			$roaming    = "Incollect";
			$data_type  = "Voice";
		}
		elsif ( ( index( $header, "GLGSIY3" ) >= 0 ) && ( $gl == 6008001 ) ) {
			$technology = "GSM";
			$roaming    = "Incollect";
			$data_type  = "Data";
		}

		elsif ( ( index( $header, "GLGSIY3" ) >= 0 ) && ( $gl == 6002202 ) ) {
			$technology = "GSM";
			$roaming    = "Incollect";
			$data_type  = "SMS";
		}

		elsif ( ( index( $header, "GLINCY3" ) >= 0 ) && ( $gl == 6002201 ) ) {
			$technology = "CDMA";
			$roaming    = "Incollect";
			$data_type  = "Voice";
		}

		elsif ( ( index( $header, "GLINCY4" ) >= 0 ) && ( $gl == 6002201 ) ) {
			$technology = "CDMA";
			$roaming    = "Incollect";
			$data_type  = "Voice";
		}

		elsif ( ( index( $header, "GLOUTY3" ) >= 0 ) && ( $gl == 5430001 ) ) {
			$technology = "CDMA";
			$roaming    = "Outcollect";
			$data_type  = "Voice";

		}
		elsif (
			(
				index( $header, "Doc Type = SA and Ref Doc = [I]DATAREV" ) >= 0
				|| index( $header, "DATA REVENUE" ) >= 0
			)
			&& ( $gl == 5438001 )
		  )
		{
			$technology = "CDMA";
			$roaming    = "Outcollect";
			$data_type  = "Data";
		}

		elsif ( ( index( $header, "GLOUTY3" ) >= 0 ) && ( $gl == 5410101 ) ) {
			$technology = "CDMA";
			$roaming    = "Outcollect";
			$data_type  = "Toll";
		}
		elsif ( ( index( $header, "GLOUTY3" ) >= 0 ) && ( $gl == 4080401 ) ) {
			$technology = "CDMA";
			$roaming    = "Outcollect";
			$data_type  = "Tax";
		}

		elsif ( ( index( $header, "GLINCY3" ) >= 0 ) && ( $gl == 6008001 ) ) {
			$technology = "CDMA";
			$roaming    = "Incollect";
			$data_type  = "Data";
		}
		elsif ( ( index( $header, "GLINCY4" ) >= 0 ) && ( $gl == 6008001 ) ) {
			$technology = "CDMA";
			$roaming    = "Incollect";
			$data_type  = "Data";
		}

		elsif ( ( index( $header, "GLOUTY4" ) >= 0 ) && ( $gl == 5430001 ) ) {
			$technology = "CDMA";
			$roaming    = "Outcollect";
			$data_type  = "Voice";
		}

		elsif (
			(
				# Need some changes here
				index( $header, "Doc Type = ZM and Ref Doc = [I]DATAREVACCR" )
				>= 0
			)
			&& ( $gl == 5438001 )
		  )
		{
			$technology = "CDMA";
			$roaming    = "Outcollect";
			$data_type  = "Data";
		}

		elsif ( ( index( $header, "GLOUTY4" ) >= 0 ) && ( $gl == 5410101 ) ) {
			$technology = "CDMA";
			$roaming    = "Outcollect";
			$data_type  = "Toll";
		}

		elsif ( ( index( $header, "GLOUTY4" ) >= 0 ) && ( $gl == 4080401 ) ) {
			$technology = "CDMA";
			$roaming    = "Outcollect";
			$data_type  = "Tax";
		}

		else {

			print "WTF --- $hh\n";
			next;
		}

		if ( ( substr( $date, 6, 2 ) eq '01' ) && ( $technology eq "CDMA" ) ) {
			$month_type = "Accrual";
		}

		my $sql =
"delete from SAP_STAGING where USAGE_TYPE = '$data_type' and TECHNOLOGY = '$technology' 
		and ROAMING = '$roaming' and PERIOD = to_date('$docdate','MM/DD/YYYY') and MONTH_TYPE = '$month_type' and DOC_HEADER = '$header'
		and  COMPANY_CODE = '$cocd'";

		$conn2 = $dbconnb->prepare($sql);
		$conn2->execute() or sendErr();

		$sql = "INSERT INTO SAP_STAGING (
   				USAGE_TYPE, 
   				TECHNOLOGY, 
   				ROAMING, 
   				PERIOD, 
   				MONTH_TYPE, 
   				DOC_HEADER, 
   	            COMPANY_CODE, 
   	            AMOUNT) 
			VALUES ( 
					'$data_type'  /* USAGE_TYPE */,
 					'$technology' /* TECHNOLOGY */,
 					'$roaming'    /* ROAMING */,
 					to_date('$docdate','MM/DD/YYYY')    /* PERIOD */,
 					'$month_type' /* MONTH_TYPE */,
 					'$header' /* DOC_HEADER */,
 					'$cocd' /* COMPANY_CODE */,
 					$total /* AMOUNT */ 
 			)";

# print "$data_type\t$technology\t$roaming\t$docdate\t$header\t$cocd\t$total\n";

		$conn2 = $dbconnb->prepare($sql);
		$conn2->execute() or sendErr();
	}

}
