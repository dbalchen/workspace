#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      getListener.pl
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

$hh = "ps -ef | grep '$user' | grep 'MF1ppSPL' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppSPL";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppSPL";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'MF1ppSPL1' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppSPL1";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppSPL1";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'MF1ppLSN INSTANCE=LSN FILE' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppLSN";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppLSN";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'LSN_NTI1' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_NTI1";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_NTI1";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'LSN_NTI2' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_NTI2";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_NTI2";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'LSN_APLX' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_APLX";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_APLX";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'LSN_AAA' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_AAA";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_AAA";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'LSN_SMS_MMS' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_SMS_MMS";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_SMS_MMS";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'LSN_CONT' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_CONT";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_CONT";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'LSN_LTE' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_LTE";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "LSN_LTE";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep Ac1FtcManager | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "Ac1FtcManager";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "Ac1FtcManager";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep AGENT1012 | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,8";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AGENT1012";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AGENT1012";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

exit(0);
