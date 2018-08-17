#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      WebListenerGuidersRaters.pl
#
# Description: This script will launch the Maf process on the production 
#              machine.  Once the Maf process is launched, we will connect to 
#              the MafMonitor thread and check the status to make sure it was
#              launched successfully.
#
# Returns:     0 - if successful
#              Non Zero if unsuccessful
#
# Author:      David Balchen - 04/05/2002
#
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for APRM 
# Author        : David A Smith
# Date          : Fri Apr 19 11:47:18 CDT 2013
#-------------------------------------------------------------------------------

use FileHandle;
require "Monitor/Monitor.tmpl.pl";

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

`rm -f *.htm`;  #uncommnet for testing .htm

# Set Title
$Title = "Application Status";

# Get Market from STDIN
$Market   =  uc($ENV{'PROJECT_NAME'});  $Market =~ s/ //g;
$PageLink = '<a HREF="http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=WebListenGuideRate&MARKET='.$Market.'" target="GRL'.$Market.'">'.$Market.'</a>'; 

# Get list of APRM applications.
@Stuff = `Monitor/getAprmApps.pl`;

# Display Listener
my $outFile = "ppLsnOut.htm";

open(OUTPUT,">> $outFile") or die "Cannot open output file $outFile.\n";

$HTML =~ s/!MARKET/$Market/g;
$HTML =~ s/!TITLE/$Title/g;
$HTML =~ s/!OUTPUT/$Output/g;
$HTML =~ s/!LINK/$PageLink/g;

print OUTPUT $HTML;

print OUTPUT <<ENDHTML;
<center><table border=1 cellpadding=3>
<tr>
<td align="center"><b><font size=-1>Applications</b></td>
<td align="center"><b><font size=-1>Time</font></b></td>
<td align="center"><b><font size=-1>Status</font></b></td>
</tr>
ENDHTML
  
  $cnt1 = 0;
  $cnt2 = scalar(@Stuff);
  
    while ($cnt1 < $cnt2) {
    	
    	 ($pmg,$time,$status) = split(/!/,@Stuff[$cnt1]);
    
       if ($time ne "-") {
         $fontColor = $fontColor.'<font color="#008040">';
       } else {
         $fontColor = $fontColor.'<font color="#FF0000">';
       }
       
       $outFile = '<tr>
                   <td align="center"><font size="-1">'.$time.'</font></td>
                   <td align="center"><font size="-1">'.$status.'</font></td>
                   <td align="center"><font size="-1">'.$fontColor.''.$pmg.'</font></td>
                   </tr>
                   </center>';
                   
       print OUTPUT $outFile;
         
       $cnt1++;
     }
     
  close(OUTPUT) or die "Unable to close output file $outFile.\n";
  
#  `rm -f *.htm`; #commnet out for testing .htm

exit(0);
