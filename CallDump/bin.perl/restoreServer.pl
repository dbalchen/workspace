#! /usr/bin/perl


$market = lc($ARGV[0]);

if ($market eq "") {
  print "Need to run with a market name... Example... restoreServer.pl m05\n";
  exit(0);
}


# Open Log file and Create pid file

$logfile = "../log/".$market."restoreserver.log";
$pidfile = "../run/".$market."restoreserver.pid";

open(LOG,">$logfile") || die "Could not open log file.... CallDump Failed!!!!";

open(PID,">$pidfile") || die "Could not start ".$market."restoreServer";
close(PID) ||  die "Could not close PID file ".$market."restoreServer";

$archivepath = "/".lc($market).'/switch/';

$marketDir = "/".lc($market).'/';
$owner = calldmp.substr($market,2,1);
$chownPath = "chown -R $owner".":calldmp $marketDir";
$chmodPath = "chmod -R 775 $marketDir";

print LOG "restoreServer started....\n";

chdir("../log");

$logdir = `pwd`;
chomp($logdir);

chdir("../restore");
$resdir = `pwd`;
chomp($resdir);

print LOG "Log Directory: ".$logdir." Restore Directory: ".$resdir."\n";

while (-e $pidfile) {

  $hh = "ls | grep FIN | grep ".$market.' | grep -v failed';

  @RESTORES = `$hh`;

  $resjob = $RESTORES[0];
  chomp($resjob);
  $resjob =~ s/  *//g;

  if (!$resjob eq "") {


    if (index($resjob,"fileprops") >= 0) {
      print LOG "A file properties request has been made\n";
      print LOG "$chownPath\n $chmodPath\n";
      system($chownPath);
      system($chmodPath);
      unlink($resjob);
    } else {

      if (index($resjob,"filehold") >= 0) {
	print LOG "A file hold request has been made\n";

	my $fileHold = $market."HOLD";

	open(HOLD,"> $fileHold" );close(HOLD);
	unlink($resjob);

	while (-e $fileHold) {
	  sleep 10;
	}
	print LOG "Hold process is finished\n";

      } else {

	print LOG "A restore request has been made: $resjob \n";

	$startdate = "";

	unlink($resjob);
	$timestamp =  (split(/\./,$resjob))[-2];

	$verified = $resdir.'/'.$market.'restore.files.'.$timestamp.'.verified';
	$restoreFile = $resdir.'/'.$market.'restore.files.'.$timestamp;
	$pathfile = $resdir.'/'.$market.'restore.path.'.$timestamp;

	open(VER,"> $verified" ) || die "Could not open ".$verified;
	open(RF,"< $restoreFile") || die  "Could not open ".$restoreFile;

	while ($buff = <RF>) {

	  chomp($buff);

	  $file =  (split(/\//,$buff))[-1];
	  $filepath = $archivepath.getSwitchDir($file).'/'.$file;

	  if (! -e $filepath) {
	    $filedate = substr($filepath,index($filepath,"_T2")+2,12);

	    if ($filedate < $startdate || $startdate eq "") {
	      $startdate = $filedate;
	    }
	    print VER "$buff\n";
	  }
	}

	close(RF);
	close(VER);

	$CDlogfile = $logdir."/CallDumpRequest.".$timestamp.'.log';

	$usage_machine = $market."usg1";
	$bpstdate = substr($startdate,4,2).'/'.substr($startdate,6,2).'/'.substr($startdate,0,4)." 00:00:00";
	$bpendate = substr($timestamp,4,2).'/'.substr($timestamp,6,2).'/'.substr($timestamp,0,4)." 23:59:59";

	$hh =  "/usr/openv/netbackup/bin/bprestore -L $CDlogfile -A -K -s $bpstdate -e $bpendate -R $pathfile -C $usage_machine -w -f $verified\n";

	if (-s "$verified") {

	  print LOG "Will run a bprestore with the following command:\n $hh \n";

	  if (system("$hh")) {
	    open(F, ">>$CDlogfile") || warn "Cannot open $CDlogfile..\n";
	    print F "Failed to initiate the file restore: $!\n";
	    open(RES,">$resjob".".failed");
	    close(RES);
	    break;

	  }
	  sleep 30;
	} else {
	  print LOG "All Files have been restored in a previous run... Skipping Restore\n";
	}

	$rmdir = "rm *".$timestamp."*";
	system($rmdir);
      }
    }
  }
  sleep 10;
}

print LOG "The restore server for $market will be shutdown\n";

close(LOG) || die "Could not close log file....";
exit(0);


sub getSwitchDir {

  my $file = shift;
  my $switchdir = lc(substr($file,1,4));

  if ($switchdir eq "mots") {
    $switchdir = "mot";
  } elsif ( $switchdir eq "pmsg") {
    $switchdir = lc(substr($file,1,5));
    $switchdir =~ s/s//g;
  } elsif ($switchdir eq "ptts") {
    $switchdir = lc(substr($file,1,5));
  } elsif ( $switchdir eq "qis_") {
    $switchdir = "qis";
  }

  return $switchdir;
}
