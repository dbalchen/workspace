#! /usr/local/bin/perl

use DBI;

BEGIN {
	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
#	push( @INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5' );
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

# For test only....
 my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
 my $ORACLE_SID  = "bodsprd";
 $ENV{ORACLE_HOME} = $ORACLE_HOME;
 $ENV{ORACLE_SID}  = $ORACLE_SID;
 $ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

#Test parameters remove when going to production.
#$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER,DATA_CIBER,LTE,NLDLT,DISP_RM";
#$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER";
#$ARGV[0] = "SDIRI_FCIBER";
#$ARGV[0] = "SDATACBR_FDATACBR";
#$ARGV[0] = "CIBER_CIBER";
#$ARGV[0] = "DATA_CIBER";
#$ARGV[0] = "DISP_RM,NLDLT";
#$ARGV[0] = "DISP_RM";
#$ARGV[0] = "LTE";
#$ARGV[0] = "NLDLT";
#$ARGV[0] = "NLDLT,CIBER_CIBER";

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon2/';

# Setup Initial variables
my $max_process = 10;
my $timeStamp   = $ARGV[1];

#$timeStamp = '20180119';

# Setup switch types and their directory location
my %dirs     = {};
my %jobs     = {};
my %headings = {};
my %tab      = {};
my %sqls     = {};
my %aprmsql  = {};

$dirs{'SDIRI_FCIBER'} =
  '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DIRI';
$dirs{'SDATACBR_FDATACBR'} =
  '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DATACBR';
$dirs{'CIBER_CIBER'} =
  '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output';
$dirs{'DISP_RM'} = '/inf_nas/apm1/prod/aprmoper/var/usc/DISP';

$jobs{'SDIRI_FCIBER'}      = 'getFileInfo.pl';
$jobs{'SDATACBR_FDATACBR'} = 'getFileInfoData.pl';
$jobs{'CIBER_CIBER'}       = 'getFileInfoOutcollects.pl';
$jobs{'DATA_CIBER'}        = 'getFileInfoOutcollectsData.pl';
$jobs{'LTE'}               = 'getFileInfoLTE.pl';
$jobs{'DISP_RM'}           = 'getFileInfoLTEOut.pl';
$jobs{'NLDLT'}             = 'getFileInfoLTE.pl';

$headings{'SDIRI_FCIBER'} = [
	'File Name',
	'Identifier',
	'Total Records',
	'Total Minutes',
	'Total Charges ($)',
	'Dropped Records',
	'Duplicate Records',
	'Records Sent To TC',
	'Records Dropped to TC',
	'Rejected Records',
	'Rejected Total($)',
	'Dropped APRM Records ',
	'Dropped APRM Charges ($)',
	'TC to APRM Record Difference',
	'APRM Records',
	'APRM Total Charges ($)',
	'DCH Total Records',
	'DCH Total Minutes',
	'DCH Total Charges ($)',
	'Record Count Variance Usage File vs. DCH',
	'Total Charge Variance Usage File vs. DCH ($)'
];

$headings{'SDATACBR_FDATACBR'} = [
	'File Name',
	'Identifier',
	'Total Records',
	'Total Bytes',
	'Total KB',
	'Total MB',
	'Total Charges ($)',
	'Dropped Records',
	'Duplicate Records',
	'Records sent to TC',
	'Records Dropped to TC',
	'Rejected Records',
	'Rejected Total ($)',
	'Dropped APRM Records',
	'Dropped APRM Charges ($)',
	'TC to APRM Record Difference',
	'APRM Records',
	'APRM Total Charges ($)',
	'DCH Total Records',
	'DCH Total Bytes',
	'DCH Total KB',
	'DCH Total MB',
	'DCH Total Charges ($)',
	'Record Count Variance Usage File vs. DCH',
	'Total Charge Variance Usage File vs. DCH ($)'
];

$headings{'CIBER_CIBER'} = [
	'File Name',
	'Identifier',
	'Total Records',
	'Total Minutes',
	'Total Charges ($)',
	'Total Record Difference (APRM vs. Usage File)',
	'APRM Records',
	'APRM Total Charges ($)',
	'DCH Total Records',
	' DCH Total Minutes',
	'DCH Total Charges ($)',
	'Record Count Variance Usage File vs. DCH',
	' Total Charge Variance Usage File vs. DCH ($)'
];
$headings{'DATA_CIBER'} = [
	'Clearinghouse',
	'Total Records',
	'Revenue ($)',
	'Data Volume',
	'USCC - Total Records',
	'USCC - Data Volume',
	'Variance of Total Records',
	'Variance of Data Volume',
	'% Data Volume Variance'
];

$headings{'LTE'} = [
	'Converted File Name',
	'File Name',
	'Identifier',
	'Usage Type',
	'Sender',
	'Total Records',
	'Total Bytes',
	'Total KB',
	'Total MB',
	'Total Charges ($)',
	'Rejected Records',
	'Rejected Charges ($)',
	'ARCM to APRM Record Difference',
	'Dropped APRM Records',
	'Dropped APRM Total Charges ($)',
	'APRM Records',
	'APRM Charges ($)',
	'DCH Total Records',
	'DCH Total Bytes',
	'DCH Total KB',
	'DCH Total MB',
	'DCH Total Charges ($)',
	'Record Count Variance Usage File vs. DCH',
	'Total Charge Variance Usage File vs. DCH ($)'
];

$headings{'DISP_RM'} = [
	'File Name',
	'Total Outcollect Records',
	'Total Charges ($)',
	'APRM Records',
	'APRM Total Bytes',
	'DCH Records',
	'DCH Total Charges ($)',
	'Record Count Variance Usage File vs. DCH',
	'Total Charge Variance Usage File vs. DCH ($)'
];

$headings{'NLDLT'} = [
	'Converted File Name',
	'File Name',
	'Identifier',
	'Usage Type',
	'Sender',
	'Total Records',
	'Total Charges ($)',
	'Total Usage',
	'Rejected Records',
	'Rejected Charges ($)',
	'Dropped APRM Records',
	'Dropped APRM Total Charges ($)',
	'APRM Records',
	'APRM Charges ($)',
	'DCH Total Records',
	'DCH Total Volume',
	'DCH Total Charges ($)',
	'Record Count Variance Usage File vs. DCH',
	'Total Charge Variance Usage File vs. DCH ($)'
];

$tab{'SDIRI_FCIBER'}      = "CDMA Voice Incollect";
$tab{'SDATACBR_FDATACBR'} = "CDMA Data Incollect";
$tab{'CIBER_CIBER'}       = 'CDMA Voice Outcollect';
$tab{'DATA_CIBER'}        = 'Data Outcollect';
$tab{'LTE'}               = 'LTE Incollect';
$tab{'DISP_RM'}           = 'LTE Outcollect';
$tab{'NLDLT'}             = 'GSM (Incollect)';

$sqls{'SDIRI_FCIBER'} =
"select ". 
" file_name, identifier, Total_Records, total_volume, total_charges, dropped_records, duplicates, TC_SEND, dropped_tc, rejected_count, 
rejected_charges, dropped_aprm,dropped_aprm_charges, aprm_difference, aprm_total_records, aprm_total_charges,
total_records_dch, total_volume_dch, total_charges_dch, (Total_Records - total_records_dch), (total_charges - total_charges_dch)
 from file_summary where usage_type = 'SDIRI_FCIBER' and process_date = to_date($timeStamp,'YYYYMMDD')";

$sqls{'SDATACBR_FDATACBR'} =
"select ".
 " FILE_NAME,IDENTIFIER, TOTAL_RECORDS,TOTAL_VOLUME, ceil(TOTAL_VOLUME/1024),
 ceil((TOTAL_VOLUME/1024)/1024),TOTAL_CHARGES,DROPPED_RECORDS, DUPLICATES,TC_SEND,
DROPPED_TC,REJECTED_COUNT, REJECTED_CHARGES, DROPPED_APRM, DROPPED_APRM_CHARGES, APRM_DIFFERENCE, APRM_TOTAL_RECORDS,
APRM_TOTAL_CHARGES, TOTAL_RECORDS_DCH, TOTAL_VOLUME_DCH,ceil(TOTAL_VOLUME_DCH/1024), ceil((TOTAL_VOLUME_DCH/1024)/1024), 
TOTAL_CHARGES_DCH, (TOTAL_RECORDS-TOTAL_RECORDS_DCH), (TOTAL_CHARGES-TOTAL_CHARGES_DCH)  
from file_summary where usage_type = 'SDATACBR_FDATACBR' and process_date = to_date($timeStamp,'YYYYMMDD')";

$sqls{'CIBER_CIBER'} =
"select ". 
" FILE_NAME, IDENTIFIER, TOTAL_RECORDS, TOTAL_VOLUME, TOTAL_CHARGES, APRM_DIFFERENCE, 
APRM_TOTAL_RECORDS, APRM_TOTAL_CHARGES, TOTAL_RECORDS_DCH,
TOTAL_VOLUME_DCH, TOTAL_CHARGES_DCH, (TOTAL_RECORDS - TOTAL_RECORDS_DCH), (TOTAL_CHARGES - TOTAL_CHARGES_DCH)
 from file_summary where usage_type = 'CIBER_CIBER' and process_date = to_date($timeStamp,'YYYYMMDD')";

$sqls{'DATA_CIBER'} =
"select  RECEIVER, TOTAL_RECORDS, TOTAL_CHARGES, TOTAL_VOLUME, TOTAL_RECORDS_DCH, TOTAL_VOLUME_DCH, (TOTAL_RECORDS-TOTAL_RECORDS_DCH), 
(TOTAL_VOLUME-TOTAL_VOLUME_DCH),( (TOTAL_VOLUME-TOTAL_VOLUME_DCH)/TOTAL_VOLUME)  from file_summary where usage_type = 'DATA_CIBER' and process_date = to_date($timeStamp,'YYYYMMDD')";

$sqls{'LTE'} =
"select FILE_NAME_DCH, FILE_NAME, IDENTIFIER, USAGE_TYPE, SENDER, (TOTAL_RECORDS + REJECTED_COUNT),
TOTAL_VOLUME,ceil(TOTAL_VOLUME/1040),ceil((TOTAL_VOLUME/1040)/1040),  TOTAL_CHARGES, REJECTED_COUNT, 
REJECTED_CHARGES, (TOTAL_RECORDS-APRM_TOTAL_RECORDS), DROPPED_APRM, DROPPED_APRM_CHARGES,APRM_TOTAL_RECORDS,
APRM_TOTAL_CHARGES, TOTAL_RECORDS_DCH,TOTAL_VOLUME_DCH, ceil(TOTAL_VOLUME_DCH/1040),ceil((TOTAL_VOLUME_DCH/1040)/1040),
TOTAL_CHARGES_DCH, ((TOTAL_RECORDS + REJECTED_COUNT)-TOTAL_RECORDS_DCH), ((TOTAL_CHARGES + REJECTED_CHARGES) - TOTAL_CHARGES_DCH)  
from file_summary where usage_type like 'LTE%' and process_date = to_date($timeStamp,'YYYYMMDD')";


$sqls{'NLDLT'} =
"select FILE_NAME_DCH, FILE_NAME, IDENTIFIER, USAGE_TYPE, SENDER, TOTAL_RECORDS, APRM_TOTAL_CHARGES, TOTAL_VOLUME,REJECTED_COUNT, REJECTED_CHARGES, DROPPED_APRM, DROPPED_APRM_CHARGES,
APRM_TOTAL_RECORDS, APRM_TOTAL_CHARGES, TOTAL_RECORDS_DCH, TOTAL_VOLUME_DCH, TOTAL_CHARGES_DCH, (TOTAL_RECORDS - TOTAL_RECORDS_DCH), (TOTAL_CHARGES - TOTAL_CHARGES_DCH)
 from file_summary where usage_type like 'NLDLT%' and process_date = to_date($timeStamp,'YYYYMMDD')";


$sqls{'DISP_RM'} =
"select  file_name,  total_records, total_charges, APRM_TOTAL_RECORDS,total_volume, TOTAL_RECORDS_DCH,TOTAL_CHARGES_DCH, 
    TOTAL_RECORDS-TOTAL_RECORDS_DCH, TOTAL_CHARGES-TOTAL_CHARGES_DCH
 from file_summary where usage_type = 'DISP_RM' and file_type = 'TAP'  and process_date = to_date($timeStamp,'YYYYMMDD') ";

# Get Roaming switches to check
my @switches = split( ',', $ARGV[0] );

my $excel_file = "RORC_" . $timeStamp . '.xls';
$workbook = Spreadsheet::WriteExcel->new($excel_file);

#$dbconnb = getSNDPRD();
$dbconnb = getBODSPRD();

# Get Roaming files
foreach my $switch (@switches) {
	my $hh      = "";
	my $maxRecs = 1;
	

	if ( $maxRecs > 0 || $switch eq "DATA_CIBER" ) {
		createExcel( $sqls{$switch}, $headings{$switch}, $tab{$switch},
			$switch );

		if (   ( $switch ne "CIBER_CIBER" )
			&& ( $switch ne "DATA_CIBER" )
			&& ( $switch ne "DISP_RM" ) )
		{
			my $heading = [
				'File Name',
				'Error Code',
				'Error Type',
				'Error Description',
				'Data Charge'
			];
			my $sql =
"select t1.* from rejected_records t1, file_summary t2 where t1.file_name = t2.file_name and usage_type like '$switch%'  and process_date = to_date($timeStamp,'YYYYMMDD')";

			my $rejectTab = "Rejected " . $tab{$switch};
			createExcel( $sql, $heading, $rejectTab, $switch );
		}

		# Work Here
		if ( $switch eq "DISP_RM" || $switch eq "LTE" ) {
			my $sql =
"select CARRIER_CODE, BP_START_DATE, USAGE_TYPE, RECORD_COUNT, TOTAL_CHARGES, TOTAL_VOLUME from aprm  where usage_type like '$switch%' and date_processed = to_date($timeStamp,'YYYYMMDD')";

			$heading = [
				'Carrier Code',
				'BP Start Date',
				'Usage Type',
				'Record Count',
				'APRM Charges ($)',
				'Data Volume (Bytes) '
			];
			$rejectTab = $tab{$switch} . " APRM";
			createExcel( $sql, $heading, $rejectTab, $switch );

		}
		elsif ( $switch eq "NLDLT" ) {
			my $sql =
"select CARRIER_CODE, BP_START_DATE, USAGE_TYPE, RECORD_COUNT, TOTAL_CHARGES, TOTAL_VOLUME from aprm  where usage_type like '$switch%' and date_processed = to_date($timeStamp,'YYYYMMDD')";

			$heading = [
				'Carrier Code',
				'BP Start Date',
				'Usage Type',
				'Record Count',
				'APRM Charges ($)',
				'Data Volume'
			];
			$rejectTab = $tab{$switch} . " APRM";
			createExcel( $sql, $heading, $rejectTab, $switch );

		}
		elsif ( $switch eq "DATA_CIBER" ) {

			my $sql =
"select CARRIER_CODE, BP_START_DATE, CLEARINGHOUSE, TOTAL_CHARGES, TOTAL_VOLUME,CEIL(TOTAL_VOLUME/1024), CEIL((TOTAL_VOLUME/1024)/1024)  from APRM where usage_type = 'DATA_CIBER' and date_processed = to_date($timeStamp,'YYYYMMDD')";

			$heading = [
				'Carrier',
				'BP Date',
				'Clearinghouse',
				'Revenue ($)',
				'Total Bytes',
				'Total KB',
				'Total MB'
			];
			$rejectTab = $tab{$switch} . " by Carrier";
			createExcel( $sql, $heading, $rejectTab, $switch );

		}
		elsif ( $switch eq 'SDATACBR_FDATACBR' ) {
			my $sql =
"select CARRIER_CODE,BP_START_DATE, sum(RECORD_COUNT),sum(TOTAL_VOLUME), sum(ceil(TOTAL_VOLUME/1024)),
                 sum(ceil((TOTAL_VOLUME/1024)/1024)),sum(TOTAL_CHARGES)".
  "       from aprm where usage_type = '$switch' and date_processed = to_date($timeStamp,'YYYYMMDD') group by  CARRIER_CODE,BP_START_DATE order by CARRIER_CODE";

			$heading = [
				'Company Code',
				'BP Start Date',
				'Record Count',
				'Total Bytes',
				'Total KB',
				'Total MB',
				'Total Charges ($)'
			];
			$rejectTab = $tab{$switch} . " APRM";
			createExcel( $sql, $heading, $rejectTab, $switch );
		}
		elsif ( $switch eq 'CIBER_CIBER' ) {

			my $sql =
"select CARRIER_CODE,MARKET_CODE, BP_START_DATE, sum(RECORD_COUNT), sum(ceil(TOTAL_VOLUME/60)),sum(TOTAL_CHARGES)".
" from aprm where usage_type = '$switch' and date_processed = to_date($timeStamp,'YYYYMMDD') group by  CARRIER_CODE,MARKET_CODE, BP_START_DATE order by CARRIER_CODE";

			$heading = [
				'Carrier Code',
				'Market Code',
				'BP Start Date',
				'Record Count',
				'Total Minutes',
				'Total Charges ($)'
			];
			$rejectTab = $tab{$switch} . " APRM";
			createExcel( $sql, $heading, $rejectTab, $switch );
		}
		else {
			my $sql =
"select CARRIER_CODE,BP_START_DATE, sum(RECORD_COUNT), sum(ceil(TOTAL_VOLUME/60)),sum(TOTAL_CHARGES)".
     "  from aprm where usage_type = '$switch' and date_processed = to_date($timeStamp,'YYYYMMDD') group by  CARRIER_CODE,BP_START_DATE order by CARRIER_CODE";

			$heading = [
				'Company Code',
				'BP Start Date',
				'Record Count',
				'Total Minutes',
				'Total Charges ($)'
			];
			$rejectTab = $tab{$switch} . " APRM";
			createExcel( $sql, $heading, $rejectTab, $switch );
		}
	}
}

$workbook->close;

#my @email = ('ISBillingOperations@uscellular.com','Joan.Mulvany@uscellular.com','Syed.Sikander@uscellular.com','david.balchen@uscellular.com','Jody.Skeen@uscellular.com','Liz.Pierce@uscellular.com');
my @email = ('david.balchen@uscellular.com');

foreach my $too (@email) {
#	 sendMsg($too);
}

exit(0);

sub createExcel {
	my ( $sql, $headings, $sheetname, $switch ) = @_;

	my $worksheet = $workbook->add_worksheet($sheetname);
	my $bold = $workbook->add_format( bold => 1 );
	$worksheet->write( 'A1', $headings, $bold );

	$sthb = $dbconnb->prepare($sql);
	$sthb->execute() or sendErr();

	my $cntrow = 1;
	while ( my @rows = $sthb->fetchrow_array() ) {

		my @fix_cols = grep( s/\s*$//g, @rows );
		$worksheet->write_row( $cntrow, 0, \@fix_cols );
		$cntrow++;
	}

}

sub getTotalProc {

	my $shh        = "ps aux | grep getFileInfo | grep -v 'grep' | wc -l";
	my $total_proc = `$shh`;
	chomp $total_proc;
	return $total_proc;
}

sub sendMsg() {

	my ($to)      = @_;
	my $mime_type = 'multipart/mixed';
	my $from      = "david.balchen\@uscellular.com";
	my $subject   = "Roaming Reconciliation Report for $timeStamp";
	my $message   = "You'll find the report attached to this email";
	my $cc = '';

	my $msg = MIME::Lite->new(
		From    => $from,
		To      => $to,
		Cc      => $cc,
		Subject => $subject,
		Type    => $mime_type
	) or die "Error creating " . "MIME body: $!\n";

	$msg->attach(
		Type => 'TEXT',
		Data => $message
	) or die "Error adding text message: $!\n";

	$msg->attach(
		Type     => 'application/octet-stream',
		Encoding => 'base64',
		Path     => $ENV{'REC_HOME'} . $excel_file,
		Filename => $excel_file
	) or die "Error attaching file: $!\n";

	$msg->send();
}

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "#5000Reptar" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getSNDPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "#5000Reptar" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

