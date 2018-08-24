#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.

# For test only.....
# my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";
#$ARGV[0] = "20180805";
#$ARGV[1] = "NLDLT";

my $gsm = " and t1.file_name not like '" . '%NLDLT%' . "' ";

if ( $ARGV[1] eq "NLDLT" ) {
	$gsm = " and t1.file_name like '" . '%NLDLT%' . "' ";
}

my $dbconn = getBRMPRD();

my $sql = "select t1.file_name,
    decode(t2.sender,'IWB51','US Cellula (IWB51)r','NLDLT','Vodafone Netherland (NLDLT)','USA6G','Nex-Tech Wireless (USA6G)','USAAT','ATT Mobility (USAAT)','USABS','ATT Mobility (USABS)','USACC',
    'ATT Mobility (USACC)','USACG','ATT Mobility (USACG)','USAMF','ATT Mobility (USAMF)','USAPB','ATT Mobility (USAPB)','USASG','Sprint (USASG)','USASP','Sprint (USASP)','USATM','T-Mobile (USATM)','USAUD',
    'US Cellular (USAUD)','USAVZ','Verizon (USAVZ)','USAW6','T-Mobile (USAW6)') as sender
    ,t2.sequence_num, t2.events_count, t2.total_value
     from smm1_collect_files_hist t1, SMM1_ARCM_FILE_REPOSITORY t2, em1_record t3 where t1.file_name = t2.file_name $gsm 
     and t1.physical_date >= to_date('$ARGV[0]','YYYYMMDD')  and  t1.physical_date < (to_date('$ARGV[0]','YYYYMMDD') + 1) and t1.file_format = 'TAPIN' 
     group by  t1.file_name, t2.sender,t2.recipient,t2.sequence_num,t2.events_count,t2.total_value";

#print "$sql\n";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while ( my @rows = $sth->fetchrow_array() ) {

	$sql =
"select count(S_402),sum(S_402) from em1_record where record_status <> 55 and stream_name = 'INC' and S_444 = '$rows[0]'";
	my $sth2 = $dbconn->prepare($sql);
	$sth2->execute() or sendErr();
	my @rows2 = $sth2->fetchrow_array();

	if ( $rows2[1] eq "" ) {
		$rows2[1] = 0;
	}

	print '"'
	  . "$rows[0],$rows[2],$rows[1],$rows[3],$rows[4],$rows2[0],$rows2[1],$ARGV[0]"
	  . '"' . "\n";
}

$dbconn->disconnect();

exit(0);

sub getBRMPRD {
	my $dbPwd = "BODS_DAV_BILLINGOPS";
	my $dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	#my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "9000#GooBoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

