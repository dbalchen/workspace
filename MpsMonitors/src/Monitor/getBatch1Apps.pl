#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      getBatch1Apps.pl
#
# Description: Created for TOPS.  This script gets a list of Lisnters and retuns
#              it the the calling program.
#
# Returns:     0 - if successful
#              Non Zero if unsuccessful
#
# Author:      David A Smith
#
# Date:        Thu Aug  2 10:49:19 CDT 2012
#
#-------------------------------------------------------------------------------

use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

$user = $ENV{'USER'};
$user =~ s/ //g;

$hh = "ps -ef | grep '$user' | grep MF1ppLSN | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "Listener";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "Listener DOWN!-";
}

$hh = "ps -ef | grep '$user' | grep Ac1FtcManager | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "Ac1FtcManager";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "Ac1FtcManager DOWN!-";
}

$hh = "ps -ef | grep '$user' | grep AGENT1012 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AGENT1012";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "AGENT1012 DOWN!-";
}


$hh = "ps -ef | grep '$user' | grep AR1PYMRCT | sed 's/^  *//g' | sed 's/  */ /g' | egrep -v '_0|server'|cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AR1PYMRCT";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "AR1PYMRCT DOWN!-";
}


$hh = "ps -ef | grep '$user' | grep AR1DDREQCRE  | sed 's/^  *//g' | sed 's/  */ /g' | egrep -v '_0|server'| cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AR1DDREQCRE";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "AR1DDREQCRE DOWN!-";
}

$hh = "ps -ef | grep '$user' | grep AR3GWLSTR  | sed 's/^  *//g' | sed 's/  */ /g' | egrep -v '_0|server' |cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AR3GWLSTR";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "AR3GWLSTR DOWN!-";
}

$hh = "ps -ef | grep '$user' | grep AR1PYMPOST  | sed 's/^  *//g' | sed 's/  */ /g' | egrep -v '_0|server' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AR1PYMPOST";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "AR1PYMPOST DOWN!-";
}


$hh = "ps -ef | grep '$user' | grep AR1DDFEDBCK  | sed 's/^  *//g' | sed 's/  */ /g' | egrep -v '_0|server' |cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AR1DDFEDBCK";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "AR1DDFEDBCK DOWN!-";
}


$hh = "ps -ef | grep '$user' | grep AR1INVRCT  | sed 's/^  *//g' | sed 's/  */ /g' | egrep -v '_0|server'| cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ne "" ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AR1INVRCT";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "AR1INVRCT DOWN!-";
}

exit(0);
