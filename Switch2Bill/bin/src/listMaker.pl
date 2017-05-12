#! /usr/local/bin/perl

use DBI;

# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $dbconn = getBODSPRD();
my $sql    = "(SELECT
               prim_resource_val,
               MIN
FROM                                                                     /*Gets List of MDN's/Min's for CDP customers*/
               (SELECT
                                 prim_resource_val,
                                 ar.resource_value AS MIN,
                                 ROW_NUMBER()
                                 OVER
                                  (
                                        PARTITION BY prim_resource_val
                                        ORDER BY DECODE(s.sub_status,  'A', 1,  'S', 1,  'D', 1,  'U', '1',  2), sub_status_date DESC
                                 )
                                        row_id
                    FROM
                                 subscriber s,
                                 table_customer tc,
                                 agreement_resource ar
                    WHERE
                                 tc.customer_id = TO_CHAR(s.customer_id)
                             --    AND tc.x_is_cdp = 1   --CDP indicator
                                 AND ar.agreement_no = s.subscriber_no
                                 AND ar.resource_type = 'MIN'
                                 AND ar.expiration_date IS NULL)
WHERE
               row_id = 1 and rownum < 1000)";
               
my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

open(MIN,"> minList.csv") || exit(1);
open(MDN,"> mdnList.csv") || exit(1);

print MDN "Header\n";
print MIN "Header\n";

while ( my @rows = $sth->fetchrow_array() ) {
	print MDN "$rows[0]\n";
	print MIN "$rows[1]\n";	
}

print MDN "Trailer\n";
print MIN "Trailer\n";

$dbconn->disconnect();

close(MDN);
close(MIN);

exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "GooB00900#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}
