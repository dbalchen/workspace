#! /usr/bin/perl

while ($buff = <STDIN>) {
  chomp($buff);
    
  $hh = "latex $buff";
  print "$hh\n";   
  system($hh);

  $prefix = (split(/\./,$buff))[0];
  
  $hh = 'dvips -O -2.0cm,-3.0cm  -y 1400 '."$prefix".'.dvi -o '."$prefix".'.ps';
  system($hh);

}
