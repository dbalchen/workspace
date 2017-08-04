#! /usr/local/bin/perl

use DBI;

#Test parameters remove when going to production.
#$ARGV[0] =
"/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DIRI/SDIRI_FCIBER_ID001887_T20170707192108.DAT";

#$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon2/';


# For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";
# fire off DCH Job

my $hh =
"cat $ARGV[0] | grep '^22' | sort -u | cut -b 72-81,225-230,336-341 | $ENV{'REC_HOME'}/addMultiUp.pl";
my $ttemp = "";
$ttemp = `$hh`;
chomp($ttemp);
my ( $total, $filesum, $usage ) = split( "\t", $ttemp );

$hh =
"cat $ARGV[0] | grep '^52' | sort -u | cut -b 72-81 | $ENV{'REC_HOME'}/addMultiUp.pl";
$ttemp = "";
$ttemp = `$hh`;
chomp($ttemp);
my ( $ttot, $tsum ) = split( "\t", $ttemp );

$total   = $total + $ttot;
$filesum = $filesum + $tsum;

my $filename = ( split( '/', $ARGV[0] ) )[-1];

my $dateTime = substr( $filename, index( $filename, "T2" ) + 1, 8 );

my $dbconn = getBODSPRD();

#my $dbconnb = getSNDPRD();
my $dbconnb = $dbconn;

my $sql  = "delete from file_summary where FILE_NAME = '$filename'";
my $sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql  = "delete from rejected_records where FILE_NAME = '$filename'";
$sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

$sql =
  "select file_name, identifier from ac1_control_hist where file_name like ?";

my $sth = $dbconn->prepare($sql);

$sth->bind_param( 1, $filename );
$sth->execute() or sendErr();

my @fileId = $sth->fetchrow_array();

if ( $fileId[1] eq "" ) {
	my $reportFile = $filename . '.rpt.csv';
	open( RPT, ">$reportFile" )
	  || errorExit("Could not open log file.... Recon Failed!!!!");
	print RPT $filename . "--" . "File still processing\n";
	close(RPT);
	$dbconnb->disconnect();
	$dbconn->disconnect();
	exit(0);
}

$hh = "$ENV{'REC_HOME'}/cdmaDCHcounter.pl $ARGV[0] > /dev/null 2>&1 &";
system($hh);


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
select 'Rejected', sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'File2E' 
     and cur_file_alias = 'Diameter' 
     and nxt_pgm_name = 'NONE' 
     and nxt_file_alias = 'REJECT'
union
select 'DupTC',sum(wr_rec_quantity) 
    from ac1_control_hist 
    where phy_file_ident = $fileId[1]
     and cur_pgm_name = 'File2E' 
     and cur_file_alias = 'Diameter' 
     and nxt_pgm_name = 'NONE' 
     and nxt_file_alias = 'DUPLICATE'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my %reportVariable = {};
while ( my @rows2 = $sth->fetchrow_array() ) {

	$rows2[1] =~ s/\s+//g;

	if ( length( $rows2[1] ) == 0 ) {
		$rows2[1] = 0;
	}
	$reportVariable{ $rows2[0] } = $rows2[1];
}

if ( $reportVariable{'IN_REC_QUANTITY'} == 0 ) {
	$dbconn->disconnect();
	exit(0);
}

$sql =
"select /*+ PARALLEL(t1,12) */ 'APRM_SUCCESS', count(*), cast(sum(TOTAL_CHRG_AMOUNT) as decimal (18,2))
         from usc_roam_evnts t1
          where prod_id = 2 and event_id <> 2
         and 
         ciber_file_name_1|| ciber_file_name_2  = '$fileId[0]'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my @aprm = $sth->fetchrow_array();

$sql =
  "select l9_channel, error_id, error_desc, max(l9_original_air_time_chg_amt)  
         from ape1_rejected_event 
         where original_event_id in (select unique(original_event_id) 
        from ape1_rejected_event 
         where physical_source = $fileId[1]) 
        group by  original_event_id, l9_channel, error_id, error_desc";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my $rejectSum = 0;

