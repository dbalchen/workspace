#! /usr/bin/perl
use POSIX;
use Cwd;
use File::stat;

my @fromdir = ();
$fromdir[0] = '/m01/switch/AAA';
$fromdir[1] = '/m01/switch/aaa1';
$fromdir[2] = '/m01/switch/aaa2';
$fromdir[3] = '/m01/switch/aaa3';

my @todir =   ();
$todir[0] = '/m01/switch/AAA';
$todir[1] = '/m01/switch/aaa1';
$todir[2] = '/m01/switch/aaa2';
$todir[3] = '/m01/switch/aaa3';

$userMachine = "calldmp5".'@'."knx1scd1";


for ($a = 0;$a < @todir; $a++) {
  chdir($todir[$a]);

  $hh = "ssh ".$userMachine." ls $fromdir[$a] |";

  print "$hh\n";

  if ( !open( CPLIST, "$hh" ) ) {
    print "Cannot create CPLIST: \n";
    exit(2);
  }

  while ($cpfile = <CPLIST>) {

    chomp($cpfile);

    $cpfile =~ s/\.\///g;

    $tofile = $todir[$a].'/'.$cpfile;
    $tofile2 = $tofile.'.gz';

    if (!-e $tofile && !-e $tofile2) {
      print  "Copying the file: $cpfile to $tofile\n";

      $ch = "scp ".$userMachine.':'.$fromdir[$a].'/'."$cpfile  $tofile";
      print "$ch\n";
      system($ch);
    }
  }

  close(CPLIST) or die "Could not close copy list\n";
}

exit(0);

