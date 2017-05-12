#! /usr/bin/perl

use DBI;
use Time::Piece;
use Time::Seconds;

# For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$ARGV[0] = '20170516';
$ARGV[1] = "APRM";
my @reports = split( ',', $ARGV[1] );

my $date = $ARGV[0];

my $sdate = 0;
my $ldate = 0;

if ( substr( $date, 6, 2 ) eq '01' ) {
$ldate = Time::Piece->strptime( $date, "%Y%m%d" );	
$ldate += ONE_WEEK;
$ldate -= ONE_MONTH;
$ldate = $ldate->strftime("%Y%m");
$sdate = substr( $date, 0, 6 );
}
else {
	$sdate = substr( $date, 0, 6 );
	$ldate = substr( $date, 0, 6 );
}


%sqls = {};

$sqls{'LTE'} =
"select /*+ PARALLEL(t1,12) */ 'Settlement',serving_bid, 'LTE', 'Incollect','Data',sum(charge_amount), carrier_cd, bp_start_date 
from prm_rom_incol_events_ap t1 
where   (process_date >= add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date < to_date('$date', 'YYYYMMDD'))and carrier_cd != 'NLDLT' group by serving_bid,carrier_cd, bp_start_date";

$sqls{'LTEDEL'} =
  "delete from APRM_STAGING where TECHNOLOGY = 'LTE' and roaming = 'Incollect'";

$sqls{'DISP_RM'} =
"select /*+ PARALLEL(t1,12) */ 'Settlement', home_bid, 'LTE','Outcollect','Data', sum(tot_net_charge_lc),carrier_cd, bp_start_date from prm_rom_outcol_events_ap t1 where (process_date >= add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date < to_date('$date', 'YYYYMMDD')) and carrier_cd != 'NLDLT' group by  home_bid,carrier_cd, bp_start_date";

