#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      WebSpaceMb.pl
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
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

BEGIN {
    push(@INC, "./");
}

require "Monitor/Monitor.tmpl.pl";
use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

# Set Title and pageThresh
$Title = "Space Usage";
$pageThresh = 100;


# Get Market from STDIN
$Market = uc($ENV{'PROJECT_NAME'}); chomp($Market);
$PageLink = '<a HREF="http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName=WebSpaceMb&MARKET='.$Market.'" target="SpaceMB'.$Market.'">'.$Market.'</a>';

$Output = '<CENTER><TABLE CELLPADDING=3 ><TR>
          </TR></TABLE></CENTER><CENTER><TABLE BORDER=1 CELLPADDING=3 > <TR> <TD ALIGN="CENTER"><B><FONT SIZE=-1>Filesystem</FONT></B></TD>
               <TD ALIGN="CENTER"><B><FONT SIZE=-1>Total</FONT></B></TD> <TD ALIGN="CENTER"><B><FONT SIZE=-1>Used</FONT></B></TD>
               <TD ALIGN="CENTER"><B><FONT SIZE=-1>Avail</FONT></B></TD> <TD ALIGN="CENTER"><B><FONT SIZE=-1>%Used</FONT></B></TD>
               <TD ALIGN="CENTER"><B><FONT SIZE=-1>Mounted</FONT></B></TD> </TR>';

# Find Disk Space on market machine.
$hh = 'Monitor/CheckSpace.pl';
@stuff = `$hh`;chomp(@stuff);

for ($a = 0; $a < @stuff;$a++) {

    ($filesystem,$kbytes,$used,$avail,$peruse,$mounted) = split(/;/,$stuff[$a]);

    $Output = $Output.'<TR> <TD ALIGN="CENTER"><FONT SIZE=-1>'.$filesystem.'</FONT></TD>
                     <TD ALIGN="CENTER"><FONT SIZE=-1>'.$kbytes.'</FONT></TD> 
                     <TD ALIGN="CENTER"><FONT SIZE=-1>'.$used.'</FONT></TD>
                     <TD ALIGN="CENTER"><FONT SIZE=-1>'.$avail.'</FONT></TD>';

    $per = $peruse;chop($per);
    $per =~ s/ //g;

    if ($per > 40 && $per < 70) {
	$Output = $Output.'<TD ALIGN="CENTER"><FONT COLOR="#FF8040"><FONT SIZE=-1>'.$peruse.'</FONT></FONT></TD>';
    } else {
	if ($per >= 70) {
	    $Output = $Output.'<TD ALIGN="CENTER"><FONT COLOR="#FF0000"><FONT SIZE=-1>'.$peruse.'</FONT></FONT></TD>'; 
	} else {
	    $Output = $Output.'<TD ALIGN="CENTER"><FONT COLOR="#008000"><FONT SIZE=-1>'.$peruse.'</FONT></FONT></TD>'; 
	}
    }
    $Output = $Output.'<TD ALIGN="CENTER"><FONT SIZE=-1>'.$mounted.'</FONT></TD></TR>';
}

$Output = $Output.'</TABLE></CENTER>';

# Print Html
$HTML =~ s/!MARKET/$Market/g;
$HTML =~ s/!TITLE/$Title/g;
$HTML =~ s/!OUTPUT/$Output/g;
$HTML =~ s/!LINK/$PageLink/g;
print STDOUT $HTML;

exit(0);

