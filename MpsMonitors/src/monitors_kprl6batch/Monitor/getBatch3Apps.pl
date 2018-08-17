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

$hh = "ps -ef | grep '$user' | grep F2E1024 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1024";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1024";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1025 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1025";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1025";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1043 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1043";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1043";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1075 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1075";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1075";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1085 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1085";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1085";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1090 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1090";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1090";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1092 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1092";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1092";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1093 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1093";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1093";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1094 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1094";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1094";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

$hh = "ps -ef | grep '$user' | grep F2E1095 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1095";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "F2E1095";
	  chomp $pgm;
  print "DOWN!$pgm!$time";
}

exit(0);
