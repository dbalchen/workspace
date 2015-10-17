#! /usr/bin/perl

use lib "./MIME";
use MIME::Lite;
use Time::Local qw(timelocal);

$switches      = $ARGV[0];
$searchandtype = $ARGV[1];
$startdate     = $ARGV[2];
$enddate       = $ARGV[3];
$email         = $ARGV[4];
$timestamp     = $ARGV[5];
$fileMaxSize   = 20000;
$numberOfFiles = 0;

$total_files_atOnce = 500;

$localCnt   = 0;

@localVec   = ();
@localFiles = ();
$market;
$switchstring;
%SwitchType = ();
$searchSwitch;

$year    = substr($timestamp, 0,  4 );
$mon     = substr($timestamp, 4,  2 );
$mday    = substr($timestamp, 6,  2 );
$hour    = substr($timestamp, 8,  2 );
$min     = substr($timestamp, 10, 2 );
$sec     = substr($timestamp, 12, 2 );
$StartDt = substr($startdate,0,8);
$EndDate = substr($enddate,0,8);

$PWD = `pwd`;
chomp($PWD);

# Open Log file and Create pid file

$logfile = "../log/CallDumpRequest." . $timestamp . ".log";
$pidfile = "../run/pid." . "$timestamp";

open( LOG, ">$logfile" )
  || errorExit("Could not open log file.... CallDump Failed!!!!");

chmod 0777,$logfile;

open( PID, ">$pidfile" )
  || errorExit("Could not create pid file.... CallDump Failed!!!!");
close(PID) || errorExit("Could not close pid file.... CallDump Failed!!!!");

# Create Search string array

my @Searches = split( /:/, $searchandtype );

print LOG "Running a CallDump for the following:\n";

