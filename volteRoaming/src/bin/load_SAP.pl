#! /usr/local/bin/perl
use DBI;

## For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

$ARGV[0] = '/home/dbalchen/Desktop/SAP_IO_Roaming_Month_End_March5th.csv';

$filename = $ARGV[0];

my $dbconn = getBODSPRD();

my $dbconnb = $dbconn;

loadSAP($dbconnb);

$dbconn->disconnect();
$dbconnb->disconnect();
$dbconnc->disconnect();

exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "Potat000#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub loadSAP {

	my ($conn2) = @_;

	my @results = [];

	my $hh = "cat $filename | cut -f 2,4,6,7 | sort -u |";
	if ( !open( SAPLIST, "$hh" ) ) {
		errorExit("Cannot create SAPLIST: $!\n");
	}

	while ( my $buff = <SAPLIST> ) {
		chomp($buff);
		
		my ( $gl, $cocd, $docdate, $header ) = split( "\t", $buff );
		
		$hh = "cat $filename | grep $gl | grep $cocd | grep $docdate | grep $header | cut -f 3";
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
		else {

			print "WTF --- $hh\n";
			next;
		}

		my $month_type = "Settlement";

		my $sql =
"delete from SAP_STAGING where USAGE_TYPE = '$data_type' and TECHNOLOGY = '$technology' 
		and ROAMING = '$roaming' and PERIOD = to_date('$docdate','MM/DD/YYYY') and MONTH_TYPE = '$month_type' and DOC_HEADER = '$header'
		and  COMPANY_CODE = '$cocd'";

		$conn2 = $dbconnb->prepare($sql);
		$conn2->execute() or sendErr();

		$sql = "INSERT INTO SAP_STAGING (
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
 					'$month_type' /* MONTH_TYPE */,
 					'$header' /* DOC_HEADER */,
 					'$cocd' /* COMPANY_CODE */,
 					$total /* AMOUNT */ 
 			)";

# print "$data_type\t$technology\t$roaming\t$docdate\t$header\t$cocd\t$total\n";

		$conn2 = $dbconnb->prepare($sql);
		$conn2->execute() or sendErr();
	}

}
