#! /usr/bin/perl

$hh = "latex year.tex";
system($hh);

$hh = 'dvips -O -2.5cm,-2.5cm  -y 1400 year.dvi  -o Year.ps';
system($hh);

$hh = "rm -fr year.*";
system($hh);
