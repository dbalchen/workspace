#! /usr/bin/perl

#### Test Only
$ARGV[1] = 'CIBER_CIBER_20170115144213_3036793_0002.dat.done';
$ARGV[0] = '20170115';

my $date = $ARGV[0];
my $short_date = substr($date,2);

my $file = $ARGV[1];

my $process_date = substr($date,0,4).'-'.substr($date,4,2).'-'.substr($date,6,2);

$hh = "cat $file ".'|'." grep '^98' ".'|'." sort -u ".'|'." grep '^98".$short_date."' ".'|';

open(PIPE,$hh) or exit(1);

while(my $buff = <PIPE>)
{
    chomp($buff);

    print substr($buff,16,5)."\t".substr($buff,11,5)."\t".substr($buff,8,3)."\t".substr($buff,21,5)."\t".substr($buff,25,12)."\t".substr($buff,2,6)."\n";
}

#$hh = 'cat Outcollects_Jan15_20.csv | grep '2017-01-15' | more

exit(0);
