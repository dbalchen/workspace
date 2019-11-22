#! /usr/local/bin/perl

use DBI;

my $dbconn  = getBODSPRD();

my $sql = `cat ../lib/voice.sql`;

my $sth = $dbconn->prepare($sql);
	
$sth->execute() or sendErr();

while ( my @rows = $sth->fetchrow_array() ) {
	
}

$dbconn->disconnect();

exit(0);

sub getBODSPRD {

	my $dbPwd = "BODS_SVC_BILLINGOPS";

	# my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );

	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "P0tat000#" );
	
	unless ( defined $dbods ) {
		sendErr();
	}
	
	return $dbods;
}