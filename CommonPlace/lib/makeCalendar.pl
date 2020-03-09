#! /usr/bin/perl

while ($buff = <STDIN>) {
  chomp($buff);
    
  $hh = $hh." $buff /home/dbalchen/workspace/CommonPlace/templates/GraphPaper.ps";

}



#$hh = "psmerge $hh | psnup -2 -m 0 -p letter > MonthYear.ps";
$hh = "psmerge $hh > MonthYear.ps";
print "$hh\n";

system($hh);
