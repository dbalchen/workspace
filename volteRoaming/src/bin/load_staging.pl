#! /usr/bin/perl

use DBI;
use Time::Piece;
use Time::Seconds;

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$ARGV[0] = '20170201';

my $date = $ARGV[0];
my $sdate = substr( $date, 0, 6 );

my $ldate = Time::Piece->strptime( $sdate, "%Y%m" );
$ldate -= ONE_MONTH;
$ldate = $ldate->strftime("%Y%m");

%sqls = {};

$sqls{'LTE'} =
"select /*+ PARALLEL(t1,12) */ 'Settlement',serving_bid, 'LTE', 'Incollect','Data',sum(charge_amount), carrier_cd, bp_start_date 
from prm_rom_incol_events_ap t1 
where   (process_date >= add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date <= to_date('$date', 'YYYYMMDD'))and carrier_cd != 'NLDLT' group by serving_bid,carrier_cd, bp_start_date";

$sqls{'DISP_RM'} =
"select /*+ PARALLEL(t1,12) */ 'Settlement', home_bid, 'LTE','Outcollect','DATA', sum(tot_net_charge_lc),carrier_cd, bp_start_date from prm_rom_outcol_events_ap t1 where (process_date >= add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date <= to_date('$date', 'YYYYMMDD')) and carrier_cd != 'NLDLT' group by  home_bid,carrier_cd, bp_start_date";

$sqls{'NLDLT'} =
"select /*+ PARALLEL(t1,12) */ 'Settlement',serving_bid, 'GSM', 'Incollect',charge_type,'',sum(charge_amount), carrier_cd, bp_start_date from prm_rom_incol_events_ap t1  where (process_date >= add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date <= to_date('$date', 'YYYYMMDD')) and carrier_cd = 'NLDLT' group by serving_bid,carrier_cd, bp_start_date, charge_type";

