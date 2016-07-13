#!/usr/bin/perl
      
#$fileName = $ARGV[0];
#open(FILE,$fileName);
#while(<fileData>){
while(<STDIN>){
   $_ =~ s/(\r|\n)+//gi;
   @parts=split(/\,/);
   $bytesin=$parts[0];
   $bytesout=$parts[1];
   $dt=substr($parts[2],0,8);
   $bsid=substr($parts[3],0,11);
   #print STDOUT "$_\n";
   #print STDOUT "\t$bytesin, $bytesout, $dt,$bsid\n";
   $key=$dt.$bsid;
   $countarr{$key} = $countarr{$key} + 1;
   $bytearr{$key} = $bytearr{$key} + $bytesin + $bytesout;
   $keyarr{$key} = $key;
}
     
#foreach $key (sort {$keyarr{$b} >= $arrText{$a}} keys %keyarr){
foreach $key ( keys %keyarr){
   $dt=substr($key,0,8);
   $bsid=substr($key,8,11);
   print STDOUT "$dt,$bsid,$countarr{$key},$bytearr{$key}\n";
#   print $key.",".$ARGV[0].",".$arrText{$key}."\n";
}
     
exit;

