#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      WebStuckFileProc.pl
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
# Author        : David A Smith
# Date          : Tue Jun 11 11:05:09 CDT 2013
#-------------------------------------------------------------------------------

BEGIN {
   push(@INC, "./");
}

use FileHandle;

require "Monitor/Monitor.tmpl.pl";

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

for ($a = 0; $a < @ARGV; $a++) {
	$ARGV[$a] =~ s/^"//g; $ARGV[$a] =~ s/"$//g;
}

chomp(@ARGV);
$ignoreList = $ARGV[1];

# Set Title
$Title = "Stuck Files and Processes";
  
#Get Environment Variables.
$market = uc($ENV{'_HOST'});chomp($market);

$PageLink = '<a HREF="http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=WebStuckFileProc&MARKET='.$market.'" target="USAGE'.$market.'">'.
$market.'</a>';

#  Get a new Stuck in use monitor
   $hh = 'Monitor/StuckFile.pl  sql_query "stuck_file.sql" SqlLib "/pkgbl01/inf/aimsys/prdwrk1/eps/monitors/sql/" market "'.$market.'" threshold "4" Log "/pkgbl01/inf/aimsys/prdwrk1/eps/monitors/log/" title "StuckFile" MpsLib "/pkgbl01/inf/aimsys/prdwrk1/eps/monitors/" op_job "" op_sid "prdaf" op_user "prdafc" op_pass "con8af8"';

   @stuff = `$hh`;chomp(@stuff);

   $FirstCol = '<TABLE><CENTER><TR><TD ALIGN="LEFT"><B>Files Stuck</B></TD>';

  if (index($stuff[0],"Nothing",0) < 0) 
  {
   for($i=0;$i<@stuff;$i++) 
   {

      $stuff[$i] =~ s/  *//g;
      if($stuff[$i] ne "")
      {                  
      ($toss,$filestuck) = split(/:/,$stuff[$i]);$i++;
       $filestuck =~ s/  *//g;

      ($toss,$prog) = split(/:/,$stuff[$i]);$i++;
      $prog =~ s/  *//g;
      ($toss,$filedate,$min,$sec) = split(/:/,$stuff[$i]);
      $filedate = $filedate.":$min:$sec";
      $filedate =~ s/^  *//g;
      $Output = $Output.$FirstCol.'<TABLE><CENTER><TD ALIGN="LEFT">'."File Stuck In-Use: $market :: File Stuck -> $filestuck : Stuck In -> $prog : Stuck Since -> $filedate";
      $FirstCol = '<TABLE><CENTER><TR><TD ALIGN="LEFT">&nbsp;</TD>';
     }
    }
   }
   else
   {
     $Output = $Output.'<TABLE><CENTER><TABLE><CENTER><TR><TD ALIGN="LEFT"><B>Files Stuck</B></TD>';
     $Output = $Output.'<TABLE><CENTER><TD ALIGN="LEFT">'."No Files Stuck In Use".'</B></TD></TR>';
   }

#  Get a new Behind Processing Monitor
   $hh = 'Monitor/ProgramBehind.pl  sql_query "program_behind.sql" SqlLib "/pkgbl01/inf/aimsys/prdwrk1/eps/monitors/sql/" market "'.$market.'" threshold "1400000" Log "/pkgbl01/inf/aimsys/prdwrk1/eps/monitors/log/" title "ProgramBehind" MpsLib "/pkgbl01/inf/aimsys/prdwrk1/eps/monitors/" op_job "" op_sid "prdaf" op_user "prdafc" op_pass "con8af8"';

   @stuff = `$hh`;chomp(@stuff);

#  Look for progs behind in processing
   $FirstCol = '<TABLE><CENTER><TR><TD ALIGN="LEFT"><B>Behind Process</B></TD>';

  if (index($stuff[0],"Nothing",0) < 0) 
  {
   for($i=0;$i<@stuff;$i++) 
   {
     $stuff[$i] =~ s/^  *//g;
     if($stuff[$i] ne "")
     {
      ($toss,$prog) = split(/:/,$stuff[$i]);$i++;
      $prog =~ s/  *//g;
      ($toss,$filestatus) = split(/:/,$stuff[$i]);$i++;
      $filestatus =~ s/  *//g;
      ($toss,$filecount) = split(/:/,$stuff[$i]);$i++;
      $filecount =~ s/  *//g;  
      ($toss,$recordcount) = split(/:/,$stuff[$i]);
      $recordcount =~ s/  *//g;
      $Output = $Output.$FirstCol;
      $FirstCol = '<TABLE><CENTER><TR><TD ALIGN="LEFT">&nbsp;</TD>';
      $Output = $Output.'<TABLE><CENTER><TD ALIGN="LEFT">'."Program Behind in Processing: $market :: Program -> $prog : File Status -> $filestatus : File Count -> $filecount : Record Count -> $recordcount".'</TD></TR>';
     }
    }
   }
   else 
   {
     $Output = $Output.$FirstCol;
     $Output = $Output.'<TABLE><CENTER><TD ALIGN="LEFT">'."No Programs behind in processing".'</B></TD></TR>';
   } 

# Print Html

   $Output = $Output.'</TABLE></CENTER>';
   $HTML =~ s/!MARKET/$Market/g;
   $HTML =~ s/!TITLE/$Title/g;
   $HTML =~ s/!OUTPUT/$Output/g;
   $HTML =~ s/!LINK/$PageLink/g;
   print STDOUT $HTML;
   
exit(0);