for ( my $a = 0 ; $a < @Searches ; $a++ ) {

  my ( $searchstring, $searchtype ) = split( /;/, $Searches[$a] );

  print LOG "Search String: "
    . $searchstring
      . " SearchType: "
	. $searchtype . "\n";

  my @Switches = split( /:/, $switches );

  for ( my $b = 0 ; $b < @Switches ; $b++ ) {

    ( $market, $switchstring ) = split( /;/, $Switches[$b] );

    print LOG "Market: " . $market . "\n";

    my @marketSwitches = split( /,/, $switchstring );

    for (my $c = 0 ; $c < @marketSwitches ; $c++ ) {

      $searchSwitch = $marketSwitches[$c];

      print LOG "Switch: " . $searchSwitch . "\n";

      checkPid();

      my $filestartdate  = substr( $startdate, 0, 4 ) . 
	substr( $startdate, 4, 2 ) .
	  substr( $startdate, 6, 2 ) .
	    "000000";

      my $fileenddate = substr( $EndDate, 0, 4 ) .
	substr( $EndDate, 4, 2 ) .
	  substr( $EndDate, 6, 2 ) .
	    "235959";

      my $grepSwitchStr = transitionOldSwitches($searchSwitch);

      my $testdate = $year.$mon.$mday;

      my $archivepath = '';
      if (uc($market) eq "M06") {

	$archivepath = '/m02/switch/Data';

      } else {

	$archivepath = "/" . lc($market) . '/switch/';
      }

      $hh = "find $archivepath -name ".'"'.'*.DAT*'.'"'." -follow -print| egrep '$grepSwitchStr' | grep -v wedo | ";

      print LOG "Running find command \n";
      print LOG "$hh\n";

      if ( !open( FINDLIST, "$hh" ) ) {
	errorExit("Cannot create FINDLIST: $!\n");
      }

      checkPid();

      while ( $filename = <FINDLIST> ) {
	chomp($filename);
	
	$restorefile =  ( split( /\//, $filename ) )[-1];
	$start = index($restorefile, "_T2");
	$start = $start + 2;
	$filedate = substr($restorefile, $start, 14);
	if (($filedate < ($filestartdate)) || ($filedate > ($fileenddate))) {
	  next;
	}

	checkAndLoad($searchstring, $searchtype,$filename);
	checkPid();

      }

    }

    checkPid();

    if ( $localCnt > 0 ) {

      RunGetInfo(
		 \@LocalVec, $searchstring, $searchtype
		);
      $localCnt = 0;
      @LocalVec = ();
    }

  }

  checkPid();

  formatAndEmailReport($searchstring);
}

# Exit the program and do cleanup

print LOG "CallDump is complete processing $numberOfFiles \n";

if ($numberOfFiles == 0) {
  emailNotice("This CallDump has no data\n");
}

cleanUp();

print STDOUT ":".$numberOfFiles.":";

exit(0);

sub formatAndEmailReport {

  my $searchstring  = shift;
  my $hh            = "";
  my @keyz          = keys %SwitchType;
  my $switch        = "";
  my $basefile      = "";
  my $REPORT_HEADER = "";
  my $filesize      = 0;
  my $rc            = 0;
  my @splitfiles    = ();
  my $hostname = `hostname`;chomp($hostname);

  for ( my $b = 0 ; $b < @keyz ; $b++ ) {

    chdir("../reports");

    my $Key = $keyz[$b];

    if ( length($Key) != 0 ) {

      $switch = $Key;

      print "Format switch = $Key\n";

      $basefile = $Key ."_" . $searchstring. "_" . $timestamp ;
      open( REPORT, "> A_" . $basefile . ".tmp" );

      select(REPORT);

      # Modify for SMS
      if (( index( $Key, "PTX" ) != -1 )) {
	$REPORT_HEADER = getReportHeaderFormat("PMG");
      } else {
	$REPORT_HEADER = getReportHeaderFormat($Key);
      }

      $~ = "$REPORT_HEADER";

      write;
      close(REPORT);

      if ( index( $Key, "AAA" ) != -1 ) {

	$hh =
	  "sort  -u ".$basefile.".utmp | sort -n -k 1.38n,1.51n > "
	    . $basefile . ".tmp";
      }

######################## Fix Here ################################
      if ((index( $Key, "PGW" ) != -1)) {

	$hh =
	  "sort  -u ".$basefile.".utmp | sort -n -k 1.38n,1.51n > "
	    . $basefile . ".tmp";
      }

      # Modify
      if ( (index( $Key, "NTI" ) != -1) ||  (index( $Key, "TAS" ) != -1)) {

	$hh =
	  "sort  -u ".$basefile.".utmp | sort -n -k 1.9n,1.10n  -k 1.1n,1.2n > "
	    . $basefile . ".tmp";
      }


      if ( ( index( $Key, "PMG" ) != -1 ) || ($switch eq "PTX")) {
	$hh =
	  "sort -u ".$basefile.".utmp |sort -n -k 1.1n,1.14n > "
	    . $basefile . ".tmp";
      }

      if ( index( $Key, "QIS" ) != -1 ) {
	$hh =
	  "sort -u ".$basefile.".utmp | sort -n -k 1.1n,1.8n > "
	    . $basefile . ".tmp";
      }


      if ( (index( $Key, "MOT" ) != -1)  || (index( $Key, "SMS" ) != -1 )) {
	$hh =
	  "sort  -u ".$basefile.".utmp | sort -n -k 1.48n,1.51n  -k 1.42n,1.43n -k 1.45n,1.46n  -k 1.53n,1.54n  -k 1.56n,1.57n  -k 1.59n,1.60n > "
	    . $basefile . ".tmp";
      }

      # sort....
      # Check for size....
      # If to large split
      system($hh);

      @splitfiles = ();
      $hh         = "wc -l " . $basefile . ".tmp  | cut -d' ' -f1 | sed 's/ //g';";
      $filesize   = `$hh`;
      chomp($filesize);

      if ( $filesize > $fileMaxSize ) {
	$hh =
	  "split -l $fileMaxSize "
	    . $basefile . ".tmp "
	      . $basefile . ".tmp";

	$rc = system($hh);

	$hh = "ls "
	  . $basefile
	    . ".tmp* | grep -v "
	      . "'tmp\$'"
		. " | sort ";

	@splitfiles = `$hh`;
	chomp(@splitfiles);

      }

      if ( 0 == @splitfiles ) {

	$splitfiles[0] = $basefile . ".tmp";
      }

      open( REPORT, "> Z_" . $basefile . ".tmp" );
      select(REPORT);

      if (( index( $Key, "MOT" ) != -1 ) || (index($Key, "SMS") != -1)) {
	$REPORT_HEADER = getReportTrailerFormat("SMS")
      } elsif (( index( $Key, "PTX" ) != -1 )) {
	$REPORT_HEADER = getReportTrailerFormat("PMG")
      } else {
	$REPORT_HEADER = getReportTrailerFormat($Key)
      }

      $~ = "$REPORT_HEADER";
      write;
      close(REPORT);

      for ( my $a = 0 ; $a < @splitfiles ; $a++ ) {

	chdir("../reports");

	my $cnt         = $a + 1;
	my $report_name =
	  "CALLDUMP_REPORT.".$hostname."_" . $basefile . "." . $cnt . ".dat";

	$hh = "cat A_"
	  . $basefile . ".tmp "
	    . $splitfiles[$a] . " Z_"
	      . $basefile
		. ".tmp > "
		  . $report_name;
	$rc = system($hh);

	chdir("../bin");

	$hh = $PWD
	  . "/send_dump.pl $Key ../reports/"
	    . $report_name
	      . " $email";
	$rc = system($hh);

      }

    }

  }
}

sub emailNotice {
  my ($msg) = shift;
  my $whoami = `whoami`;
  chomp $whoami;
  my $from_address = $whoami;
  my $to_address   = "$email";
  my $hostname     = `hostname`;
  chomp($hostname);
  my $subject      = "Call Dump report on $hostname";
  my $message_body =
    "Call Dump Details:\n\nDate:\t\t\t$mon/$mday/$year\nRequestor:\t\t$email\nFrom:\t\t\t$startdate\nTo:\t\t\t$enddate\nSwitches:\t\t$switches\nString:\t\t$searchandtype\nMessage:\t$msg...\n";

  chdir("../bin");
  ### Create the multipart container
  my $mess = new MIME::Lite(
			    From    => $from_address,
			    To      => $to_address,
			    Subject => $subject,
			    Type    => 'multipart/mixed'
			   )
    or die "Error creating multipart container: $!\n";

  ### Add the text message part
  $mess->attach(
		Type => 'TEXT',
		Data => $message_body
	       )
    or die "Error adding the text message part: $!\n";
  $mess->send;

}

sub RunGetInfo {
  #  my ( $markt, $runfiles, $searchstring, $searchtype) = @_;

  my ( $runfiles, $searchstring, $searchtype) = @_;

  print LOG "Entered RunGetInfo starting to process files\n";

  my @rfiles = @{$runfiles};
  my $pwd = `pwd`;

  chomp($pwd);

  for ( my $a = 0 ; $a < @rfiles ; $a++ ) {


    my $file = (( split(/\//,$rfiles[$a]))[-1]);

    my $switch = (( split(/\//,$rfiles[$a]))[-2]);
    my $datetime = ((split(/_/,$file))[-1]);
    my $ftype = '';
    $datetime = substr($datetime,1,8);
    
    #   Need to change here!!!!

    if ((index($file,"MOT") >= 0) || (index($file,"ALU") >= 0)) {
      addSwitchType("SMS");
    } elsif ((index($file,"PTX") >= 0)) {
      addSwitchType("PTX");
    } elsif ((index($file,"AAA") >= 0)) {
      addSwitchType("AAA");
    } elsif ((index($file,"QIS") >= 0)) {
      addSwitchType("QIS");
    } elsif ((index($file,"PMG") >= 0)) {
      addSwitchType("PMG");
    } elsif ((index($file,"PGW") >= 0)) {
      addSwitchType("PGW");

    } elsif ((index($file,"TAS") >= 0)) {
      addSwitchType("TAS");
    }else {
      # This is a voice file

      # Modify this
      if ((index($file,"UFF") >= 0) && ($datetime >= 20130901)) {
	addSwitchType("NTI");
        $file =~ s/FUFF/FNTI/g;
        $ftype = "-ft UFF";
      } else {
	delete $rfiles[$a];
	next;
      }
    }
    # run the files
 
    $file = $file.'.'.$timestamp;

    symlink $rfiles[$a],
      '../work/' . $file || errorExit( "Cannot link to" . '/' . "$file\n" );

    my $hh = $pwd
      . '/GetInfo -w ../work'
	. " -dd  -f $file -s $searchstring -sw $switch -st $searchtype $ftype &";

    # Check to see how many GetInfo processes are running.
    my $GetInfoCnt =
      `ps aux | grep /GetInfo | grep $timestamp |grep -v grep | wc -l`;
    chomp $GetInfoCnt;

    while ( $GetInfoCnt > 15 ) {
      print LOG
	"Too many GetInfo processes running: $GetInfoCnt...sleeping 10 seconds\n";
      sleep 10;
      $GetInfoCnt =
	`ps aux | grep /GetInfo | grep $timestamp | grep -v grep | wc -l`;
      chomp $GetInfoCnt;
    }

    # Run command.
    print LOG "Processing file: $hh\n";
    system("$hh");
    $numberOfFiles++;


  }

  # Wait till complete
  chdir("../work");
  sleep 7;

  # Get total number of files loop until finished.
  my $NumPro = @rfiles;

  while ( $NumPro > 0 ) {
    $NumPro = 0;
    $hh = 'ls -alt *'.$timestamp.'.TMP | wc -l ';
    $NumPro = `$hh`;chomp($NumPro);
    checkPid();
    sleep 10;
  }

  my @keyz = %SwitchType;
  for ( my $b = 0 ; $b < @keyz ; $b++ ) {

    my $Key = $keyz[$b];

    if ( length($Key) != 0 ) {

      # More changes here

      if ($Key eq "SMS") {
	$hh = buildCat($Key,"MOT",$searchstring);
	system($hh);
	$hh = "*MOT".'*'.$timestamp . "*";
        system("rm -f $hh");

	$hh = buildCat($Key,"ALU",$searchstring);
	system($hh);
	$hh = "*ALU".'*'.$timestamp . "*";
        system("rm -f $hh");

      } else {
	$hh = buildCat($Key,$Key,$searchstring);
	system($hh);
      }
      my $delFile = "*".$Key.'*'.$timestamp . "*";
      system("rm -f $delFile");
    }
  }

  chdir("../bin");

}

sub addSwitchType {
  my $type = shift;

  if ( !exists $SwitchType{$type} ) {
    $SwitchType{$type} = "";
  }

  return;
}

sub buildCat {
  my ($key,$key2,$searchstring) = @_;

  my $catkey = 
    "cat *" . $key2
      . "*$timestamp*Out >> ../reports/"
	. $key . "_"
	  .$searchstring."_"
	    .$timestamp.".utmp";
  return $catkey
}

sub errorExit {

  my $msg = shift;

  print LOG $msg;

  cleanUp();

  emailNotice($msg);

  exit(12);
}

sub cleanUp {

  close(LOG)
    || errorExit("Could not close log file..... CallDump failed!!!!!");
  unlink($pidfile);

  my $rmdir =
    "rm ../work/*$timestamp*; rm ../restore/*$timestamp*; rm ../reports/*$timestamp*tmp;";
  system($rmdir);

}

sub checkPid {

  if ( -e $pidfile ) {

    return;
  }

  print LOG "Pid file does not exist... Exiting the program\n";

  cleanUp();

  exit(0);
}

sub checkAndLoad {

  my ($searchstring,$searchtype,$archivefile) = @_;

  if ( -e $archivefile ) {

    $LocalVec[$localCnt] = $archivefile;
    print LOG
      "Will Search the following file: $archivefile\n";

    $localCnt = $localCnt + 1;

  } 

  if ( $localCnt >= $total_files_atOnce ) {
      RunGetInfo(
                 \@LocalVec, $searchstring, $searchtype
                );
      $localCnt = 0;
      @LocalVec = ();
  }

}




#################################################################
# The following sub routine uses an external flat file          #
# switch_transition that is an array of switches. The first     #
# element is the key "switch" and the second element is any     #
# number of switches. For instance, the key may be "PEOR"       #
# and the second element contains "PEO2". This sub-routine      #
# will push "PEO2" onto @switch_arr, so both will be processed. #
#################################################################

sub transitionOldSwitches {

  my $switch = shift;

  my $switch_file = "switch_transition";

  my @switch_arr;

  $switch_arr[0] = uc($switch);

  open( SWITCH, "$switch_file" )
    || die "Couldn't open switch_transition file,$!\n";

  while (<SWITCH>) {

    chomp;

    my @transition_arr = split( /,/, $_ );

    my ($transition_key) = @transition_arr;

    my @transition_switches = split( / /, $transition_arr[1] );

    if ( $transition_key eq $switch_arr[0] ) {

      my $a;
      for ( $a = 0 ; $a < @transition_switches ; $a++ ) {
	$switch_arr[ $a + 1 ] = $transition_switches[$a];
      }
    }
  }

  my $tmp;
  my @grep_arr;
  my $cnt = 0;

  foreach $switch_arr (@switch_arr) {
    $tmp =
      "S" . ${ switch_arr;
	     }
	. ".*DAT\$";
    $grep_arr[$cnt] = $tmp;
    $cnt++;
  }
  foreach $switch_arr (@switch_arr) {
    $tmp =
      "S" . ${ switch_arr;
	     }
	. ".*DAT.gz\$";
    $grep_arr[$cnt] = $tmp;
    $cnt++;

  }

  $tmp = join '|', @grep_arr;

  return $tmp;
}

#/**
# Return report header information based on file type.
#**/

sub getReportHeaderFormat {

  # Report Header definition.
  $_ = @_[0];

  my $switch = @_[0];

if (/NTI/ || /UFF/) {

    format NTI_12_REPORT_HEADER =
Switch : NTI                                      NTI Formatted Record Dump                                  Date: @</@</@<<<
$mon,$mday,$year
Time Frame - @<<<<<<<<<<<  to @<<<<<<<<<<<       Translated Usage From Switch                                Time: @<.@<.@< 
$StartDt, $EndDate,$hour,$min,$sec
										
Start      Connect   Duration     ESN         MSID   Orig       Dialed         Terminating    Called          Call DR AN 3W CW CF MS   Orig Term Switch Service
Date       Time      (Sec)                           Number     Digits         MSID           Number          Type                     CLLI CLLI        Feature
.

    return "NTI_12_REPORT_HEADER";

  } 



if (/TAS/) {

    format TAS_REPORT_HEADER =
Switch : VOLTE                                    VOLTE Formatted Record Dump                  Date: @</@</@<<<
$mon,$mday,$year
Time Frame - @<<<<<<<<<<<  to @<<<<<<<<<<<        Translated Usage From Switch                 Time: @<.@<.@< 
$StartDt, $EndDate,$hour,$min,$sec

Start      Connect   Duration Orig       Dialed       Called       DR AN 3W  CW CF MS   Switch Service
Date       Time      (Sec)    Number     Digits       Number                                   Feature
.
    return "TAS_REPORT_HEADER";

  } elsif (/APLX/) {

    format APLX_REPORT_HEADER =
Switch : APLX                                     APLX Record Dump                           Date: @</@</@<<<
$mon,$mday,$year
Time Frame - @<<<<<<<  to @<<<<<<<         Translated Usage From Tape                        Time: @<.@<.@< 
$StartDt, $EndDate,$hour,$min,$sec

Struct Call Answ Serv Orig          ESN        MSID      Start              Durtn   Called       Orig  Term  Switch
Code   Type Stat Feat Number                             Date       Time    (sec)   Number       CLLI  CLLI 
------ ---- ---- ---- ---------- ----------- ---------- --------- --------- ----- -------------  ----- ----- -----
.

    return "APLX_REPORT_HEADER";

  } 

elsif (/SMS*/) {

    format SMS_REPORT_HEADER =

 Switch: SMS    ***                SMS Record Dump            ***                            Date: @</@</@<<<
$mon,$mday,$year
Time Frame - @<<<<<<<  to @<<<<<<<                  Translated Usage From Tape               Time: @<.@<.@<
$StartDt, $EndDate,$hour,$min,$sec


Record  Calling         Called           Submission           Delivery             Term  Number
Type    Number          Number           Date   &   Time      Date   &   Time      Code  Attempts
------  --------------  ---------------  -------------------  -------------------  ----  --------
.

    return "SMS_REPORT_HEADER";

  } 

 elsif (/QIS*/) {

    format QIS_REPORT_HEADER =
 Switch: QIS                                 Cellular Formatted Record Dump                                        Date: @</@</@<<<
$mon,$mday,$year
                                                                                                                   Time: @<.@<.@<
$hour,$min,$sec

LOCAL                             TRANSACTION         PART              APPLICATION                EVENT   CHARGE   ADJUSTMENT  ADJ  PRC
TIME STAMP           MSID             ID             NUMBER                NAME                    TYPE    AMOUNT    AMOUNT     RSN  MTH
---------------  ---------------- ------------ ------------------  ------------------------------  -----   -------  ----------  ---  ---

.
    return "QIS_REPORT_HEADER";
  } 

elsif (/AAA*/) {
    format AAA_REPORT_HEADER =

 Switch: @<<                                  Cellular Formatted Record Dump                      Date: @</@</@<<< 
$switch,$mon,$mday,$year
                                                                                                  Time: @<.@<.@< 
$hour,$min,$sec

                                                        DURATION                    SERV  ROAMING                   CARRIER                SESSION
LOGIN_NAME         CALLING_NUM/IP      START_DATE       IN_SECONDS   TOTAL_BYTES    OPT   IND       SID  NID  CELL  ID                     ID
---------------    ---------------     -------------    -----------  -------------  ----  -------   ---- ---- ----  ---------------------  ---------------------
.
    return "AAA_REPORT_HEADER";
  } 
elsif (/PGW*/) {
    format LTE_REPORT_HEADER =

 Switch: LTE                                         Cellular Formatted Record Dump                                  Date: @</@</@<<<
$mon,$mday,$year
                                                                                                                     Time: @<.@<.@<
$hour,$min,$sec
                                                     DURATION                          ROAMING                       CARRIER I.P Adress
TIMSI               CALLING_NUM      START_DATE      IN_SECONDS   TOTAL_BYTES          IND     SID     BSID          ID
---------------     ---------------  -------------   -----------  -------------------  ------- ----    ------------  ------  --------------

.
    return "LTE_REPORT_HEADER";
  } elsif (/PMG*/) {

    format PMG_REPORT_HEADER =
 Switch: PMG                                             Cellular Formatted Record Dump                                  Date: @</@</@<<<
$mon,$mday,$year
                                                                                                                         Time: @<.@<.@<
$hour,$min,$sec

                                                                                                                                    ROAMING  HOME   SERVE  CARRIER
START_TIME           END_TIME             MSID            CLIENT_IP          SERVER_IP           BYTES_IN      BYTES_OUT    MSG_DIR IND      SID    SID    ID
---------------     ---------------      -------------   ---------------     ---------------     ----------    ----------   ------- -------  ---    -----  -------
.
    return "PMG_REPORT_HEADER";
  } 


  format UNKNOWN =
Switch : @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< *** UNKNOWN RECORD FORMAT                        *** Date: @</@</@<<<
$switch,$mon,$mday,$year
					Translated Usage From Tape                            Time: @<.@<.@< 
$hour,$min,$sec
.
  return "UNKNOWN";	     # Return 1 if match found, else return 0.

}

#/**
# Return report trailer information based on file type.
#**/

sub getReportTrailerFormat {
  $_ = @_[0];
  if (/NTI/ || /TAS/) {
    format NTI_REPORT_TRAILER =

AN:  Call Answered                     CF: Call Forwarding
3W:  Three way calling                 MS: Multiple switches
CW:  Call Waiting

Service Features:
ARM:    Automatic Roaming     CDLX:   Call Delivery Interconnect          CFW:    Call Forward Immediate              
CFB:    Call Forward Busy     CFWTRN: Call Forward No Answer Transfer     HT:     Calls to/from hotline          
ISH:    Inter system handoff  OPA:    Operator assisted call              VFF:    Vertical feature flag  
VMD:    Voice-mail delivery   VMR:    Voice-mail retrieval                CIR:    Caller ID Restriction

.
      return "NTI_REPORT_TRAILER";
  }

    if (/SMS/) {
    format SMS_REPORT_TRAILER =

                   ***   END-OF-REPORT    ***  


 RECORD TYPES:                                    TERM CODES:
 1  Non-mobile originated          (incoming)    100 Delivered
 2  Mobile originated              (outgoing)    101 Undelivered (Expired)
 4  Receipt                        (dropped)     102 Undelivered (Deleted)
 5  Non-mobile orig multi-cast sub (dropped)     103 Undelivered (system error)
 6  Mobile orig multi-cast sub     (dropped)     104 Invalid called number
 7  Manual acknowledgment          (dropped)     105 Accepted via TPSMT
 8  Multi-cast manual acknwldgmnt  (dropped)     108 Rejected (network error)

 MSG TYPE=CALLING NUMBERS:
 Email = 0001112222    Tap       = 0002223333
 Email = 0001113333    Ring Tone = 0003334444
.
      return "SMS_REPORT_TRAILER";
  } 

elsif (/QIS/) {
    format QIS_REPORT_TRAILER =

                    ***   END-OF-REPORT    ***




EVENT TYPES         DA = SID Deactivate       DE = Delete            DL=DownLoad 
                    MA = Developer Adjustment SB = Subscription Bill SX = Extension associated with an SB 
                    SE = Subscription End     DL = Download          EX = Extension Download associated with a DL
                    TA = Transaction Adjustment                      TR = SID Transfer on same Physical Phone

ADJ RSN             1 = Duplicate Download    2 = Accidental Download 3 = Customer Dissatisfaction
                    4 = Application Recall    5 = Consumer Bad Debt   6 = Part Number Adjustment
                    7 = General Adjustment

PRC MTH             1 = Demo      2 = Purchase   3 = Subscribe 4 = Upgrade   5 = PreInstall 6 = Flat Fee
                    7 = Fixed Percentage

.
      return "QIS_REPORT_TRAILER";
  } elsif (/APLX/) {
    format APLX_REPORT_TRAILER =
------ ---- ---- ---- ---------- ----------- ---------- --------- --------- ----- ------------- ----- -----
Call Type:
***********************************************************************************************************
031   Call Forwarding Activation/Deactiviation        032     Landline Trunk
051   Mobile Terminated Call                          052     Lucent internal: Mobile Security Entry
074   Free/No Charge Call                             090     Lucent internal: Tracer Record
307   Operator Assisted Call                          308     Lucent internal: Flexent/APLX Wrls  Act/Deact
346   Cellular-Originated Call                        347     Toll Cellular-Originated Call
356   Cellular Network Handoff                        357     Cellular Network Handback

Service Feature:
***********************************************************************************************************
000   No Service Feature                              010     Three Way Calling
012   Call Forwarding-Immediate                       014     Call Forwarding-Busy or no answer
056   Call Waiting                                    089     Cellular Network Activation/Deactivation
097   Landline Trunk                                  100     Call Delivery: Roaming or multiple switches
104   Lucent internal: Mobile Station Test            304     Call Waiting Call Back
800   Lucent internal: Information Services Gateway   811     Lucent internal: Ext/Int Peripher Tandem Trnk
812   Activate or update cell phone info                                      

.
      return "APLX_REPORT_TRAILER";
  } elsif (/PMG/) {
    format PMG_REPORT_TRAILER =

MESSAGE DIRECTION (MSG DIR) :  0 = INCOMING   1 = OUTGOING

.
      return "PMG_REPORT_TRAILER";
  } 

elsif (/PTX/) {
    format PTX_REPORT_TRAILER =

                    ***   END-OF-REPORT    ***  


RECORD TYPES:                                    TERM CODES:
1  Non-mobile originated          (incoming)    100 Delivered
2  Mobile originated              (outgoing)    101 Undelivered (Expired)
4  Receipt                        (dropped)     102 Undelivered (Deleted)
5  Non-mobile orig multi-cast sub (dropped)     103 Undelivered (system error)
6  Mobile orig multi-cast sub     (dropped)     104 Invalid called number
7  Manual acknowledgment          (dropped)     105 Accepted via TPSMT
8  Multi-cast manual acknwldgmnt  (dropped)     108 Rejected (network error)

MSG TYPE=CALLING NUMBERS:
Email = 0001112222    Tap       = 0002223333
Email = 0001113333    Ring Tone = 0003334444
.
      return "PTX_REPORT_TRAILER";
  }

  format EMPTY_TRAILER =
                   ***   END-OF-REPORT    ***
.
	return EMPTY_TRAILER;

}

