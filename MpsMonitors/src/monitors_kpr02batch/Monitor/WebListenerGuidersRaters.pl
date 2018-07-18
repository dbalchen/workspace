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
# Revision      : PR270997 Hello
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Tue Jun 11 11:05:09 CDT 2013
#-------------------------------------------------------------------------------

use FileHandle;
require "Monitor/Monitor.tmpl.pl";

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

#`rm -f *.htm`;  #uncommnet for testing .htm

# Set Title
$Title = "Application Status";

# Get Market from STDIN
$Market   =  uc($ENV{'_HOST'});  $Market =~ s/ //g;
$PageLink = '<a HREF="http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=WebListenGuideRate&MARKET='.$Market.'" target="GRL'.$Market.'">'.$Market.'</a>'; 

# Get list of BATCH2 applications.
@Stuff = `Monitor/getBatch2Apps.pl`;

# Display Listener
#my $outFile = "ppLsnOut.htm";

#open(OUTPUT,">> $outFile") or die "Cannot open STDOUT file $outFile.\n";

$HTML =~ s/!MARKET/$Market/g;
$HTML =~ s/!TITLE/$Title/g;
$HTML =~ s/!OUTPUT/$STDOUT/g;
$HTML =~ s/!LINK/$PageLink/g;

print STDOUT $HTML;

print STDOUT <<ENDHTML;
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
    
       if ($status ne "DOWN") {
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
                   
       print STDOUT $outFile;
         
       $cnt1++;
     }
     
#  close(OUTPUT) or die "Unable to close STDOUT file $outFile.\n";
  
#  `rm -f *.htm`; #commnet out for testing .htm

exit(0);
