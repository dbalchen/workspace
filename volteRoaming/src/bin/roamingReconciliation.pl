#! /usr/local/bin/perl

BEGIN {
  # push(@INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5');
    push(@INC, '/home/dbalchen/workspace/perl_lib/lib/perl5');
}

use Spreadsheet::WriteExcel;
use MIME::Lite;



#Test parameters remove when going to production.
#$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER,DATA_CIBER,LTE,DISP_RM";
#$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR";
#$ARGV[0] = "SDIRI_FCIBER";
#$ARGV[0] = "SDATACBR_FDATACBR";
#$ARGV[0] = "CIBER_CIBER";
#$ARGV[0] = "DATA_CIBER";
#$ARGV[0] = "LTE";
#$ARGV[0] = "DISP_RM";

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';

# Setup Initial variables
my $max_process = 5;

# Setup switch types and their directory location
my %dirs = {};
my %jobs = {};
my %headings = {};
my %tab = {};

$dirs{'SDIRI_FCIBER'} = '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DIRI';
$dirs{'SDATACBR_FDATACBR'} = '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DATACBR';
$dirs{'CIBER_CIBER'} = '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output';
$dirs{'DISP_RM'} = '/inf_nas/apm1/prod/aprmoper/var/usc/DISP';

$jobs{'SDIRI_FCIBER'} = 'getFileInfo.pl';
$jobs{'SDATACBR_FDATACBR'} = 'getFileInfoData.pl';
$jobs{'CIBER_CIBER'} = 'getFileInfoOutcollects.pl';
$jobs{'DATA_CIBER'} = 'getFileInfoOutcollectsData.pl';
$jobs{'LTE'} = 'getFileInfoLTE.pl';
$jobs{'DISP_RM'} = 'getFileInfoLTEOut.pl';


$headings{'SDIRI_FCIBER'} = ['File Name','Identifier','Total Records','Total Charges','Dropped Records','Duplicates','Sent To TC','Dropped TC','Rejected','Rejected Total','Dropped APRM','APRM Records','APRM Total'];
$headings{'SDATACBR_FDATACBR'} = ['File Name','Identifier','Total Records','Total Charges','Dropped Records','Sent To TC','Rejected','Rejected Total','Dropped APRM','APRM Records','APRM Total'];
$headings{'CIBER_CIBER'} = ['File Name','Total Records','Total Charges','APRM Records','APRM Total'];
$headings{'DATA_CIBER'} = ['Clearinghouse','Total Records','Revenue','Data Volume'];
$headings{'LTE'} = ['File Name','Identifier','Sender','Total Records','Total Charges','Rejected','Rejected Total','Dropped APRM','APRM Records','APRM Total'];
$headings{'DISP_RM'} = ['File Name','Identifier','Total Out','Total Records','APRM Totals'];
    
$tab{'SDIRI_FCIBER'} = "Voice Incollect";
$tab{'SDATACBR_FDATACBR'} = "Data Incollect";
$tab{'CIBER_CIBER'} = 'Voice Outcollect';
$tab{'DATA_CIBER'} = 'Data Outcollect';
$tab{'LTE'} = 'LTE Incollect';
$tab{'DISP_RM'} = 'LTE Outcollect';
# Get Roaming switches to check

my @switches = split(',', $ARGV[0]);

my $timeStamp =  $ARGV[1];
#my $timeStamp = '20161030';

my $excel_file = "RORC_".$timeStamp.'.xls';
$workbook = Spreadsheet::WriteExcel->new($excel_file);

