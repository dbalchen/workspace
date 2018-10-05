#! /usr/local/bin/perl
#exit(0);

use DBI;
use Time::Piece;
use Time::Seconds;

BEGIN {
	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
	push( @INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5' );
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

# For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

#Test parameters remove when going to production.
#$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER,DATA_CIBER,LTE,NLDLT,DISP_RM";
#$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER";
#$ARGV[0] = "SDIRI_FCIBER";
#$ARGV[0] = "SDATACBR_FDATACBR";
#$ARGV[0] = "CIBER_CIBER";
#$ARGV[0] = "DATA_CIBER";
#$ARGV[0] = "LTE,DISP_RM";
#$ARGV[0] = "DISP_RM";
#$ARGV[0] = "LTE";
#$ARGV[0] = "DATA_CIBER,CIBER_CIBER";
#$ARGV[0] = "NLDLT";
#$ARGV[0] = "NLDLT,CIBER_CIBER";

#$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
$ENV{'REC_HOME'} = '/apps/ebi/ebiap1/bin/roamRecon/';

# Setup Initial variables
my $max_process = 10;
my $timeStamp   = $ARGV[1];

#$timeStamp = '20180414';
my $outTimeStamp = Time::Piece->strptime( "$timeStamp", "%Y%m%d" );
$outTimeStamp = $outTimeStamp - ONE_DAY;
$outTimeStamp =
    ( $outTimeStamp->year )
  . pad( $outTimeStamp->mon,  '0', 2 )
  . pad( $outTimeStamp->mday, '0', 2 );

my $hh = "$ENV{'REC_HOME'}/dchList.pl $timeStamp";

system("$hh");

# Setup switch types and their directory location
my %dirs     = {};
my %jobs     = {};
my %headings = {};
my %tab      = {};
my %sqls     = {};
my %aprmsql  = {};

$msg = "";

$dirs{'SDIRI_FCIBER'} =
  '/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/DIRI';
$dirs{'SDATACBR_FDATACBR'} =
  '/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/DATACBR';
$dirs{'CIBER_CIBER'} =
  '/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/apr/interfaces/output';
$dirs{'DISP_RM'} = '/pkgbl03/inf/prdsys/operaprm/var/usc/LSN/input2';

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
	'Total Records DCH',
	'Total Volume DCH (min)',
	'Total Charges DCH ($)',
	'Total Records',
	'Total Volume (min)',
	'Total Charges ($)',
	'Record Count Variance DCH vs. Usage File',
	'Total Volume Variance DCH vs. Usage File (min)',
	'Total Charge Variance DCH vs. Usage File ($)',
	'Dropped Records',
	'Duplicate Records',
	'Records sent to TC',
	'Rejected Record Count',
	'Total Rejected Charges ($)',
	'Dropped TC Records',
	'Dropped APRM Records',
	'Dropped APRM Charges ($)',
	'APRM Duplicates',
	'APRM Total Records',
	'APRM Total Charges ($)',
	'Record Count Variance TC Send vs. APRM',
	'Charge Variance TC Send vs. APRM ($)'
];

$headings{'SDATACBR_FDATACBR'} = [
	'File Name',
	'Identifier',
	'Total Records DCH',
	'Total Bytes DCH',
	'Total KB DCH',
	'Total MB DCH',
	'Total Charges DCH ($)',
	'Total Records',
	'Total Bytes',
	'Total KB',
	'Total MB',
	'Total Charges ($)',
	'Record Count Variance DCH vs. Usage File',
	'Total Volume Variance DCH vs. Usage File (bytes)',
	'Total Charge Variance DCH vs. Usage File ($)',
	'Dropped Records',
	'Duplicate Records',
	'Records sent to TC',
	'Dropped TC Records',
	'Rejected Record Count',
	'Total Rejected Charges ($)',
	'Dropped APRM Records',
	'Dropped APRM Charges ($)',
	'APRM Duplicates',
	'APRM Total Records',
	'APRM Total Charges ($)',
	'Record Count Variance TC Send vs. APRM',
	'Charge Variance TC Send vs. APRM ($)'
];

$headings{'CIBER_CIBER'} = [
	'File Name',
	'Identifier',
	'APRM Total Records',
	'APRM Total Charges ($)',
	'Total Records',
	'Total Volume (min)',
	'Total Charges ($)',
	'Total Record Difference (APRM vs. Usage File)',
	'Total Volume Difference (APRM vs. Usage File)',
	'Total Records DCH',
	'Total Volume DCH (min)',
	'Total Charges DCH ($)',
	'Record Count Variance Usage File vs. DCH',
	'Total Volume Variance Usage File vs. DCH ($)',
	'Total Charge Variance Usage File vs. DCH ($)'
];
$headings{'DATA_CIBER'} = [
	'Clearinghouse',
	'APRM Total Records',
	'APRM Total Charges ($)',
	'Total Records',
	'Total Volume (bytes)',
	'Total Charges ($)',
	'Total Record Difference (APRM vs. Usage File)',
	'Total Charges Difference (APRM vs. Usage File)',
	'Total Records DCH',
	'Total Volume DCH (bytes)',
	'Total Charges DCH ($)',
	'Record Count Variance Usage File vs. DCH',
	'Total Volume Variance Usage File vs. DCH ($)',
	'Total Charge Variance Usage File vs. DCH ($)'
];

$headings{'LTE'} = [
	'File Name',
	'Identifier',
	'Sender',
	'Total Records DCH',
	'Total Bytes DCH',
	'Total KB DCH',
	'Total MB DCH',
	'Total Charges DCH ($)',
	'Total Records',
	'Total Bytes',
	'Total KB',
	'Total MB',
	'Total Charges ($)',
	'Record Count Variance DCH vs. Usage File',
	'Total Volume Variance DCH vs. Usage File (bytes)',
	'Total Charge Variance DCH vs. Usage File ($)',
	'Rejected Record Count',
	'Total Rejected Charges ($)',
	'Dropped APRM Records',
	'Dropped APRM Charges ($)',
	'APRM Total Records',
	'APRM Total Charges ($)',
	'Record Count Variance TC Send vs. APRM',
	'Charge Variance TC Send vs. APRM ($)',
	'Total Data Records',
	'Total Data Volume Bytes',
	'Total Data Charges',
	'Total VoLTE Records',
	'Total VoLTE Volume Bytes',
	'Total VoLTE Charges'
];

$headings{'DISP_RM'} = [
	'File Name',
	'Total Data Records',
	'Total Data Volume Bytes',
	'Total Data Charges',
	'Total VoLTE Records',
	'Total VoLTE Volume Bytes',
	'Total VoLTE Charges',
	'Total Records',
	'Total Bytes',
	'Total Charges ($)',
	'Total Records DCH',
	'Total Bytes DCH',
	'Total Charges DCH ($)',
	'Record Count Variance Usage File vs. DCH',
	'Total Volume Variance Usage File vs. DCH (bytes)',
	'Total Charge Variance Usage File vs. DCH ($)'
];

$headings{'NLDLT'} = [
	'File Name',
	'Identifier',
	'Sender',
	'Usage Type',
	'Total Records DCH',
	'Total Volume DCH',
	'Total Charges DCH ($)',
	'Total Records',
	'Total Volume',
	'Total Charges ($)',
	'Record Count Variance DCH vs. Usage File',
	'Total Volume Variance DCH vs. Usage File',
	'Total Charge Variance DCH vs. Usage File ($)',
	'Rejected Records',
	'Rejected Charges ($)',
	'Dropped APRM Records',
	'Dropped APRM Total Charges ($)',
	'APRM Total Records',
	'APRM Total Charges ($)',
	'Record Count Variance Usage File vs. APRM',
	'Charge Variance Usage File vs. APRM ($)'
];

$tab{'SDIRI_FCIBER'}      = "CDMA Voice Incollect";
$tab{'SDATACBR_FDATACBR'} = "CDMA Data Incollect";
$tab{'CIBER_CIBER'}       = 'CDMA Voice Outcollect';
$tab{'DATA_CIBER'}        = 'Data Outcollect';
$tab{'LTE'}               = 'LTE Incollect';
$tab{'DISP_RM'}           = 'LTE Outcollect';
$tab{'NLDLT'}             = 'GSM (Incollect)';

$sqls{'SDIRI_FCIBER'} = "select 
 file_name, identifier, 
 total_records_dch, total_volume_dch, total_charges_dch,
 Total_Records, total_volume, total_charges, 
 (Total_Records - total_records_dch), (total_volume - total_volume_dch ), (total_charges - total_charges_dch),
	dropped_records, duplicates, 
	TC_SEND, rejected_count, rejected_charges, 
	dropped_tc,  dropped_aprm, dropped_aprm_charges, aprm_difference, aprm_total_records, aprm_total_charges,
	tc_send - aprm_total_records , (total_charges - aprm_total_charges),
		abs((total_records_dch - Total_Records)/total_records)*100,
	abs((total_volume_dch - Total_volume)/total_volume)*100,
	abs((total_charges_dch - Total_charges)/total_charges)*100,
	abs((TC_SEND - aprm_total_records)/TC_SEND) * 100,
	abs((total_charges_dch - aprm_total_charges)/aprm_total_charges)*100
from file_summary where usage_type = 'SDIRI_FCIBER' and process_date = to_date($timeStamp,'YYYYMMDD')";

$sqls{'SDATACBR_FDATACBR'} =
"select FILE_NAME,IDENTIFIER, TOTAL_RECORDS_DCH, TOTAL_VOLUME_DCH,ceil(TOTAL_VOLUME_DCH/1024), ceil((TOTAL_VOLUME_DCH/1024)/1024), 
TOTAL_CHARGES_DCH,TOTAL_RECORDS,TOTAL_VOLUME, ceil(TOTAL_VOLUME/1024), ceil((TOTAL_VOLUME/1024)/1024),TOTAL_CHARGES,
 (TOTAL_RECORDS-TOTAL_RECORDS_DCH),TOTAL_VOLUME - TOTAL_VOLUME_DCH, (TOTAL_CHARGES-TOTAL_CHARGES_DCH),
DROPPED_RECORDS, DUPLICATES,TC_SEND, DROPPED_TC,REJECTED_COUNT, REJECTED_CHARGES, 
DROPPED_APRM, DROPPED_APRM_CHARGES, APRM_DIFFERENCE, APRM_TOTAL_RECORDS, APRM_TOTAL_CHARGES,
TC_SEND - APRM_TOTAL_RECORDS, (TOTAL_CHARGES) - APRM_TOTAL_CHARGES,
	abs((total_records_dch - Total_Records)/total_records)*100 ,
	abs((total_volume_dch - Total_volume)/total_volume)*100 ,
	round(abs((total_charges_dch - Total_charges)/total_charges),2)*100 ,
	abs((TC_SEND - aprm_total_records)/TC_SEND) * 100,
	abs((total_charges_dch - aprm_total_charges)/aprm_total_charges) * 100
from file_summary where usage_type = 'SDATACBR_FDATACBR' and process_date = to_date($timeStamp,'YYYYMMDD')";

$sqls{'CIBER_CIBER'} =
  "select FILE_NAME, IDENTIFIER, APRM_TOTAL_RECORDS, APRM_TOTAL_CHARGES,
   TOTAL_RECORDS, TOTAL_VOLUME, TOTAL_CHARGES,APRM_DIFFERENCE,(APRM_TOTAL_CHARGES - TOTAL_CHARGES),
   TOTAL_RECORDS_DCH,
   TOTAL_VOLUME_DCH, TOTAL_CHARGES_DCH, (TOTAL_RECORDS - TOTAL_RECORDS_DCH), (TOTAL_VOLUME - TOTAL_VOLUME_DCH),(TOTAL_CHARGES - TOTAL_CHARGES_DCH),
	abs((total_records_dch - Total_Records)/total_records) * 100,
	abs((total_volume_dch - Total_volume)/total_volume) * 100,
	round(abs((total_charges_dch - Total_charges)/total_charges),2) * 100,
	abs((TOTAL_RECORDS - aprm_total_records)/TOTAL_RECORDS) * 100,
	abs((total_charges_dch - aprm_total_charges)/aprm_total_charges) * 100
 from file_summary where usage_type = 'CIBER_CIBER' and process_date = to_date($outTimeStamp,'YYYYMMDD')";

$sqls{'DATA_CIBER'} =
"select 
RECEIVER,
APRM_TOTAL_RECORDS,
APRM_TOTAL_CHARGES,
TOTAL_RECORDS,
TOTAL_VOLUME,
TOTAL_CHARGES,
(APRM_TOTAL_RECORDS - TOTAL_RECORDS),
(APRM_TOTAL_CHARGES - TOTAL_CHARGES),
Total_records_dch,
total_volume_dch,
total_charges_dch,
(TOTAL_RECORDS - Total_records_dch),
(TOTAL_VOLUME - total_volume_dch),
(TOTAL_CHARGES - total_charges_dch),
0,
0,
0,
0,
0
from file_summary where usage_type = 'DATA_CIBER' and process_date = to_date($outTimeStamp,'YYYYMMDD')";

$sqls{'LTE'} = "
select
FILE_NAME, 
t1.IDENTIFIER, 
t1.sender,
sum(TOTAL_RECORDS_DCH),
sum(TOTAL_VOLUME_DCH),
sum(ceil(TOTAL_VOLUME_DCH/1040)),
sum(ceil((TOTAL_VOLUME_DCH/1040)/1040)) ,
sum(TOTAL_CHARGES_DCH),
sum(TOTAL_RECORDS),
sum(TOTAL_VOLUME),
sum(ceil(TOTAL_VOLUME/1040)) ,
sum(ceil((TOTAL_VOLUME/1040)/1040)) ,
sum(TOTAL_CHARGES) ,
sum(TOTAL_RECORDS_DCH) - sum(TOTAL_RECORDS),
sum(TOTAL_VOLUME_DCH) - sum(TOTAL_VOLUME),
sum(TOTAL_CHARGES_DCH) - sum(TOTAL_CHARGES),
sum(REJECTED_COUNT), 
sum(REJECTED_CHARGES),
sum(DROPPED_APRM), 
sum(DROPPED_APRM_CHARGES),
sum(APRM_TOTAL_RECORDS),
sum(APRM_TOTAL_CHARGES),
sum(TOTAL_RECORDS) - sum(APRM_TOTAL_RECORDS),
sum(TOTAL_CHARGES) - sum(APRM_TOTAL_CHARGES),
(select nvl(sum(total_records),0) from file_summary t2 where usage_type like 'LTE-H' and t2.identifier = t1.identifier and process_date = to_date($timeStamp,'YYYYMMDD')) ,
(select nvl(sum(TOTAL_VOLUME),0)  from file_summary t2 where usage_type like 'LTE-H' and t2.identifier = t1.identifier and process_date = to_date($timeStamp,'YYYYMMDD')),
(select nvl(sum(TOTAL_CHARGES),0) from file_summary t2 where usage_type like 'LTE-H' and t2.identifier = t1.identifier and process_date = to_date($timeStamp,'YYYYMMDD')) ,
(select nvl(sum(total_records),0) from file_summary t2 where usage_type like 'LTE-L' and t2.identifier = t1.identifier and process_date = to_date($timeStamp,'YYYYMMDD')) ,
(select nvl(sum(TOTAL_VOLUME),0)  from file_summary t2 where usage_type 
like 'LTE-L' and t2.identifier = t1.identifier and process_date = to_date($timeStamp,'YYYYMMDD')) ,
(select nvl(sum(TOTAL_CHARGES),0) from file_summary t2 where usage_type like 'LTE-L' and t2.identifier = t1.identifier and process_date = to_date($timeStamp,'YYYYMMDD')),
	abs((sum(total_records_dch) - sum(Total_Records))/sum(total_records))*100,
	abs((sum(total_volume_dch) - sum(Total_volume))/sum(total_volume))*100,
	abs((sum(total_charges_dch) - sum(Total_charges))/sum(total_charges))*100,
	abs((sum(total_records) - sum(aprm_total_records))/sum(total_records))*100,
	abs((sum(total_charges_dch) - sum(aprm_total_charges))/sum(aprm_total_charges))	*100 
from file_summary t1 
  where t1.usage_type like 'LTE%' and t1.process_date = to_date($timeStamp,'YYYYMMDD')
group by FILE_NAME_DCH, FILE_NAME, t1.IDENTIFIER, SENDER";

$sqls{'NLDLT'} =
"select 
 FILE_NAME, 
 IDENTIFIER, 
 SENDER, 
 USAGE_TYPE, 
 TOTAL_RECORDS_DCH, 
 TOTAL_VOLUME_DCH,
 TOTAL_CHARGES_DCH,
 TOTAL_RECORDS,
 TOTAL_VOLUME,
 TOTAL_CHARGES,
 TOTAL_RECORDS_DCH - TOTAL_RECORDS,
 TOTAL_VOLUME_DCH - TOTAL_VOLUME,
 TOTAL_CHARGES_DCH - TOTAL_CHARGES,
 REJECTED_COUNT, 
 REJECTED_CHARGES,
 DROPPED_APRM, 
 DROPPED_APRM_CHARGES,
 APRM_TOTAL_RECORDS,
 APRM_TOTAL_CHARGES,
 TOTAL_RECORDS - APRM_TOTAL_RECORDS,
 TOTAL_CHARGES - APRM_TOTAL_CHARGES,
 0,
 0,
 0,
 0,
 0
from file_summary where usage_type like 'NLDLT%' and process_date = to_date($timeStamp,'YYYYMMDD')";

$sqls{'DISP_RM'} = "
select t1.file_name, 
t1.total_records + t2.total_records, t1.total_volume + t2.total_volume, t1.total_charges + t2.total_charges,
t3.total_records, t3.total_volume, t3.total_charges,
t1.total_records + t2.total_records + t3.total_records, t1.total_volume + t2.total_volume + t3.total_volume, t1.total_charges + t2.total_charges + t3.total_charges,
t4.total_records, t4.total_volume, t4.total_charges,
t1.total_records + t2.total_records + t3.total_records - t4.total_records,
t1.total_volume + t2.total_volume + t3.total_volume - t4.total_volume,
t1.total_charges + t2.total_charges + t3.total_charges - t4.total_charges,
abs(((t4.total_records) - (t1.total_records + t2.total_records + t3.total_records))/nullif((t1.total_records + t2.total_records + t3.total_records),0))*100,
	abs(((t4.total_volume) - (t1.total_volume + t2.total_volume + t3.total_volume))/nullif((t1.total_volume + t2.total_volume + t3.total_volume),0))*100,
	abs(((t4.total_charges) - (t1.total_charges + t2.total_charges + t3.total_charges))/nullif((t1.total_charges + t2.total_charges + t3.total_charges),0))*100,
	abs(((t1.total_records + t2.total_records  + t3.total_records) - (t1.total_records + t2.total_records + + t3.total_records))/nullif((t1.total_records + t2.total_records  + t3.total_records),0))*100,
	abs(((t1.total_charges + t2.total_charges + t3.total_charges) - (t4.total_charges))/nullif((t1.total_charges + t2.total_charges + t3.total_charges),0))*100 
from
(select file_name,nvl((select max(total_records) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-S'),0) total_records,
nvl((select max(total_volume) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-S'),0) total_volume,
nvl((select max(total_charges) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-S'),0) total_charges
from file_summary t1 where file_name in (select unique(file_name) from file_summary where  process_date = to_date($outTimeStamp,'YYYYMMDD') and usage_type like 'DISP%')
group by file_name) t1,
(select file_name,nvl((select max(total_records) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-H'),0) total_records,
nvl((select max(total_volume) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-H'),0) total_volume,
nvl((select max(total_charges) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-H'),0) total_charges
from file_summary t1 where file_name in (select unique(file_name) from file_summary where  process_date = to_date($outTimeStamp,'YYYYMMDD') and usage_type like 'DISP%')
group by file_name) t2,
(select file_name,nvl((select max(total_records) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-L'),0) total_records,
nvl((select max(total_volume) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-L'),0) total_volume,
nvl((select max(total_charges) from file_summary where file_name = t1.file_name and usage_type = 'DISP_RM-L'),0) total_charges
from file_summary t1 where file_name in (select unique(file_name) from file_summary where  process_date = to_date($outTimeStamp,'YYYYMMDD') and usage_type like 'DISP%')
group by file_name) t3, 
(select file_name,nvl((select max(total_records_dch) from file_summary where file_name = t1.file_name),0) total_records,
nvl((select max(total_volume_dch) from file_summary where file_name = t1.file_name ),0) total_volume,
nvl((select max(total_charges_dch) from file_summary where file_name = t1.file_name),0) total_charges
from file_summary t1 where file_name in (select unique(file_name) from file_summary where  process_date = to_date($outTimeStamp,'YYYYMMDD') and usage_type like 'DISP%')
group by file_name) t4 
where t1.file_name = t2.file_name and t1.file_name = t3.file_name and t3.file_name = t4.file_name
";

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
	if ( $switch ne "DATA_CIBER" ) {

		if ( $switch eq "LTE" ) {
			$hh = "$ENV{'REC_HOME'}/listLTE.pl $timeStamp |";
		}
		elsif ( $switch eq "NLDLT" ) {
			$hh = "$ENV{'REC_HOME'}/listLTE.pl $timeStamp NLDLT|";
		}
		elsif ( $switch eq "CIBER_CIBER" || $switch eq "DISP_RM" ) {
			$hh = 'find '
			  . $dirs{$switch}
			  . ' -name "'
			  . $switch . '*'
			  . $outTimeStamp
			  . '*" -print |';
		}
		else {
			$hh = 'find '
			  . $dirs{$switch}
			  . ' -name "'
			  . $switch . '*'
			  . $timeStamp
			  . '*" -print |';
		}

		if ( !open( FINDLIST, "$hh" ) ) {
			errorExit("Cannot create FINDLIST: $!\n");
		}

		while ( my $filename = <FINDLIST> ) {
			chomp($filename);

			$hh = "$ENV{'REC_HOME'}/$jobs{$switch} $filename &";

			# For testing...
			if ( $maxRecs < 50000000000000000000000000 ) {
				system($hh);
				$maxRecs = $maxRecs + 1;
			}

			# Put wait to complete 2 here
			while ( getTotalProc() > $max_process ) { sleep 5; }
		}

		# Put APRM Process Here

	}

		else {
	
			$hh = "$ENV{'REC_HOME'}/$jobs{$switch} $outTimeStamp &";
			system($hh);
		}

	# Put wait to complete here
	while ( getTotalProc() > 0 ) { sleep 5; }

	if ( $maxRecs > 0 ) {

		my $tmpStamp = $timeStamp;

		if ( $switch eq "DISP_RM" or $switch eq "CIBER_CIBER" ) {
			$tmpStamp = $outTimeStamp;
		}

		if (   $switch eq 'LTE'
			|| $switch eq 'DISP_RM'
			|| $switch eq 'NLDLT' )
		{
			$hh = "$ENV{'REC_HOME'}/getFileInfoAprmLTE.pl $switch $tmpStamp &";
		}
		else {
			$hh = "$ENV{'REC_HOME'}/getFileInfoAprm.pl $switch $tmpStamp  &";
		}

		system($hh);
	}

	while ( getTotalProc() > 0 ) { sleep 5; }

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
				"select * from rejected_records t1 where t1.file_name in 
					(select unique(t2.file_name) 
						from file_summary t2 
						where t2.usage_type like '$switch%' and t2.process_date = to_date($timeStamp,'YYYYMMDD'))";

			my $rejectTab = "Rejected " . $tab{$switch};
			createExcel( $sql, $heading, $rejectTab, $switch );
		}

		# Work Here
		if ( $switch eq "DISP_RM" || $switch eq "LTE" ) {

			my $tstamp = $timeStamp;

			if ( $switch eq "DISP_RM" ) {
				$tstamp = $outTimeStamp;
			}
			my $sql =
"select CARRIER_CODE, BP_START_DATE, USAGE_TYPE, RECORD_COUNT, TOTAL_CHARGES, TOTAL_VOLUME from aprm  where usage_type like '$switch%' and date_processed = to_date($tstamp,'YYYYMMDD')";

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
"select CARRIER_CODE, BP_START_DATE, CLEARINGHOUSE, TOTAL_CHARGES, TOTAL_VOLUME,CEIL(TOTAL_VOLUME/1024), CEIL((TOTAL_VOLUME/1024)/1024)  from APRM where usage_type = 'DATA_CIBER' and date_processed = to_date($outTimeStamp,'YYYYMMDD')";

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
                 sum(ceil((TOTAL_VOLUME/1024)/1024)),sum(TOTAL_CHARGES)"
			  . "       from aprm where usage_type = '$switch' and date_processed = to_date($timeStamp,'YYYYMMDD') group by  CARRIER_CODE,BP_START_DATE order by CARRIER_CODE";

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
"select CARRIER_CODE,MARKET_CODE, BP_START_DATE, sum(RECORD_COUNT), sum(ceil(TOTAL_VOLUME/60)),sum(TOTAL_CHARGES)"
			  . " from aprm where usage_type = '$switch' and date_processed = to_date($outTimeStamp,'YYYYMMDD') group by  CARRIER_CODE,MARKET_CODE, BP_START_DATE order by CARRIER_CODE";

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
"select CARRIER_CODE,BP_START_DATE, sum(RECORD_COUNT), sum(ceil(TOTAL_VOLUME/60)),sum(TOTAL_CHARGES)"
			  . "  from aprm where usage_type = '$switch' and date_processed = to_date($timeStamp,'YYYYMMDD') group by  CARRIER_CODE,BP_START_DATE order by CARRIER_CODE";

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

my @email = ('david.balchen@uscellular.com','Ilham.Elgarni@uscellular.com','USCDLISOps-BillingCycleManagement@uscellular.com');
foreach my $too (@email) {
	print $msg;
	sendMsg( $too, $msg );
}

exit(0);

sub createExcel {
	my ( $sql, $headings, $sheetname, $switch ) = @_;

	my $headcount = @{$headings};

	my $worksheet = $workbook->add_worksheet($sheetname);
	my $bold = $workbook->add_format( bold => 1 );
	$worksheet->write( 'A1', $headings, $bold );

	$sthb = $dbconnb->prepare($sql);
	$sthb->execute() or sendErr();

	my $cntrow = 1;
    my $flag = 0;
    
	while ( my @rows = $sthb->fetchrow_array() ) {

		my @fix_cols = [];

		if ( $headcount > 10 ) {

			@fix_cols = grep( s/\s*$//g, @rows[ 0 .. $headcount - 1 ] );
			$worksheet->write_row( $cntrow, 0, \@fix_cols );

			for ( my $a = $headcount ; $a < @rows ; $a = $a + 1 ) {
				if ( $rows[$a] >= 1 ) {

					if($flag == 0){$msg = $msg."$sheetname\n\n", $flag = 1;}

					$msg = $msg . "\tThe file $rows[0] has the following problem : \t";

					if ( $a == $headcount ) {

						$msg =
						    $msg
						  . "Total Records VS DCH Records = "
						  . sprintf( "%.2f", $rows[$a] ) . '%' . " \n\n";
					}
					elsif ( $a == $headcount + 1 ) {

						$msg =
						    $msg
						   ."Total Volume VS DCH Volume = "
						  . sprintf( "%.2f", $rows[$a] ) . '%' . " \n\n";
					}
					elsif ( $a == $headcount + 2 ) {

						$msg =
						    $msg
						   . "Total Charges VS DCH Charges = "
						  . sprintf( "%.2f", $rows[$a] ) . '%' . " \n\n";
					}
					elsif ( $a == $headcount + 3 ) {

						$msg =
						    $msg
						  . "Total Records VS APRM Records = "
						  . sprintf( "%.2f", $rows[$a] ) . '%' . " \n\n";
					}
					elsif ( $a == $headcount + 4 ) {

						$msg =
						    $msg
						  . "Total APRM Charges VS DCH Charges = "
						  . sprintf( "%.2f", $rows[$a] ) . '%' . " \n\n";
					}
				}
			}

		}
		else {
			@fix_cols = grep( s/\s*$//g, @rows );
			$worksheet->write_row( $cntrow, 0, \@fix_cols );
		}

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

	my ( $to, $message ) = @_;
	my $mime_type = 'multipart/mixed';
	my $from      = "david.balchen\@uscellular.com";
	my $subject   = "Roaming Reconciliation Report for $timeStamp";
	my $cc        = '';

	if ( length($message) > 3 ) {
		$subject = $subject . " (Investigation Required)";
	}

	$message = "You'll find the report attached to this email\n\n" . $message;

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
	my $dbPwd = "BODS_DAV_BILLINGOPS";
	my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );

	#my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "9000#GooBoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub getSNDPRD {

	my $dbPwd = "SND_SVC_BILLINGOPS";
	my $dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	# my $dbods = DBI->connect( "dbi:Oracle:sndprd", "md1dbal1", "9000#GooBoo");
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}


