#! /usr/bin/perl


while ($buff = <STDIN>) {
  chomp($buff);
    
  $hh = "latex $buff";
  print "$hh\n";   
  system($hh);

  $prefix = (split(/\./,$buff))[0];
    
  $hh = 'dvips -O 2cm,2cm  -y 850 '."$prefix".'.dvi -o '."$prefix".'.ps';

  print "$hh\n";
  system($hh);
}


