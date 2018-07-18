#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      getBatch3Apps.pl
#
# Description: Created for TOPS.  This script gets a list of Lisnters and retuns
#              it the the calling program.
#
# Returns:     0 - if successful
#              Non Zero if unsuccessful
#
# Author:      David A Smith
#
# Date:        Tue Jul  2 14:45:52 CDT 2013
#
#-------------------------------------------------------------------------------

use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

$user = $ENV{'USER'};
$user =~ s/ //g;

$hh = "ps -ef | grep '$user' | grep F2E1284 | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1284";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1284";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1283 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1283";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1283";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1107 |  grep -v grep |sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1107";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1107";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1286 |  grep -v grep |sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1286";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1286";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1285 | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1285";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1285";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1244 | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1244";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1244";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1243 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1243";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1243";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1241 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1241";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1241";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1282 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1282";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1282";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1242 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1242";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1242";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1106 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1106";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1106";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1240 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1240";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1240";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1105 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1105";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1105";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1100 |  grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1100";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1100";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1099 | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1099";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1099";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}



exit(0);
