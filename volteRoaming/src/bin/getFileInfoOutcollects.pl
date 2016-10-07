#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
#$ARGV[0] = "/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output/CIBER_CIBER_20161003003530_268683_0006.dat.done";

# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $hh = "cat $ARGV[0] | grep '^98' | sort -u | cut -b 26-37| awk '{ sum+=".'$1'."} END {print sum}'";

my $filesum = `$hh`; chomp($filesum);$filesum = $filesum/100;

my $hh = "cat $ARGV[0] | grep '^98' | sort -u | cut -b 22-25| awk '{ sum+=".'$1'."} END {print sum}'";
my $fileTotal = `$hh`;
chomp($fileTotal);

my $filename = (split('/',$ARGV[0]))[-1];
my $filename2 = $filename;
$filename2 =~ s/.done//;

my $dbconn = getBODSPRD();

$sql = "select /*+ PARALLEL(t1,12) */ 'APRM_SUCCESS', count(*), cast(sum(TOTAL_CHRG_AMOUNT) as decimal (18,2))
         from usc_roam_evnts t1 where generated_rec < 2 and prod_id = 3 
         and ciber_file_name_1|| ciber_file_name_2  = '$filename2'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my @aprm = $sth->fetchrow_array();


my $reportFile = $filename.'.rpt.csv';

open( RPT, ">$reportFile" ) || errorExit("Could not open log file.... CallDump Failed!!!!");

print RPT $filename."\t".$fileTotal."\t".$filesum."\t".$aprm[1]."\t".$aprm[2]."\n";

close(RPT);

$dbconn->disconnect();
exit(0);

sub getBODSPRD {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "Reptar500#" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

