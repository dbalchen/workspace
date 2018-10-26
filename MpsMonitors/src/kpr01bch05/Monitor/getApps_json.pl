#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Script:      getEventApps_json.pl
#
# Description: Created for TOPS. This script pulls in the config file and will then
#               get the status of all the  monitored apps
#
# Author:      Steve M Roehl
#
# Date:        Mon Feb 10 15:06:48 CDT 2014
#
#-------------------------------------------------------------------------------

use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush();

$user = $ENV{'USER'};
$user =~ s/ //g;

$x = "+\"%D %I:%M:%S%p\"";
chomp $x;
$time = `date $x`;
chomp($time);
my $first=1;
my $config = $ARGV[1];
$config =~ tr/"//d;

my @apps=getApps($config);

print "{\"time\": \"$time\",\n\"apps\":[ ";
foreach $app (@apps){
  if($first){
    checkStatus($app,1);
    $first=0;
  }else{
    checkStatus($app,0);
  }
}
print "]}\n";


sub getApps {
  my ($config) = @_;
  my @apps=();
  open FH,'<',"$config" or die "apps.config not found: $config!\n";
  while(my $line = <FH>){
    chomp $line;
    push(@apps,$line);
  }
  close FH;
  return @apps;
}


sub checkStatus {
  my ($pgm,$first) = @_;
  chomp $pgm;
  @pgm_vals=split(' ',$pgm);
  if((scalar @pgm_vals == 1) or ($pgm_vals[1] eq 'N' or $pgm_vals[1] eq 'Y')){
    $pgm_vals[2]=$pgm_vals[1];
    $pgm_vals[1]=$pgm_vals[0];
  }
  my $hh;
if(substr($pgm_vals[0],0,3) eq 'F2E'){
  $hh = "ps -ef | grep 'gcpf1fwcApp -p' |grep '$pgm_vals[0]' | grep -v grep";
}else{
  $hh = "ps -ef | grep '$pgm_vals[0]' | grep -v grep";
}

@stuff = split(" ",`$hh`);
chomp @stuff;
if($first == 0){
  print ",\n";
}
if ( @stuff ) {
  print "{\"name\" : \"$pgm_vals[1]\",\"status\": \"Up\", \"start\":\"" . $stuff[4] . "\"}";
} else {
  print "{\"name\" : \"$pgm_vals[1]\",\"status\": \"Down\",\"required\":\"$pgm_vals[2]\"}";
}
}




exit(0);
