#! /usr/bin/perl
use POSIX;
use Cwd;
use File::stat;

if (!open( INFL,"< /home/calldmp/CallDump2.0/bin/SwitchDirs.csv")) {
  print "Cannot create INFL: \n";
  exit(2);
}

while ($infl = <INFL>) {
  chomp($infl);
  $infl =~ s/  *//g;

  ($userMachine,$fromdir,$todir) = split(/\|/,$infl);

  chdir($todir);

  $hh = "ssh ".$userMachine." ls $fromdir |";

  print "$hh\n";

  if ( !open( CPLIST, "$hh" ) ) {
    print "Cannot create CPLIST: \n";
    exit(2);
  }

  while ($cpfile = <CPLIST>) {

    chomp($cpfile);

    $cpfile =~ s/\.\///g;

    $tofile = $todir.'/'.$cpfile;
    $tofile2 = $tofile.'.gz';

    if (!-e $tofile && !-e $tofile2) {
      print  "Copying the file: $cpfile to $tofile\n";

      $ch = "scp ".$userMachine.':'.$fromdir.'/'."$cpfile  $tofile";
      print "$ch\n";
      system($ch);
    }
  }

  close(CPLIST) or die "Could not close copy list\n";
}

exit(0);

