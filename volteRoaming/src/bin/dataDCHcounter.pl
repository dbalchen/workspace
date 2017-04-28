#! /usr/bin/perl

use DBI;

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$dbconn  = getBODSPRD();
$dbconnb = getSNDPRD();

my $file = $ARGV[0];

$file =
"/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DATACBR/SDATACBR_FDATACBR_ID026147_T20170401190301.DAT";


my ( $month_type,$tech, $roaming, $usage_type);

if(index($file,"SDATACBR") >0 )
{
	$month_type = "Accrual";
	$tech = "CDMA";
	$roaming = "Incollect";
	$usage_type = "Data";
	
}

			
open( FILE, "< $file" ) || exit(1);

my $sql        = '';
my $period = "";

while ( my $buff = <FILE> ) {
	chomp($buff);

	if ( substr( $buff, 0, 2 ) eq '01' ) {
		$period = "20" . substr( $buff, 26, 6 );
	}

	if ( substr( $buff, 0, 2 ) eq '32' ) {

		my $serve_sid = substr( $buff, 66, 5 );
		my $home_sid  = substr( $buff, 8,  5 );
		my $cost      = substr( $buff, 71, 10 )/100;

		$sql = "SELECT COMPANY FROM AR9_ACCOUNT_STATE WHERE GEO_CODE = (SELECT SUBSTR(GEO_CODE,1,5) FROM PC9_SID WHERE SIDS = '$home_sid')";
		my $sth = $dbconn->prepare($sql);
		$sth->execute() or sendErr();

		my $company_code = $sth->fetchrow_array();
		check_addDB($month_type, $serve_sid, $tech, $roaming, $usage_type, $cost,
		$company_code, $period);

	}
}

exit(0);

sub check_addDB {
	my ( $month_type, $serve_sid, $tech, $roaming, $usage_type, $cost,
		$company_code, $period )
	  = @_;

	my $sql =
"select amount_usd from DCH_STAGING where month_type = '$month_type' and bid = '$serve_sid' 
	and technology = '$tech' and roaming = '$roaming' and usage_type = '$usage_type' and company_code = $company_code
	and period = to_date('$period','YYYYMMDD')";

	my $sthb = $dbconnb->prepare($sql);
	$sthb->execute() or sendErr();

	my @results = $sthb->fetchrow_array();

	if ( @results == 0 ) {

		$sql = "INSERT INTO ENTERPRISE_GEN_SANDBOX.DCH_STAGING (
   USAGE_TYPE, TECHNOLOGY, ROAMING, 
   PERIOD, MONTH_TYPE, COMPANY_CODE, 
   BID, AMOUNT_USD, AMOUNT_EUR) 
VALUES ( 
 '$usage_type'     /* USAGE_TYPE */,
 '$tech'           /* TECHNOLOGY */,
 '$roaming'        /* ROAMING */,
  to_date('$period','YYYYMMDD')          /* PERIOD */,
 '$month_type'     /* MONTH_TYPE */,
 '$company_code'   /* COMPANY_CODE */,
 '$serve_sid'      /* BID */,
 $cost           /* AMOUNT_USD */,
 $cost           /* AMOUNT_EUR */ )";

	}
	else {

		$cost = $results[0] + $cost;

		$sql = "UPDATE ENTERPRISE_GEN_SANDBOX.DCH_STAGING
SET AMOUNT_USD   = $cost, AMOUNT_EUR   = $cost
    where month_type = '$month_type' and bid = '$serve_sid' 
	and technology = '$tech' and roaming = '$roaming' and usage_type = '$usage_type'
	and company_code = '$company_code' and period = to_date('$period','YYYYMMDD')";
	}
	
	$sthb = $dbconnb->prepare($sql);
	$sthb->execute() or sendErr();

}

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

