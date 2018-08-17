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

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD1' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD1";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD1";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD2' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD2";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD2";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD3' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD3";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD3";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD4' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD4";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD4";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD5' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD5";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD5";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD6' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD6";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD6";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD7' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD7";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD7";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD8' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD8";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD8";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD9' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD9";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD9 DOWN!-";
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD10' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD10";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD10 DOWN!-";
}

$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD11' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD11";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD11 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD12' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD12";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD12 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD13' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD13";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD13 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD14' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD14";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD14 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD15' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD15";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD15 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD16' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD16";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD16 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD17' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD17";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD17 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD18' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD18";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD18 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD19' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD19";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD19 DOWN!-";
}
$hh = "ps -ef | grep '$user' | grep 'INSTANCE=MD20' | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f5,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "MF1ppMD20";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
	print "MF1ppMD20 DOWN!-";
}

exit(0);
