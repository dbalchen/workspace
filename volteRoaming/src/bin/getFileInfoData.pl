#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
#$ARGV[0] = "/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DATACBR/SDATACBR_FDATACBR_ID023533_T20161003203301.DAT";

# For test only.....
# my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
# my $ORACLE_SID  = "bodsprd";
# $ENV{ORACLE_HOME} = $ORACLE_HOME;
# $ENV{ORACLE_SID}  = $ORACLE_SID;
# $ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $hh = "cat $ARGV[0] | grep '^98' | sort -u | cut -b 26-37| awk '{ sum+=".'$1'."} END {print sum}'";

my $filesum = `$hh`; $filesum = $filesum/100;

my $filename = (split('/',$ARGV[0]))[-1];

my $dbconn = getBODSPRD();

my $sql = "select file_name, identifier from ac1_control_hist where file_name like ?";

my $sth = $dbconn->prepare($sql);

$sth->bind_param( 1, $filename );
$sth->execute() or sendErr();

my @fileId = $sth->fetchrow_array();

if($fileId[1] eq "")
{
my $reportFile = $filename.'.rpt.csv';
open( RPT, ">$reportFile" ) || errorExit("Could not open log file.... Recon Failed!!!!");
print RPT $filename."\t"."File still processing\n";
close(RPT);
$reportFile = $filename.'.err.csv';
open( ERR, ">$reportFile" ) || errorExit("Could not open log file.... Recon Failed!!!!");
print ERR $filename."\t"."File still processing\n";
close(ERR);
$dbconn->disconnect();exit(0);
}

$sql = "select 'IN_REC_QUANTITY', sum(in_rec_quantity) 
     from ac1_control_hist 
     where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'LSN' 
      and cur_file_alias = 'DATACBR' 
      and nxt_pgm_name = 'MD' 
      and nxt_file_alias = 'DATACBR'
union
select 'Dropped', sum(wr_rec_quantity) 
                from ac1_control_hist 
                where phy_file_ident = $fileId[1]
                and cur_pgm_name = 'MD' 
                 and cur_file_alias = 'DATA_DRP' 
                 and nxt_pgm_name = 'NONE' 
                 and nxt_file_alias = 'DATA_DRP'
union
select 'SenttoTC',sum(wr_rec_quantity) 
     from ac1_control_hist 
     where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'MD' 
      and cur_file_alias = 'TCUSAGE' 
      and nxt_pgm_name = 'File2E' 
      and nxt_file_alias = 'Diameter'
union
select 'Rejected',sum(wr_rec_quantity) 
     from ac1_control_hist 
     where phy_file_ident =$fileId[1]
     and cur_pgm_name = 'File2E' 
      and cur_file_alias = 'Diameter' 
      and nxt_pgm_name = 'NONE' 
      and nxt_file_alias = 'REJECT'
     union
select 'Generate',sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'File2E' 
     and cur_file_alias = 'Diameter' 
     and nxt_pgm_name = 'NONE' 
     and nxt_file_alias = 'GENERATE'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my %reportVariable = {};
while (my @rows2 = $sth->fetchrow_array() ) {

  $rows2[1] =~ s/\s+//g;

  if (length($rows2[1]) == 0) {
    $rows2[1] = 0;
  }
  
  $reportVariable{$rows2[0]} = $rows2[1];
}

$sql = "select /*+ PARALLEL(t1,12) */ 'APRM_SUCCESS', count(*), cast(sum(TOTAL_CHRG_AMOUNT) as decimal (18,2))
    from usc_roam_evnts t1
    where
    prod_id = 2 and event_id = 2
     and 
     ciber_file_name_1||ciber_file_name_2  = '$fileId[0]'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my @aprm = $sth->fetchrow_array();


$sql = "select l9_channel, error_id, error_desc,  cast(max(l9_original_air_time_chg_amt) as decimal (18,2)) 
     from ape1_rejected_event 
     where original_event_id
      in (select unique(original_event_id)
           from ape1_rejected_event
           where physical_source = $fileId[1])
      and event_id = original_event_id
group by  original_event_id, l9_channel, error_id,error_desc";


$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my $errorRpt = $filename.'.err'.'.csv';
open( ERR, ">$errorRpt" ) || errorExit("Could not open error file.... Fail!!!!");
my $rejectSum = 0;

while (my @rows3 = $sth->fetchrow_array() ) {
    $rejectSum = $rejectSum + $rows3[3];

    $rows3[2] = (split('<',$rows3[2]))[0];
  
  print ERR $rows3[0]."\t".$rows3[1]."\t".$rows3[2]."\t".$rows3[3]."\n";

}

close(ERR);

my $reportFile = $filename.'.rpt.csv';

open( RPT, ">$reportFile" ) || errorExit("Could not open log file.... CallDump Failed!!!!");
my $aprmdiff = ($reportVariable{'SenttoTC'} - ($reportVariable{'Rejected'})) - $aprm[1];

print RPT $fileId[0]."\t".$fileId[1]."\t".$reportVariable{'IN_REC_QUANTITY'}."\t".$filesum."\t".$reportVariable{'Dropped'}."\t".$reportVariable{'SenttoTC'}."\t".$reportVariable{'Rejected'}."\t".$rejectSum."\t".$aprmdiff."\t".$aprm[1]."\t".$aprm[2]."\n";

close(RPT);

$dbconn->disconnect();
exit(0);

sub getBODSPRD {

#  my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
#  my $dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
   my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "500#Reptar" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

