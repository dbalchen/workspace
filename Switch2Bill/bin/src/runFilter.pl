#! /usr/bin/perl

my $filename = $ARGV[0];

$filename =~ s/\///g;
$filename =~ s/^\.//g;

chdir("/m01/switch/wedo/bin");

my $hh = "";


if(index($filename,"gz") >= 0)
{
	$hh = "gunzip ../$filename";
	system ("$hh");
	$filename = substr($filename,0,length($filename)-3);	
}

$hh = "./filter ./mdnList.csv ./minList.csv ../$filename > ../$filename.tmp 2> ../rejected/$filename.err";
system($hh);

$hh = "mv ../$filename.tmp ../$filename";

#system($hh);

exit(0);
