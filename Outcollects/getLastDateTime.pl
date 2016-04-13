#! /usr/local/bin/perl

while ($buff = <STDIN>) {

  chomp($buff);


  $hh = " grep ^22 $buff | cut -b105-110,407-411 | sort -u |";

  open(PI,"$hh") or  die " could not open pipe\n";

  while ($boof = <PI>) {
    chomp($boof);

    $date = substr($boof,0,6);
    $switch = substr($boof,6);

    $hh = " grep ^22 $buff | cut -b105-110,213-218,407-411 | grep ^$date | grep $switch | cut -b7-12 | sort -u -r | head -n 1";

    $lastDT = `$hh`; chomp($lastDT);
#    print "$hh\n";
    print " $switch\t $date\t $lastDT\n";

  }

  close(PI);
}

exit(0);


