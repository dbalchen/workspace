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

my @rows = $sth->fetchrow_array();

$sql = "select 'IN_REC_QUANTITY',sum(in_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $rows[1]
     and cur_pgm_name = 'LSN' 
     and cur_file_alias = 'CIBER' 
     and nxt_pgm_name = 'SPL' 
     and nxt_file_alias = 'CIBER'
union
select 'Dropped', sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $rows[1]
     and cur_pgm_name = 'SPL' 
     and cur_file_alias = 'CBR_DRP' 
     and nxt_pgm_name = 'NONE' 
     and nxt_file_alias = 'CBR_DRP'
union
select 'Duplicates', sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $rows[1]
     and cur_pgm_name = 'MD' 
     and cur_file_alias = 'CIBER_DUP' 
     and nxt_pgm_name = 'MD' 
     and nxt_file_alias = 'CIBER_DUP'
union
select 'SenttoTC', sum(in_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $rows[1]
     and cur_pgm_name||'|'||cur_file_alias||'|'||nxt_pgm_name||'|'||nxt_file_alias 
     in ('MD|TCUSAGE|File2E|Diameter','File2E|Diameter|File2E|Diameter')
union
select 'DroppedbyES', sum(dr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $rows[1]
     and cur_pgm_name||'|'||cur_file_alias||'|'||nxt_pgm_name||'|'||nxt_file_alias 
     in ('MD|TCUSAGE|File2E|Diameter','File2E|Diameter|File2E|Diameter')
union
select 'Rejected', sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $rows[1]
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
    where phy_file_ident = $rows[1]
     and cur_pgm_name = 'File2E' 
     and cur_file_alias = 'Diameter' 
     and nxt_pgm_name = 'NONE' 
     and nxt_file_alias = 'GENERATE'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my %reportVariable = {};
while (my @rows2 = $sth->fetchrow_array() ) {
$reportVariable{$row2[0]} = $row2[1];
}

$dbconn->disconnect();
exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "Reptar500#" );
	unless ( defined $dbods ) { sendErr(); }
	return $dbods;
}

