#! /usr/bin/perl

$hh = "latex month.tex";
system($hh);

$hh = 'dvips -O 2cm,2cm  -y 850 month.dvi -o Month.ps';
system($hh);

$hh = "rm -fr month.*";
system($hh);

