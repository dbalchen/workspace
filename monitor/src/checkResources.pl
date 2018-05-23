#! /usr/local/bin/perl

use DBI;

my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

open( STDIN, "< /home/dbalchen/Desktop/test.csv" ) || exit(0);

my $conn = getBODSPRD();

while ( my $buff = <STDIN> ) {
	chomp($buff);

	@splitA = split( /\t/, $buff );



	my $sql = "select CUSTOMER_ID,subscriber_id,BILL_CYCLE,EFFECTIVE_DATE,EXPIRATION_DATE,LARGE_CUST_IND,PAYMENT_CATEGORY,resource_value,RESOURCE_TYPE,SUB_STATUS,update_id
	 from agd1_resources where resource_type = $splitA[0] and resource_value = '$splitA[1]' and effective_date <= sysdate and expiration_date >= sysdate";

		$sth = $conn->prepare($sql);
		$sth->execute() or sendErr();


	while ( my @rows = $sth->fetchrow_array() ) {
		print "$rows[0]\t$rows[1]\t$rows[2]\t$rows[3]\t$rows[4]\t$rows[5]\t$rows[6]\t$rows[7]\t$rows[8]\t$rows[9]\t$rows[10]\n"
		
	}

}

close(STDIN);

$conn->disconnect();
exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "BooGoo900#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}
