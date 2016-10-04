#! /usr/local/bin/perl

BEGIN {
  push(@INC, '/home/dbalchen/workspace/perl_lib/lib/perl5');
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

#Test parameters remove when going to production.
#$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR";
#$ARGV[0] = "SDATACBR_FDATACBR";
$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';

# Setup Initial variables
my $max_process = 10;

# Setup switch types and their directory location
my %dirs = {};
my %jobs = {};
my %headings = {};
my %tab = {};

$dirs{'SDIRI_FCIBER'} = '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DIRI';
$dirs{'SDATACBR_FDATACBR'} = '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DATACBR';
$dirs{'CIBER_CIBER'} = '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output';

$jobs{'SDIRI_FCIBER'} = 'getFileInfo.pl';
$jobs{'SDATACBR_FDATACBR'} = 'getFileInfoData.pl';
$jobs{'CIBER_CIBER'} = 'getFileInfoOutcollect.pl';

$headings{'SDIRI_FCIBER'} = ['File Name','Identifier','Total Records','Total Charges','Dropped Records','Duplicates','Sent To TC','Rejected','Rejected Total','APRM Records','APRM Total'];
$headings{'SDATACBR_FDATACBR'} = ['File Name','Identifier','Total Records','Total Charges','Dropped Records','Sent To TC','Rejected','Rejected Total','APRM Records','APRM Total'];

$tab{'SDIRI_FCIBER'} = "Voice";
$tab{'SDATACBR_FDATACBR'} = "Data";
$tab{'CIBER_CIBER'} = 'Outcollect';

# Get Roaming switches to check

my @switches = split(',', $ARGV[0]);

my $timestamp =  $ARGV[1];

my $excel_file = "CDMA_".$timeStamp.'.xls';
$workbook = Spreadsheet::WriteExcel->new($excel_file);

# Get Roaming files
 foreach my $switch (@switches) {

   my $hh = 'find '.$dirs{$switch}.' -name "' . $switch . '*' . $timeStamp . '*DAT*" -print |';

   if ( !open( FINDLIST, "$hh" ) ) {
     errorExit("Cannot create FINDLIST: $!\n");
   }

   while ( my $filename = <FINDLIST> ) {
     chomp($filename);
     $hh = "$ENV{'REC_HOME'}/$jobs{$switch} $filename &";

     system($hh);
     my $tproc = getTotalProc();
     while ($tproc > $max_process ) {
       sleep 10;
       $tproc = getTotalProc()
     }
   }

   $hh = "$ENV{'REC_HOME'}/getFileInfoAprm.pl $switch $timeStamp &";
   system($hh);
  
   sleep 10;
   $tproc = getTotalProc();
   while($tproc > 0) {sleep 10; $tproc = getTotalProc(); }
  
   createExcel($timeStamp,$switch,"rpt",$headings{$switch},$tab{$switch});

   my $heading = ['File Name','Error Code','Airtime Charge'];

   my $rejectTab = "Rejected ".$tab{$switch};
   createExcel($timeStamp,$switch,"err",$heading,$rejectTab);

   $heading = ['Carrier Code','BP Start Date','Record Count','Usage Sum','Sum Amount'];
   $rejectTab = $tab{$switch}." APRM";
   createExcel($timeStamp,$switch,"arpm",$heading,$rejectTab);
  
   $hh = "rm $switch".'*csv';
   system("$hh");
  
   }

 $workbook->close;

my @email = ('ISBillingOperations@uscellular.com','david.balchen@uscellular.com','Jody.Skeen@uscellular.com','Liz.Pierce@uscellular.com');

foreach my $too (@email)
{
# sendMsg($too);
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

  sub pad {

    my ( $padString, $padwith, $length ) = @_;

    while ( length($padString) < $length ) {
      $padString = $padwith . $padString;
    }

    return $padString;

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
