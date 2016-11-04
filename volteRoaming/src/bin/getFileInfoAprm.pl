#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
#$ARGV[0] = "/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DIRI/SDIRI_FCIBER_ID001117_T20161003182199.DAT";

# For test only.....
# my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
# my $ORACLE_SID  = "bodsprd";
# $ENV{ORACLE_HOME} = $ORACLE_HOME;
# $ENV{ORACLE_SID}  = $ORACLE_SID;
# $ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $filetype = $ARGV[0].'%'.$ARGV[1].'%';


my $dbconn = getBODSPRD();

my $sql = 'select /*+ PARALLEL(h1,12) */ home_company, carrier_cd, bp_start_date, count(*), sum(usage),sum(TOTAL_CHRG_AMOUNT) from USC_ROAM_EVNTS where (ciber_file_name_1||ciber_file_name_2 like '."'".$filetype."') and generated_rec < 2 group by home_company, carrier_cd, bp_start_date order by home_company";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();


my $filename = $ARGV[0].$ARGV[1].'.arpm.csv';
    
open( RPT, ">$filename" ) || errorExit("Report Failed!!!!");

while (my @rows = $sth->fetchrow_array() ) {

  print RPT "$rows[0]\t$rows[1]\t$rows[2]\t$rows[3]\t$rows[4]\t$rows[5]\n";

}

close(RPT);
$dbconn->disconnect();

exit(0);

sub getBODSPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "500#Reptar" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

