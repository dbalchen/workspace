#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      getAprmApps.pl
#
# Description: This script gets a list APRM applications and retuns it to the
#              calling program.
#
# Returns:     0 - if successful
#              Non Zero if unsuccessful
#
# Author:      David A Smith Fri Apr 19 11:47:18 CDT 2013
#
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for APRM
# Author        : David A Smith
# Date          : Fri Apr 19 11:47:18 CDT 2013
#-------------------------------------------------------------------------------

use FileHandle;

# Flush the buffer to stdout after every command.
STDOUT->autoflush(1);

#my $user = $ENV{'USER'};

#APRM Listener
$hh ="ps -ef | grep 'gprme_classes' | grep -v grep | sed 's/  *//g' | sed 's/  */ /g' | cut -d '.' -f1,28"; #aprmoper3236413201:13?03:40:42/usr/java/jdk1.ListenerBatchProcess
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "Listener";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "Listener";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}  

#APRM Usage Manager
$hh = "ps -ef | grep 'icsmpgum' | grep -v grep | sed 's/  *//g' | sed 's/  */ /g'"; #aprmoper324661101:13?00:10:30icsmpgum
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "Usage Manager";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "Usage Manager";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

#APRM Raters
$hh = "ps -ef | grep 'ICRT' | grep -v grep | sed 's/  *//g' | sed 's/  */ /g' | cut -d ':' -f4 | cut -c 10-17"; #ICRT003ICRT002ICRT001ICRTDEF
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
  while (@stuff) {
      ($Element)=shift(@stuff);
      $Raters = $Raters."Up!$Element!$time";
  }
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
  while (@stuff) {
      ($Element)=shift(@stuff);
      $Raters = $Raters."DOWN!$Element!$time";
  }
}
print $Raters;

exit(0);
