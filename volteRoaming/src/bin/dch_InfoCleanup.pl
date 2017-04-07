#! /usr/bin/perl

#### Test Only
$ARGV[0] = '/home/dbalchen/Desktop/20170214_differences.csv';

my $tempFile = $ARGV[0].'.tmp';
my $hh = "cat $ARGV[0] | grep '^Charge' >  $tempFile";
system($hh);
$hh =  "cat $ARGV[0] | grep '^Block' >>  $tempFile";
system($hh);
$hh =  "cat $ARGV[0] | grep '^Record' >>  $tempFile";
system($hh);
$hh =  "mv $tempFile $ARGV[0]";
system($hh);

exit(0);
