#!/usr/bin/perl

$instance="AAA";
$unit_type="B";
while(<STDIN>){
   $_ =~ s/(\r|\n)+//gi;
   @parts=split(/\,/);
   $bytesin=$parts[0];
   $bytesout=$parts[1];
   $dt=substr($parts[2],0,8);
   $bsid=substr($parts[3],0,11);
   $protocol=$parts[4];
   $protocol=~s/33/2G/g;
   $protocol=~s/59/3G/g;
   $key=$dt.$bsid.$protocol;
   $countarr{$key} = $countarr{$key} + 1;
   $bytearr{$key} = $bytearr{$key} + $bytesin + $bytesout;
   $keyarr{$key} = $key;
}
     
foreach $key ( keys %keyarr){
   $dt=substr($key,0,8);
   $bsid=substr($key,8,11);
   $protocol=substr($key,19,2);
   print STDOUT "$dt,$protocol,$bsid,$instance,$countarr{$key},$unit_type,$bytearr{$key}\n";
}
     
exit;

