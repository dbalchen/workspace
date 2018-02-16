#! /usr/local/bin/perl

use DBI;

my %imsiH = {};

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $conn = getBODSPRD();

open( STDIN, "< /home/dbalchen/Desktop/testData" ) || exit(0);

while ( my $buff = <STDIN> ) {
	chomp($buff);

	my $sql = '';
	
	my @splitA = split( /\|/, $buff );

	my @cusInfo = ( 0, 0, 0 );

	if ( defined $imsiH{ $splitA[53] } ) {
		@cusInfo = @{ $imsiH{ $splitA[53] } };
	}
	else {
		$sql = "select customer_id, Subscriber_id, bill_cycle 
			       from agd1_resources where resource_type = 23 and resource_value = '$splitA[53]' 
			       and effective_date <= '27-JAN-2018' and expiration_date >= '27-JAN-2018'";

		my $sth = '';

		$sth = $conn->prepare($sql);
		$sth->execute() or sendErr();

		@cusInfo = $sth->fetchrow_array();

		$imsiH{ $splitA[1] } = \@cusInfo;
	}
	
	my $volume = $splitA[39] + $splitA[40];
	my $edate = $splitA[7].substr($splitA[8],0,6);
	
	$sql = "select count(*)"
		   ."from ape1_rated_event"
#		   ." where start_time >= '27-JAN-2018' and start_time < '28-JAN-2018'"
           ." where start_time = to_date('$edate','YYYYMMDDHH24MISS')"
				." and event_type_ID = 69 and l3_payment_category = 'PRE'" 
				." and customer_id = $cusInfo[0] and subscriber_id = $cusInfo[1]" 
				." and cycle_code = $cusInfo[2] and l3_volume = $volume";

		my $sth = '';

		$sth = $conn->prepare($sql);
		$sth->execute() or sendErr();

		my $total = $sth->fetchrow_array();
	
	if ($total == 0)
	{
		print "Missing: $buff\n";
		print "SQL: $sql\n";
	}	

}


close(STDIN);

$conn->disconnect();
exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "#5000Reptar" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

#
#
# To work gunzip -c *2018012[3,4,5,6,7]*gz | grep 'DR' | cut -d'|' -f6,8,37,40,41 | grep '^10105' | ./
#
#
