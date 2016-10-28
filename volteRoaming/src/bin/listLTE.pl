#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
# $ARGV[0] = "20161003";

# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";


my $dbconn = getBRMPRD();

$sql = "select t1.file_name,decode(t2.sender,'IWB51','US Cellula (IWB51)r','NLDLT','Vodafone Netherland (NLDLT)','USA6G','Nex-Tech Wireless (USA6G)','USAAT','ATT Mobility (USAAT)','USABS','ATT Mobility (USABS)','USACC','ATT Mobility (USACC)','USACG','ATT Mobility (USACG)','USAMF','ATT Mobility (USAMF)','USAPB','ATT Mobility (USAPB)','USASG','Sprint (USASG)','USASP','Sprint (USASP)','USATM','T-Mobile (USATM)','USAUD','US Cellular (USAUD)','USAVZ','Verizon (USAVZ)','USAW6','T-Mobile (USAW6)') as sender,t2.sequence_num,t2.events_count,t2.total_value,count(t3.S_402) ".'"'."Rejected ARCM".'"'.",sum(t3.S_402) ".'"'."Reject Sum".'"'." from smm1_collect_files_hist t1, SMM1_ARCM_FILE_REPOSITORY t2, em1_record t3 where t1.file_name = t2.file_name and t1.file_name = t3.S_444 and t1.physical_date >= to_date('$ARGV[0]','YYYYMMDD')  and  t1.physical_date < (to_date('$ARGV[0]','YYYYMMDD') + 1) and t1.file_format = 'TAPIN' and  t3.stream_name='INC'  and t3.record_status<>55 group by  t1.file_name, t2.sender,t2.recipient,t2.sequence_num,t2.events_count,t2.total_value";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

while (my @rows = $sth->fetchrow_array() ) {

  print '"'."$rows[0],$rows[2],$rows[1],$rows[3],$rows[4],$rows[5],$rows[6],$ARGV[0]".'"'."\n";
}

$dbconn->disconnect();

exit(0);

sub getBRMPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "500#Reptar" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

