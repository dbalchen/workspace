#! /usr/bin/perl
use DBI;

$ARGV[0] = "CarrerID_List.csv";
$ARGV[1] = '20170211';

# # For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $dbconn  = getBODSPRD();
my %dchInfo = {};


my $hh = "cat $ARGV[0] |";

open( PIPE, $hh ) or exit(1);

while ( my $buff = <PIPE> ) {
	chomp($buff);

	my($cc,$cn,$key,$sn,$ss,$sc) = split(/\t/,$buff);

	my $sql = "select setlmnt_contract_cd from pc9_sid where expiration_date > sysdate and sysdate >= effective_date and sids = '$key'";
	my $sth = $dbconn->prepare($sql);
	$sth->execute() or sendErr();

	$key = $sth->fetchrow_array();

        if(length($key) > 0) {
	print "$buff\t$key\n";
	}
}

exit(0);

sub getBODSPRD {
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "BooG00900#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}
