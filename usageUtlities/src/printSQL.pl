#! /usr/local/bin/perl

use DBI;

#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $sql = $ARGV[0];

my $dbconn = getBODSPRD();

$sql = "cat $sql";
$sql = `$sql`;

my $sth = $dbconn->prepare($sql);

$sth->execute() or sendErr();

while ( my @rows = $sth->fetchrow_array() ) {

	for ( my $cols = 0 ; $cols < ( @rows - 1 ) ; $cols++ ) {
		print "$rows[$cols]\t";
	}

	print "$rows[@rows -1]\n";

}

$dbconn->disconnect();

exit(0);

sub getBODSPRD {

	my $dbPwd = "BODS_SVC_BILLINGOPS";

	 my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );

#	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "Reptar5000#" );

	unless ( defined $dbods ) {
		sendErr();
	}

	return $dbods;
}
