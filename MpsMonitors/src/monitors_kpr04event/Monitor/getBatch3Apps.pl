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
# Date:        Fri Jul 12 09:35:48 CDT 2013
#
#-------------------------------------------------------------------------------

use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

$user = $ENV{'USER'};
$user =~ s/ //g;

$hh = "ps -ef | grep '$user' | grep 'AnF_Gatherer' | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f7,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AnF_Gatherer";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AnF_Gatherer";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'CEM' | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f7,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "CEM";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "CEM";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'CUI' | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f7,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "CUI";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "CUI";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'TC_Gatherer' | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f7,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "TC_Gatherer";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "TC_Gatherer";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'TC2_Gatherer' | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f7,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "TC2_Gatherer";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "TC2_Gatherer";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'TC3_Gatherer' | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f7,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "TC3_Gatherer";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "TC3_Gatherer";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep '$user' | grep 'TC4_Gatherer' | grep -v grep | sed 's/^  *//g' | sed 's/  */ /g' | cut -d ' ' -f7,9";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "TC4_Gatherer";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "TC4_Gatherer";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1099' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1100' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1105' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1106' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1107' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1240' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1241' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1242' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1243' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'F2E1244' | grep -v grep";
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
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'NFT1018' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "NFT1018";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "NFT1018";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'NFT1019' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "NFT1019";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "NFT1019";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

$hh = "ps -ef | grep 'AGENT1037' | grep -v grep";
@stuff = `$hh`;
chomp @stuff;
if ( @stuff ) {
	$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AGENT1037";
	  chomp $pgm;
  print "Up!$pgm!$time";
} else {
		$x = "+%I:%M:%S%p";
	  chomp $x;
	$time = `date $x`;
	$pgm  = "AGENT1037";
	  chomp $pgm;
  print "DOWN!$pgm!$time";;
}

exit(0);