# Get Roaming files
foreach my $switch (@switches) {
  my $hh = "";
my $maxRecs = 0;
if ($switch ne "DATA_CIBER") {

  if ($switch eq "LTE") {
  $hh = "$ENV{'REC_HOME'}/listLTE.pl $timeStamp |";
} else {
  $hh = 'find '.$dirs{$switch}.' -name "' . $switch . '*' . $timeStamp . '*" -print |';
}

if ( !open( FINDLIST, "$hh" ) ) {
     errorExit("Cannot create FINDLIST: $!\n");
  }

while ( my $filename = <FINDLIST> ) {
	chomp($filename);

	$hh = "$ENV{'REC_HOME'}/$jobs{$switch} $filename &";

	# For testing...
	if ($maxRecs < 5000) {
	system($hh);
	$maxRecs = $maxRecs + 1;
     }
	    
my $tproc = getTotalProc();
			 while ($tproc > $max_process ) {
			 sleep 10;
			 $tproc = getTotalProc()
		       }
}

if ($switch eq 'LTE' || $switch eq 'DISP_RM') {
  $hh = "$ENV{'REC_HOME'}/getFileInfoAprmLTE.pl $switch $timeStamp &";
} else {	
  $hh = "$ENV{'REC_HOME'}/getFileInfoAprm.pl $switch $timeStamp &";
}
system($hh);


} else {

  $hh = "$ENV{'REC_HOME'}/$jobs{$switch} $timeStamp &";
  system($hh);
}

sleep 10;
$tproc = getTotalProc();

while ($tproc > 0) {
  sleep 10; $tproc = getTotalProc();
}

createExcel($timeStamp,$switch,"rpt",$headings{$switch},$tab{$switch});

if (($switch ne "CIBER_CIBER") && ($switch ne "DATA_CIBER") && ($switch ne "DISP_RM")) {
  my $heading = ['File Name','Error Code','Error Description','Airtime Charge'];

  my $rejectTab = "Rejected ".$tab{$switch};
  createExcel($timeStamp,$switch,"err",$heading,$rejectTab);
}

# Work Here
if ($switch eq "DISP_RM" ||  $switch eq "LTE" ) {
  $heading = ['Carrier Code','BP Start Date','Record Count','Usage Sum','Data Volume'];
  $rejectTab = $tab{$switch}." APRM";
  createExcel($timeStamp,$switch,"arpm",$heading,$rejectTab);
	
} elsif ($switch eq "DATA_CIBER") {
  $heading = ['Partner','Settlement_Date','Clearinghouse','Revenue','Data_Volume'];
  $rejectTab = $tab{$switch}." by Partner";
  createExcel($timeStamp,$switch,"partner",$heading,$rejectTab);
} else {
  $heading = ['Carrier Code','Market Code','BP Start Date','Record Count','Usage Sum','Sum Amount'];
  $rejectTab = $tab{$switch}." APRM";
  createExcel($timeStamp,$switch,"arpm",$heading,$rejectTab);
}


$hh = "rm $switch".'*csv';
system("$hh");
}

$workbook->close;

my @email = ('ISBillingOperations@uscellular.com','Joan.Mulvany@uscellular.com','Syed.Sikander@uscellular.com','Janet.Korish@uscellular.com','david.balchen@uscellular.com','Jody.Skeen@uscellular.com','Liz.Pierce@uscellular.com');
#my @email = ('david.balchen@uscellular.com');

foreach my $too (@email) {
  sendMsg($too);
}

exit(0);

sub createExcel {
  my($ltime, $lswitch,$type,$headings,$sheetname) = @_;

  my $hh = "cat $lswitch*$ltime*$type* |";
    
  open(INFL1,$hh) or sendErr();
  my $worksheet = $workbook->add_worksheet($sheetname);
  my $bold      = $workbook->add_format(bold => 1);
  $worksheet->write('A1', $headings, $bold);
  #$worksheet->write_row(0,0,[","]);
  my $cntrow = 1;
    
  while ($ref = <INFL1>) {
    @cols = split("\t",$ref);
    my @fix_cols = grep(s/\s*$//g, @cols);
    $worksheet->write_row($cntrow,0,\@fix_cols);
    $cntrow++;
  }
    
  close(INFL1) or sendErr();

    
}

sub getTotalProc {

  my $shh = "ps aux | grep getFileInfo | grep -v 'grep' | wc -l";
  my $total_proc = `$shh`;
  chomp $total_proc;
  return $total_proc;
}


sub sendMsg(){

  my($to) = @_;
  my $mime_type = 'multipart/mixed';
  my $from = "david.balchen\@uscellular.com"; 
  my $subject = "Roaming Reconciliation Report for $timeStamp";
  my $message = "You'll find the report attached to this email";

  my $msg = MIME::Lite->new(
			    From => $from,
			    To => $to,
			    Cc => $cc,
			    Subject => $subject,
			    Type=>$mime_type) or die "Error creating " .  "MIME body: $!\n";

  $msg->attach(Type=>'TEXT',
	       Data=>$message) or die "Error adding text message: $!\n";

  $msg->attach(Type=>'application/octet-stream',
	       Encoding=>'base64',
	       Path=>$ENV{'REC_HOME'}.$excel_file,
	       Filename=>$excel_file) or die "Error attaching file: $!\n";
        
  $msg->send();
}