while ( my @rows3 = $sth->fetchrow_array() ) {
	$rejectSum = $rejectSum + $rows3[3];

	$rows3[2] = ( split( '<', $rows3[2] ) )[0];

	$sql = "
INSERT INTO REJECTED_RECORDS (
   TOTAL_CHARGE, FILE_NAME, ERROR_TYPE, 
   ERROR_DESCRIPTION, ERROR_CODE) 
    VALUES ( 
     $rows3[3],
    '$rows3[0]',
    'REJECTED',
    '$rows3[2]',
     '$rows3[1]'
 )";

	$sthb = $dbconnb->prepare($sql);
	$sthb->execute() or sendErr();
}

$sql =
"select dominant_err_cd, file_tp, usage_chrg_1 from prm_dat_err_mngr_ap where prod_id = 2 and event_id = 2 and adu like '"
  . '%'
  . $fileId[0] . '%' . "'";

$sth = $dbconn->prepare($sql);
$sth->execute() or sendErr();

my $aprmdiff = 0;
my $dropSum  = 0;

while ( my @rows4 = $sth->fetchrow_array() ) {
	$dropSum  = $dropSum + $rows4[2];
	$aprmdiff = $aprmdiff + 1;

	$sql = "
INSERT INTO REJECTED_RECORDS (
   TOTAL_CHARGE, FILE_NAME, ERROR_TYPE, 
   ERROR_DESCRIPTION, ERROR_CODE) 
    VALUES ( 
     $rows4[2],
    '$fileId[0]',
    'DROP',
    '$rows4[1]',
     '$rows4[0]'
 )";

	$sthb = $dbconnb->prepare($sql);
	$sthb->execute() or sendErr();
}

my $tcaprDif =
  ( $reportVariable{'SenttoTC'} -
	  ( $reportVariable{'Rejected'} + $reportVariable{'DupTC'} + $aprmdiff ) )
  - $aprm[1];

# DCH Variables
$hh =
"$ENV{'REC_HOME'}/dch_infoCount.pl $ARGV[0] $ENV{'REC_HOME'}/IncollectDCH_voice.csv";
my @dchValues = `$hh`;
chomp(@dchValues);
my $usage_dch      = $dchValues[2] / 60;
my $total_recs_dch = $reportVariable{'IN_REC_QUANTITY'};
my $file_sum_dch   = $dchValues[1];
my $file_name_dch  = $fileId[0];
my $dch_rec_dif    = ( $total_recs_dch - $reportVariable{'IN_REC_QUANTITY'} );
my $dch_sum_dif    = ( $file_sum_dch - $filesum );

$sql =
"INSERT INTO FILE_SUMMARY (USAGE_TYPE, TOTAL_VOLUME_DCH, TOTAL_VOLUME, TOTAL_RECORDS_DCH, TOTAL_RECORDS, TOTAL_CHARGES_DCH, 
   TOTAL_CHARGES, TC_SEND, SENDER, REJECTED_COUNT, REJECTED_CHARGES, RECEIVER, PROCESS_DATE, IDENTIFIER, FILE_TYPE, FILE_NAME_DCH, FILE_NAME, DUPLICATES, 
   DROPPED_TC, DROPPED_RECORDS, DROPPED_APRM_CHARGES, DROPPED_APRM, APRM_TOTAL_RECORDS, APRM_TOTAL_CHARGES, APRM_DIFFERENCE) 
VALUES ( 
 'SDIRI_FCIBER',
 $usage_dch,
 $usage,
 $total_recs_dch,
 $reportVariable{'IN_REC_QUANTITY'},
 $file_sum_dch,
 $filesum,
 $reportVariable{'SenttoTC'},
 'Syniverse',
 $reportVariable{'Rejected'},
 $rejectSum,
 'USCC',
 to_date($dateTime,'YYYYMMDD'),
 $fileId[1],
 'CIBER',
 '$file_name_dch',
 '$fileId[0]',
 $reportVariable{'Duplicates'},
 $reportVariable{'DupTC'},
 $reportVariable{'Dropped'},
 $dropSum,
 $aprmdiff,
 $aprm[1],
 $aprm[2],
 $tcaprDif
)";

#print $sql."\n";

$sthb = $dbconnb->prepare($sql);
$sthb->execute() or sendErr();

#
$dbconn->disconnect();
$dbconnb->disconnect();

exit(0);

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "Reptar5000#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getSNDPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "Reptar5000#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}
