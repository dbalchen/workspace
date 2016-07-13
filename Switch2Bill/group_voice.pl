#!/usr/bin/perl

use POSIX qw(ceil);

$unit_type="M";
while(<STDIN>){
   $_ =~ s/(\r|\n)+//gi;
   @parts=split(/\|/);
   $instance=uc($parts[0]);
   $dt=$parts[1];
   $cell=$parts[2];
   $protocol="CS";
   $duration=($parts[3] + $parts[4])/60;
   $mins=ceil($duration);
   $key=$dt.$instance.$cell;
   $countarr{$key} = $countarr{$key} + 1;
   $bytearr{$key} = $bytearr{$key} + $mins;
   $keyarr{$key} = $key;
}
     
#foreach $key (sort {$keyarr{$b} >= $arrText{$a}} keys %keyarr){
foreach $key ( keys %keyarr){
   $dt=substr($key,0,8);
   $instance=substr($key,8,4);
   $cell=substr($key,12,4);
   print STDOUT "$dt,$protocol,$cell,$instance,$countarr{$key},$unit_type,$bytearr{$key}\n";
}
     
exit;

