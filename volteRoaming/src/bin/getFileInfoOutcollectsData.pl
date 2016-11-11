#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
#$ARGV[0] = "20161003";

# For test only.....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";


my $dbconn = getBRMPRD();

$sql = "select count(*), t2.clearinghouse, sum(t1.amount) as REVENUE, sum(message_accounting_digits) as DATA_VOLUME 
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and t1.process_date = to_date('$ARGV[0]','YYYYMMDD') group by t2.clearinghouse";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my $filename = 'DATA_CIBER_'.$ARGV[0];
my $reportFile = $filename.'.rpt.csv';
open( RPT, ">$reportFile" ) || errorExit("Could not open log file.... OutCollect!!!!");

while (my @rows = $sth->fetchrow_array() ) {
  
  print RPT $rows[1]."\t".$rows[0]."\t".$rows[2]."\t".$rows[3]."\n";

}
close(RPT);


$sql = "select TRIM(REGEXP_REPLACE(t1.PARTNER,',')) as PARTNER, t1.settlement_date,t2.clearinghouse, sum(t1.amount) as REVENUE, sum(message_accounting_digits) as DATA_VOLUME 
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and t1.process_date = to_date('$ARGV[0]','YYYYMMDD') group by TRIM(REGEXP_REPLACE(t1.PARTNER,',')),t2.clearinghouse, t1.settlement_date order by 1,2";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my $reportFile = $filename.'.partner.csv';
open( RPT, ">$reportFile" ) || errorExit("Could not open log file.... OutCollect!!!!");

while (my @rows = $sth->fetchrow_array() ) {
  
  print RPT $rows[0]."\t".$rows[1]."\t".$rows[2]."\t".$rows[3]."\t".$rows[4]."\n";

}

close(RPT);

$dbconn->disconnect();


exit(0);

sub getBRMPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:brmprd", "md1dbal1", "500#Reptar" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

