#! /usr/local/bin/perl
# use strict;
use DBI;

#Test parameters remove when going to production.
$ARGV[0] = "/inf_nas/apm1/prod/aprmoper/var/usc/DISP/DISP_RM_000064260_20161026_023328.ASC.done";

# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";


my $hh = "wc -l < $ARGV[0]";

my $totalRecs = `$hh`;chomp($totalRecs);
my $filename = (split('/',$ARGV[0]))[-1];

my $disp_file_seq = (split('_',$filename))[2];

$disp_file_seq =~ s/^0+//g;

my $dbconn = getAPRM();

my $sql = "select /*+ PARALLEL(t1,12) */  TAP_OUT_FILE_NAME, count(*), sum(Data_vol_incoming) + sum(Data_vol_incoming)  from prdappc.prm_rom_outcol_events where disp_file_seq = $disp_file_seq group by TAP_OUT_FILE_NAME";

my $sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my $report = $filename.'.rpt.csv';

open( RPT, ">$report" ) || errorExit("Could not open error file.... Fail!!!!");

print RPT "$filename\t$disp_file_seq\t$totalRecs\n";

while (my @rows = $sth->fetchrow_array() ) {

    print RPT $rows[0]."\t".$disp_file_seq."\t"."\t\t".$rows[1]."\t".$rows[2]."\n";
    
}

close(RPT);

$dbconn->disconnect();

exit(0);


sub getAPRM {

  #	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
  #	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
  my $dbods = DBI->connect( "dbi:Oracle:PRDAPRM", "md1dbal1", "500#Reptar" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

