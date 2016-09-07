#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
$ARGV[0] = "SDIRI_FCIBER_ID000090_T20160829173752.DAT";

# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ORACLE_HOME/bin";

my $filename = $ARGV[0];

my $dbconn = getBODSPRD();

my $sql =
  "select file_name, identifier from ac1_control_hist where file_name like ?";

my $sth = $dbconn->prepare($sql);

$sth->bind_param( 1, $filename );
$sth->execute() or sendErr();

my @fileId = $sth->fetchrow_array();

$sql = "select 'IN_REC_QUANTITY',sum(in_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'LSN' 
     and cur_file_alias = 'CIBER' 
     and nxt_pgm_name = 'SPL' 
     and nxt_file_alias = 'CIBER'
union
select 'Dropped', sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'SPL' 
     and cur_file_alias = 'CBR_DRP' 
     and nxt_pgm_name = 'NONE' 
     and nxt_file_alias = 'CBR_DRP'
union
select 'Duplicates', sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'MD' 
     and cur_file_alias = 'CIBER_DUP' 
     and nxt_pgm_name = 'MD' 
     and nxt_file_alias = 'CIBER_DUP'
union
select 'SenttoTC', sum(in_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name||'|'||cur_file_alias||'|'||nxt_pgm_name||'|'||nxt_file_alias 
     in ('MD|TCUSAGE|File2E|Diameter','File2E|Diameter|File2E|Diameter')
union
select 'DroppedbyES', sum(dr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name||'|'||cur_file_alias||'|'||nxt_pgm_name||'|'||nxt_file_alias 
     in ('MD|TCUSAGE|File2E|Diameter','File2E|Diameter|File2E|Diameter')
union
select 'Rejected', sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'File2E' 
     and cur_file_alias = 'Diameter' 
     and nxt_pgm_name = 'NONE' 
     and nxt_file_alias = 'REJECT'
     union
select 'DuplicatebyES', sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = 518721734281200
     and cur_pgm_name = 'File2E' 
     and cur_file_alias = 'Diameter' 
     and nxt_pgm_name = 'NONE' 
     and nxt_file_alias = 'DUPLICATE'
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
  $reportVariable{$rows2[0]} = $rows2[1];
}

$sql = "select /*+ PARALLEL(t1,12) */ 'APRM_SUCCESS', count(*), sum(TOTAL_CHRG_AMOUNT)
    from usc_roam_evnts t1
    where
    prod_id = 2 and event_id <> 2
     and 
     ciber_file_name_1|| ciber_file_name_2  = '$fileId[0]'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my @aprm = $sth->fetchrow_array();


$sql = "select l9_channel, original_event_id, error_id, max(l9_original_air_time_chg_amt)  
    from ape1_rejected_event 
    where original_event_id 
     in (select unique(original_event_id) 
        from ape1_rejected_event 
        where physical_source = $fileId[1]) 
     and processing_status = 'CO' 
     and event_id = original_event_id 
group by  original_event_id, l9_channel, error_id";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

@errorRows = [];
while (my @rows3 = $sth->fetchrow_array() ) {
  push(@errorRows,\@rows3);
}



print $fileId[0]."\t".$fileId[1]."\t".$reportVariable{'IN_REC_QUANTITY'}."\t".$reportVariable{'Dropped'}."\t".$reportVariable{'Duplicates'}."\t".$reportVariable{'SenttoTC'}."\t".$reportVariable{'DroppedbyES'}."\t".$reportVariable{'Rejected'}."\t".$reportVariable{'DuplicatebyES'}."\t".$reportVariable{'Generate'}."\t".$aprm[1]."\t".$aprm[2]."\n";

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

