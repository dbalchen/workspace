#! /usr/bin/perl

while ($buff = <STDIN>) {
  chomp($buff);
    
  $hh = $hh." $buff /home/dbalchen/workspace/CommonPlace/templates/GraphPaper.pdf";

}



#$hh = "psmerge $hh | psnup -2 -m 0 -p letter > MonthYear.ps";
$hh = "pdfunite  $hh  MonthYear.pdf";
print "$hh\n";

system($hh);
