#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      WebSpaceMb.pl
#
# Description:
#
# Returns:     0 - if successful
#              Non Zero if unsuccessful
#
# Author:      David Balchen - 04/05/2002
#
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS
# Author        : Steven M Roehl
# Date          : Mon Jan 27 12:28:09 CDT 2013
#-------------------------------------------------------------------------------

BEGIN {
    push(@INC, "./");
}

use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);


$x = "+\"%D %I:%M:%S%p\"";
chomp $x;
$time = `date $x`;
chomp($time);


my $first=1;

#Get input file
my $config = $ARGV[1];
$config =~ tr/"//d;

$Market = uc($ENV{'_HOST'}); chomp($Market);
my @dirs = getDirs($config);

print "{\"time\": \"$time\",\n\"dirs\":[ ";
foreach $dir (@dirs){
  if($first){
    checkStatus($dir,1);
    $first=0;
  }else{
    checkStatus($dir,0);
  }
}
print "]}\n";

exit(0);


sub getDirs{
  my ($config) = @_;
  my @dirs = ();
  open FH,'<',"$config" or die "systemdirs.config not found: $config\n";
  while(my $line = <FH>){
    chomp($line);
    push(@dirs,$line);
  }
  close FH;
  return @dirs;
}

sub checkStatus {
  my ($dir,$first) = @_;
  my ($map,$size,$used,$avail,$peruse,$dir) = processDf($dir);

  if($first == 0){
    print ",\n";
  }
  print "{\"map\" : \"$dir\", \"size\": \"$size\", \"used\" : \"$used\", \"avail\" : \"$avail\", \"peruse\" : \"$peruse\", \"mount\": \"$map\"}";
}


sub processDf{
  my ($dir) = @_;
  chomp($dir);
  my @result = `df -h $dir`;

  #my $map=$result[1];
  #chomp($map);

  $filesystem_info=$result[1] . $result[2];
  chomp($filesystem);
  my ($map,$size,$used,$avail,$peruse,$mount) = split(" ",$filesystem_info);

  return ($map,$size,$used,$avail,$peruse,$dir);
}