$sqls{'DISP_RMDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'LTE' and roaming = 'Outcollect'";

$sqls{'NLDLT'} =
"select /*+ PARALLEL(t1,12) */ 'Settlement',serving_bid, 'GSM', 'Incollect',charge_type,sum(charge_amount), carrier_cd, bp_start_date from prm_rom_incol_events_ap t1  where (process_date >= add_months(to_date('$date', 'YYYYMMDD'),-1) and process_date < to_date('$date', 'YYYYMMDD')) and carrier_cd = 'NLDLT' group by serving_bid,carrier_cd, bp_start_date, charge_type";

$sqls{'NLDLTDEL'} =
  "delete from APRM_STAGING where TECHNOLOGY = 'GSM' and roaming = 'Incollect'";

$sqls{'CDMA_A_IN_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS 
where (REGEXP_LIKE (ciber_file_name_1, 'SDIRI_FCIBER_ID(.*)_T"
  . $ldate
  . "1[6,7,8,9](.*)') or ciber_file_name_1 like 'SDIRI_FCIBER_ID%T"
  . $ldate
  . "2%' or  ciber_file_name_1 like 
'SDIRI_FCIBER_ID%T" . $ldate
  . "3%') and generated_rec < 2  group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_A_IN_VOICEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Incollect' and month_type = 'Accural' and usage_type = 'Voice'";

$sqls{'CDMA_S_IN_DATA'} =
"select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Incollect','Data',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS 
where (ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T"
  . $sdate . "0%' 
or REGEXP_LIKE (ciber_file_name_1, 'SDATACBR_FDATACBR_ID(.*)_T" . $sdate
  . "1[0,1,2,3,4,5](.*)')) and generated_rec < 2  group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_IN_DATADEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Incollect' and month_type = 'Settlement' and usage_type = 'Data'";

$sqls{'CDMA_S_IN_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
( ciber_file_name_1 like 'SDIRI_FCIBER_ID%T" . $sdate . "0%'
	     or REGEXP_LIKE (ciber_file_name_1, 'SDIRI_FCIBER_ID(.*)_T" . $sdate
  . "1[0,1,2,3,4,5](.*)'))
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_IN_VOICEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Incollect' and month_type = 'Settlement' and usage_type = 'Voice'";

$sqls{'CDMA_A_IN_DATA'} =
"select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Incollect','Data',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'SDATACBR_FDATACBR_ID(.*)_T" . $ldate
  . "1[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T" . $ldate . "2%'
	     or  ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T" . $ldate . "3%')
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_A_IN_DATADEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Incollect' and month_type = 'Accrual' and usage_type = 'Data'";

$sqls{'CDMA_S_OUT_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Outcollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
( ciber_file_name_1 like 'CIBER_CIBER%" . $sdate . "0%'
	     or REGEXP_LIKE (ciber_file_name_1, 'CIBER_CIBER(.*)_" . $sdate
  . "1[0,1,2,3,4,5](.*)'))
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_S_OUT_VOICEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Outcollect' and month_type = 'Settlement' and usage_type = 'Voice'";

$sqls{'CDMA_A_OUT_VOICE'} =
"select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Outcollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'CIBER_CIBER(.*)_" . $ldate . "1[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'CIBER_CIBER%" . $ldate . "2%'
	     or  ciber_file_name_1 like 'CIBER_CIBER%" . $ldate . "3%')
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date";

$sqls{'CDMA_A_OUT_VOICEDEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Outcollect' and month_type = 'Accural' and usage_type = 'Voice'";

$sqls{'CDMA_S_OUT_DATA'} =
"select  /*+ PARALLEL(h1,12) */ 'Settlement','','CDMA','Outcollect','Data',  sum(t1.amount), TRIM(REGEXP_REPLACE(t1.PARTNER,',')) as PARTNER, ADD_MONTHS(t1.settlement_date+1,-1)
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and (t1.process_date >= to_date('"
  . $sdate
  . "01', 'YYYYMMDD') and t1.process_date <= to_date('"
  . $sdate
  . "15', 'YYYYMMDD'))
         group by TRIM(REGEXP_REPLACE(t1.PARTNER,',')),t1.settlement_date order by 1,2";

$sqls{'CDMA_S_OUT_DATADEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Outcollect' and month_type = 'Settlement' and usage_type = 'Data'";

# Need to add BRMPRD

$sqls{'CDMA_A_OUT_DATA'} =
"select  /*+ PARALLEL(h1,12) */ 'Accrual','','CDMA','Outcollect','Data',  sum(t1.amount), TRIM(REGEXP_REPLACE(t1.PARTNER,',')) as PARTNER, ADD_MONTHS(t1.settlement_date+1,-1)
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and (t1.process_date >= to_date('"
  . $ldate
  . "16', 'YYYYMMDD') and t1.process_date < to_date('"
  . $sdate
  . "01', 'YYYYMMDD'))
         group by TRIM(REGEXP_REPLACE(t1.PARTNER,',')),t1.settlement_date order by 1,2";

$sqls{'CDMA_A_OUT_DATADEL'} =
"delete from APRM_STAGING where TECHNOLOGY = 'CDMA' and roaming = 'Outcollect' and month_type = 'Accrual' and usage_type = 'Data'";

my $dbconn  = getBODSPRD();
my $dbconnb = getSNDPRD();
my $dbconnc = getBRMPRD();

my @aprmArray = ();

if ( substr( $date, 6, 2 ) eq '01' ) {

	@aprmArray = (
		'LTE',            'DISP_RM',
		'NLDLT',          'CDMA_A_IN_VOICE',
		'CDMA_A_IN_DATA', 'CDMA_A_OUT_VOICE',
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

foreach my $report (@reports) {

	if ( $report eq "APRM" ) {
		loadAprm( \@aprmArray, $dbconn, $dbconnb, $dbconnc );
	}
	elsif ( $report eq "SAP" ) {
		loadSAP($dbconnb);
	}
	elsif ( $report eq "DCH" ) {
		loadDCH($date,$dbconnb);
	}
}

$dbconn->disconnect();
$dbconnb->disconnect();

exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "GooB00900#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getSNDPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "GooB00900#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getBRMPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:brmprd", "md1dbal1", "GooB00900#" );
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
		$conn2  = $dbconnb->prepare($sqldel);
		$conn2->execute() or sendErr();

		my $sql = $sqls{$wsql};

		print "$sql\n";

		if ( ( $wsql eq 'CDMA_A_OUT_DATA' ) || ( $wsql eq 'CDMA_S_OUT_DATA' ) )
		{
			$sth = $conn3->prepare($sql);
		}
		else {
			$sth = $conn->prepare($sql);
		}

		$sth->execute() or sendErr();
		while ( my @rows = $sth->fetchrow_array() ) {

			my $sql = "INSERT INTO ENTERPRISE_GEN_SANDBOX.APRM_STAGING (
   USAGE_TYPE, TECHNOLOGY, ROAMING, 
   PERIOD, MONTH_TYPE, COMPANY_CODE, 
   BID, AMOUNT_USD, AMOUNT_EUR) 
VALUES ( 
 '$rows[4]'      /* USAGE_TYPE */,
 '$rows[2]' 	   /* TECHNOLOGY */,
 '$rows[3]'      /* ROAMING */,
 '$rows[7]'      /* PERIOD */,
 '$rows[0]'      /* MONTH_TYPE */,
 '$rows[6]'      /* COMPANY_CODE */,
 '$rows[1]'      /* BID */,
 $rows[5]     /* AMOUNT_USD */,
 $rows[5]    /* AMOUNT_EUR */ )";

			#print "$sql\n";
			$conn2 = $dbconnb->prepare($sql);
			$conn2->execute() or sendErr();
		}

	}

}

sub loadDCH {

	my ( $date, $conn ) = @_;

	$date = substr( $date, 0, 6 )."01";
	
	my @results = [];

	my $sql = "select 
decode(usage_type,'LTE-V', 'Data','NLDLT-V', 'Data','NLDLT-C', 'Data', 'NLDLT-O', 'Voice', 'DISP_RM','Data'),
'4G',
 decode(usage_type,'LTE-V', 'Incollect','NLDLT-V', 'Incollect', 'NLDLT-C', 'Incollect', 'NLDLT-O', 'Incollect', 'DISP_RM','Outcollect'),                      
to_date('$date','YYYYMMDD'),
'Settlement',
receiver,
sender,
sum(total_charges_dch),
sum(total_charges_dch)
from file_summary where file_type = 'TAP'
and process_date <=add_months(to_date('$date','YYYYMMDD'),1) and process_date >= to_date('$date','YYYYMMDD')
group by usage_type,sender, receiver";

	my $sth = $conn->prepare($sql);
	$sth->execute() or sendErr();

	while ( my @rows = $sth->fetchrow_array() ) {
		my $sql = "INSERT INTO ENTERPRISE_GEN_SANDBOX.DCH_STAGING (
   USAGE_TYPE, TECHNOLOGY, ROAMING, 
   PERIOD, MONTH_TYPE, COMPANY_CODE, 
   BID, AMOUNT_USD, AMOUNT_EUR) 
VALUES ( 
 '$rows[0]'      /* USAGE_TYPE */,
 '$rows[1]' 	   /* TECHNOLOGY */,
 '$rows[2]'      /* ROAMING */,
 '$rows[3]'      /* PERIOD */,
 '$rows[4]'      /* MONTH_TYPE */,
 '$rows[5]'      /* COMPANY_CODE */,
 '$rows[6]'      /* BID */,
 $rows[7]     /* AMOUNT_USD */,
 $rows[7]    /* AMOUNT_EUR */ )";
 
 	my $sth = $conn->prepare($sql);
	$sth->execute() or sendErr();

	}

}

sub loadSAP {

	my ($conn2) = @_;

	my @results = [];

	my $hh =
"cat /home/dbalchen/workspace/volteRoaming/src/bin/SAP_StagingTable.csv | cut -f 10,3,5,8 | sort -u |";
	if ( !open( SAPLIST, "$hh" ) ) {
		errorExit("Cannot create SAPLIST: $!\n");
	}

	while ( my $buff = <SAPLIST> ) {
		chomp($buff);
		my ( $gl, $cocd, $docdate, $header ) = split( "\t", $buff );
		$hh =
"cat SAP_StagingTable.csv | grep $gl | grep $cocd | grep $docdate | grep $header | cut -f 4";
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
		}
		elsif ( ( index( $header, "GLLTNY3" ) >= 0 ) && ( $gl == 6008002 ) ) {
			$technology = "VoLTE";
			$roaming    = "Incollect";
			$data_type  = "Data";
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

		elsif ( ( index( $header, "GLINCY3" ) >= 0 ) && ( $gl == 6002201 ) ) {
			$technology = "CDMA";
			$roaming    = "Incollect";
			$data_type  = "Voice";
		}

		elsif ( ( index( $header, "GLINCY3" ) >= 0 ) && ( $gl == 6008001 ) ) {
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
			( index( $header, "Doc Type = SA and Ref Doc = [I]DATAREV" ) >= 0 )
			&& ( $gl == 5438001 ) )
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
		elsif ( ( index( $header, "GLINCY4" ) >= 0 ) && ( $gl == 6002201 ) ) {
			$technology = "CDMA";
			$roaming    = "Incollect";
			$data_type  = "Voice";
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
		elsif ( ( index( $header, "GLGSIY3" ) >= 0 ) && ( $gl == 6002202 ) ) {
			$technology = "GSM";
			$roaming    = "Incollect";
			$data_type  = "SMS";
		}
		elsif ( ( index( $header, "GLLTOY3" ) >= 0 ) && ( $gl == 5438001 ) ) {
			$technology = "LTE";
			$roaming    = "Outcollect";
			$data_type  = "Data";
		}
		elsif ( ( index( $header, "GLLTOY3" ) >= 0 ) && ( $gl == 5438002 ) ) {
			$technology = "VoLTE";
			$roaming    = "Outcollect";
			$data_type  = "Data";
		}

		my $sql = "INSERT INTO ENTERPRISE_GEN_SANDBOX.SAP_STAGING (
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
 					'Settlement' /* MONTH_TYPE */,
 					'$header' /* DOC_HEADER */,
 					'$cocd' /* COMPANY_CODE */,
 					$total /* AMOUNT */ 
 			)";

		$conn2 = $dbconnb->prepare($sql);
		$conn2->execute() or sendErr();
	}

}
