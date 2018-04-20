#! /usr/local/bin/perl

use DBI;
use Time::Piece;
use Time::Seconds;

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin/';

#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon2/';

$dbconn = getBODSPRD();

#$dbconnb = getSNDPRD();

$dbconnb = $dbconn;

my $file = $ARGV[0];

#$file =
#"/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output/CIBER_CIBER_20170622121615_3155473_0021.dat.done";

my $filename = ( split( "/", $file ) )[-1];

my $fileDate = "";
my ( $month_type, $tech, $roaming, $usage_type );

my $sql = "delete from DCH_STAGING where FILENAME = '$filename'";
$sthb = $dbconnb->prepare($sql);

$sthb->execute() or sendErr();

my $dch = "$ENV{'REC_HOME'}/OutcollectDCH_voice.csv";

my %dchHash = {};

if (   ( index( $file, "SDATACBR" ) > 0 )
	|| ( index( $file, "SDIRI_FCIBER" ) > 0 ) )
{
	$fileDate = substr( ( ( split( '_', $file ) )[-1] ), 1, 8 );
}
else {

	$fileDate = substr( ( ( split( '_', $file ) )[2] ), 0, 8 );

}

if ( ( substr( $fileDate, 6, 2 ) >= 1 ) && ( substr( $fileDate, 6, 2 ) <= 15 ) )
{
	$month_type = "Settlement";
}
else {

	$month_type = "Accrual";
}

$sql = "";

my $hh = "$ENV{'REC_HOME'}/dchList.pl $fileDate";

#system("$hh");

if (   ( index( $file, "SDATACBR" ) > 0 )
	|| ( index( $file, "SDIRI_FCIBER" ) > 0 ) )
{
	$sql =
"select a.SIDs, B.COMPANY from PC9_SID a, AR9_ACCOUNT_STATE b where SUBSTR(a.GEO_CODE,1,5) = b.geo_code and a.geo_code is not null 
 and a.expiration_date > to_date('$fileDate','YYYYMMDD') and to_date('$fileDate','YYYYMMDD') >= effective_date";

	$tech    = "CDMA";
	$roaming = "Incollect";

	if ( index( $file, "SDATACBR" ) > 0 ) {
		$usage_type = "Data";
	}

	if ( index( $file, "SDIRI_FCIBER" ) > 0 ) {
		$usage_type = "Voice";
	}

}
else {

	my $hh = "cat $dch | cut -f 2,3,4,5,8 |";

	open( DCH, "$hh" ) || exit(1);
	while ( my $buff = <DCH> ) {
		chomp($buff);
		my @dchInfo = split( /\t/, $buff );

		my $key2 = $dchInfo[1] . $dchInfo[2] . $dchInfo[3];

		$dchHash{$key2} = "$dchInfo[4]\t$dchInfo[0]";

	}

	$sql =
"select sids,'0'||setlmnt_contract_cd  from pc9_sid where expiration_date > to_date('$fileDate','YYYYMMDD') 
	and to_date('$fileDate','YYYYMMDD') >= effective_date and originating_category = 'NUSCC'";

	$usage_type = "Voice";
	$tech       = "CDMA";
	$roaming    = "Outcollect";

}

my %companyCode = {};

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while ( my @results = $sth->fetchrow_array() ) {
	$companyCode{ $results[0] } = $results[1];
}

my $stream = "< $file";

if ( $roaming eq "Outcollect" ) {
	$stream = "cat $file " . '|' . " grep '^98' " . '|' . " sort -u " . '|';
}

open( FILE, $stream ) || exit(1);

my $period = "";

my %loadArry = {};

my ( $serve_sid, $home_sid, $cost, $company_code );

while ( my $buff = <FILE> ) {
	chomp($buff);

	if ( substr( $buff, 0, 2 ) eq '01' ) {
		$period = "20" . substr( $buff, 26, 6 );
		next;
	}

	if (   ( substr( $buff, 0, 2 ) ne '01' )
		&& ( substr( $buff, 0, 2 ) ne '98' ) )
	{
		$serve_sid = substr( $buff, 66, 5 );
		$home_sid  = substr( $buff, 8,  5 );
		$cost      = substr( $buff, 71, 10 ) / 100;
		$company_code = $companyCode{$home_sid};
		$key          = $serve_sid . $company_code . $period;

		#print "$serve_sid, $home_sid, $cost, $company_code\n";
	}

	if ( substr( $buff, 0, 2 ) eq '98' ) {
		if ( $roaming eq "Outcollect" ) {
			$home_sid  = substr( $buff, 11, 5 );
			$serve_sid = substr( $buff, 16, 5 );
			my $seq = substr( $buff, 8, 3 );
			$period = "20" . substr( $buff, 37, 6 );

#			my $hh =
#"cat $dch | cut -f 1,2,3,5,7 | grep  '^$serve_sid'  | grep  $home_sid | grep $seq";
#			my $res = `$hh`;

			my $key2 = $serve_sid . $home_sid . '0' . $seq;

			$cost         = ( split( "\t", $dchHash{$key2} ) )[-2];
			$company_code = $companyCode{$serve_sid};
			$key          = $home_sid . $company_code . $period;

		}
		else {
			next;
		}
	}

	#print "Key = $key\n";

	if ( exists $loadArry{$key} ) {
		$loadArry{$key} = $loadArry{$key} + $cost;
	}
	else {
		$loadArry{$key} = $cost;
	}
}

my $count = 0;
for my $key ( keys %loadArry ) {

	if ( defined $loadArry{$key} ) {
		$serve_sid    = substr( $key, 0, 5 );
		$company_code = substr( $key, 5, 4 );
		$period       = substr( $key, 9, 8 );
		$cost         = $loadArry{$key};

		#		print "Key = $key\n";
		check_addDB(
			$filename, $month_type,   $serve_sid,
			$tech,     $roaming,      $usage_type,
			$cost,     $company_code, $period
		);
	}

}

exit(0);

sub check_addDB {
	my (
		$filename,   $month_type, $serve_sid,    $tech, $roaming,
		$usage_type, $cost,       $company_code, $period
	) = @_;

	my $today = Time::Piece->strptime( "$period", "%Y%m%d" );
	$today = ( $today - ONE_MONTH );
	$period = $today->year . pad( $today->mon, '0', 2 ) . "16";

	my $sql = "INSERT INTO DCH_STAGING (
   FILENAME,USAGE_TYPE, TECHNOLOGY, ROAMING, 
   PERIOD, MONTH_TYPE, COMPANY_CODE, 
   BID, AMOUNT_USD, AMOUNT_EUR) 
VALUES ( 
 '$filename'       /* File Name */,
 '$usage_type'     /* USAGE_TYPE */,
 '$tech'           /* TECHNOLOGY */,
 '$roaming'        /* ROAMING */,
  to_date('$period','YYYYMMDD')          /* PERIOD */,
 '$month_type'     /* MONTH_TYPE */,
 '$company_code'   /* COMPANY_CODE */,
 '$serve_sid'      /* BID */,
 $cost           /* AMOUNT_USD */,
 $cost           /* AMOUNT_EUR */ )";

	# print "$sql\n";

	$sthb = $dbconnb->prepare($sql);

	$sthb->execute() or sendErr();

}

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "BooGoo900#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getSNDPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "BooGoo900#" );
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