$sqls{'CDMA_A_IN_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS 
where (REGEXP_LIKE (ciber_file_name_1, 'SDIRI_FCIBER_ID(.*)_T"
  . $ldate
  . "1[6,7,8,9](.*)') or ciber_file_name_1 like 'SDIRI_FCIBER_ID%T"
  . $ldate
  . "2%' or  ciber_file_name_1 like 
'SDIRI_FCIBER_ID%T" . $ldate
  . "3%') and generated_rec < 2  group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_IN_DATA'} =
"select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Incollect','Data',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS 
where (REGEXP_LIKE (ciber_file_name_1, 'SDATACBR_FDATACBR_ID(.*)_T"
  . $ldate
  . "1[6,7,8,9](.*)') or ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T"
  . $ldate
  . "2%' or  ciber_file_name_1 
like 'SDATACBR_FDATACBR_ID%T"
  . $ldate
  . "3%' or ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T"
  . $sdate . "0%' 
or REGEXP_LIKE (ciber_file_name_1, 'SDATACBR_FDATACBR_ID(.*)_T" . $sdate
  . "1[0,1,2,3,4,5](.*)')) and generated_rec < 2  group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_IN_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'SDIRI_FCIBER_ID(.*)_T" . $ldate
  . "1[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'SDIRI_FCIBER_ID%T" . $ldate . "2%'
	     or  ciber_file_name_1 like 'SDIRI_FCIBER_ID%T" . $ldate . "3%'
	     or ciber_file_name_1 like 'SDIRI_FCIBER_ID%T" . $sdate . "0%'
	     or REGEXP_LIKE (ciber_file_name_1, 'SDIRI_FCIBER_ID(.*)_T" . $sdate
  . "1[0,1,2,3,4,5](.*)'))
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_A_IN_DATA'} =
"select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'SDATACBR_FDATACBR_ID(.*)_T" . $ldate
  . "1[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T" . $ldate . "2%'
	     or  ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T" . $ldate . "3%')
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_OUT_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Outcollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'CIBER_CIBER(.*)_" . $date . "1[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'CIBER_CIBER%" . $ldate . "2%'
	     or  ciber_file_name_1 like 'CIBER_CIBER%" . $ldate . "3%'
	     or ciber_file_name_1 like 'CIBER_CIBER%" . $sdate . "0%'
	     or REGEXP_LIKE (ciber_file_name_1, 'CIBER_CIBER(.*)_" . $sdate
  . "1[0,1,2,3,4,5](.*)'))
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date;";

$sqls{'CDMA_A_OUT_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Outcollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'CIBER_CIBER(.*)_" . $ldate . "1[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'CIBER_CIBER%" . $ldate . "2%'
	     or  ciber_file_name_1 like 'CIBER_CIBER%" . $ldate . "3%')
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_OUT_DATA'} =
"select  /*+ PARALLEL(h1,12) */ 'Settlement','','CDMA','Outcollect','Data',  sum(t1.amount), TRIM(REGEXP_REPLACE(t1.PARTNER,',')) as PARTNER, ADD_MONTHS(t1.settlement_date+1,-1)
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and (t1.process_date >= to_date('"
  . $ldate
  . "16', 'YYYYMMDD') and t1.process_date <= to_date('"
  . $sdate
  . "15', 'YYYYMMDD'))
         group by TRIM(REGEXP_REPLACE(t1.PARTNER,',')),t1.settlement_date order by 1,2";


# Need to add BRMPRD

$sqls{'CDMA_A_OUT_DATA'} =
"select  /*+ PARALLEL(h1,12) */ 'Accrual','','CDMA','Outcollect','Data',  sum(t1.amount), TRIM(REGEXP_REPLACE(t1.PARTNER,',')) as PARTNER, ADD_MONTHS(t1.settlement_date+1,-1)
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and (t1.process_date >= to_date('"
  . $ldate
  . "16', 'YYYYMMDD') and t1.process_date <= to_date('"
  . $sdate
  . "31', 'YYYYMMDD'))
         group by TRIM(REGEXP_REPLACE(t1.PARTNER,',')),t1.settlement_date order by 1,2";

my $dbconn  = getBODSPRD();
my $dbconnb = getSNDPRD();

my @aprmArray = ();

if ( substr( $date, 6, 2 ) eq '01' ) {
#	@aprmArray = (
#		'LTE',            'DISP_RM',
#		'NLDLT',          'CDMA_A_IN_VOICE',
#		'CDMA_A_IN_DATA', 'CDMA_A_OUT_VOICE',
#		'CDMA_A_OUT_DATA'
#	);

	@aprmArray = (
#	'CDMA_A_IN_VOICE',
#		'CDMA_A_IN_DATA', 
#       'CDMA_A_OUT_VOICE',
		'CDMA_A_OUT_DATA'
	);
}
else {
	@aprmArray = (
		'CDMA_S_IN_VOICE',  'CDMA_S_IN_DATA',
		'CDMA_S_OUT_VOICE', 'CDMA_S_OUT_DATA'
	);
}

loadAprm( \@aprmArray, $dbconn, $dbconnb );
loadDCH();

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

sub loadAprm {

	my ( $sqlList, $conn, $conn2 ) = @_;

	foreach my $wsql ( @{$sqlList} ) {
		my $sql = $sqls{$wsql};

		my $sth = $conn->prepare($sql);
		$sth->execute() or sendErr();

		while ( my @rows = $sth->fetchrow_array() ) {

			my $sql = "INSERT INTO ENTERPRISE_GEN_SANDBOX.APRM_STAGING (
   USAGE_TYPE, TECHNOLOGY, ROAMING, 
   PERIOD, MONTH_TYPE, COMPANY_CODE, 
   BID, AMOUNT_USD, AMOUNT_EUR) 
VALUES ( 
 $rows[4]      /* USAGE_TYPE */,
 $rows[2] 	   /* TECHNOLOGY */,
 $rows[3]      /* ROAMING */,
 $rows[7]      /* PERIOD */,
 $rows[0]      /* MONTH_TYPE */,
 $rows[6]      /* COMPANY_CODE */,
 $rows[1]      /* BID */,
 $rows[5]     /* AMOUNT_USD */,
 $rows[5]    /* AMOUNT_EUR */ );";
 
 print "$sql\n";
 
		}
	}

}

sub loadDCH {

}

