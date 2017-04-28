#! /usr/bin/perl

use DBI;

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $dbconn = getBODSPRD();
  
my $sql = "select home_sid, serve_sid,carrier_cd from USC_ROAM_EVNTS where BP_START_DATE = '16-APR-2017' group by home_sid,serve_sid,carrier_cd HAVING count(*) = 1";
$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while ( my @rows = $sth->fetchrow_array() ) {
	print "$rows[0]\t$rows[1]\t$rows[2]\n";
}

$dbconn->disconnect();

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