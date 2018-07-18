#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      getEvent1Apps.pl
#
# Description: Created for TOPS.  This script gets a list of Lisnters and retuns
#              it the the calling program.
#
# Returns:     0 - if successful
#              Non Zero if unsuccessful
#
# Author:      David A Smith
#
# Date:        Fri Jul 12 09:35:48 CDT 2013
#
#-------------------------------------------------------------------------------

use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

$user = $ENV{'USER'};
$user =~ s/ //g;

$hh = "ps -ef | grep '$user' | grep 'ES1008' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1008";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1008";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'ES1009' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1009";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1009";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'ES1039' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1039";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1039";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'ES1150' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1150";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1150";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'ES1167' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1167";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1167";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'ES1168' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1168";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "ES1168";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'RRP_OG1010' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "RRP_OG1010";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "RRP_OG1010";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'RRP_OG1158' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "RRP_OG1158";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "RRP_OG1158";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'UQ_SERVER1027' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "UQ_SERVER1027";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "UQ_SERVER1027";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

exit(0);
