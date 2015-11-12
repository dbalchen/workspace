#!/opt/perl5/bin/perl

BEGIN {
    push(@INC, "./");
}

require "Monitor/Monitor.tmpl.pl";
use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush(1);

# Set Title and pageThresh

$Title = "Space and Missing Blocks";

$pageThresh = 100;


# Get Market from STDIN

$Market = uc($ENV{'TLG_MARKET'}); chomp($Market);
$PageLink = '<a HREF="http://chi1pas1.uscc.com:8082/WebMonitor/servlet/WebMonitor?MonName=WebSpaceMb&MARKET='.$Market.'" target="SpaceMB'.$Market.'">'.$Market.'</a>';

$Output = '<CENTER><TABLE CELLPADDING=3 ><TR><TD ALIGN="CENTER"><B><FONT COLOR="#FF0000">SPACE</FONT></B></TD>
          </TR></TABLE></CENTER><CENTER><TABLE BORDER=1 CELLPADDING=3 > <TR> <TD ALIGN="CENTER"><B><FONT SIZE=-1>Filesystem</FONT></B></TD>
               <TD ALIGN="CENTER"><B><FONT SIZE=-1>kbytes</FONT></B></TD> <TD ALIGN="CENTER"><B><FONT SIZE=-1>used</FONT></B></TD>
               <TD ALIGN="CENTER"><B><FONT SIZE=-1>avail</FONT></B></TD> <TD ALIGN="CENTER"><B><FONT SIZE=-1>%used</FONT></B></TD>
               <TD ALIGN="CENTER"><B><FONT SIZE=-1>Mounted on</FONT></B></TD> </TR>';

# Find Disk Space on market machine.

$hh = 'Monitor/CheckSpace'.$Market.'.pl';
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

$Output = $Output.' </TABLE></CENTER> <P> <HR WIDTH="100%"></P> <CENTER><TABLE CELLPADDING=3 >
                    <TR> <TD ALIGN="CENTER"><B><FONT COLOR="#FF0000">Missing Blocks</FONT></B></TD>
                    </TR> </TABLE></CENTER> <CENTER><TABLE BORDER=1 CELLPADDING=3 >
                    <TR> <TD ALIGN="CENTER"><B><FONT SIZE=-1>Switch</FONT></B></TD>
                    <TD ALIGN="CENTER"><B><FONT SIZE=-1>From </FONT></B></TD>
                    <TD ALIGN="CENTER"><B><FONT SIZE=-1>To</FONT></B></TD>
                    <TD ALIGN="CENTER"><B><FONT SIZE=-1>Comment</FONT></B></TD> </TR>';


$hh = 'Monitor/MissingBlock.pl  sql_query "missing_block.sql" to_hrs_ago "1" SqlLib "sql/" market "'.uc($Market).'" threshold "100" from_hrs_ago "72" Log "log/" switch_query "voice_switches.sql" title "MissingBlock" MpsLib ""';

@stuff = `$hh`;chomp(@stuff);

for($a = 0; $a < @stuff; $a++)
    {
      if(index($stuff[$a],"switch:",0) > -1)
	  {
            ($toss,$switch) = split(/:/,$stuff[$a]);$a++;
            ($toss,$blockDiff) = split(/:/,$stuff[$a]);$a++;
            ($toss,$startend) = split(/:/,$stuff[$a]);
            ($startBlock,$endBlock) = split(/->/,$startend);

            $addText = '<FONT COLOR="#FF0000">'."There are $blockDiff Blocks missing Please Investigate"."</FONT>";
            $Output = $Output.'<TR> <TD ALIGN="CENTER"><FONT SIZE=-1>'.$switch.
		'</FONT></TD> <TD ALIGN="CENTER"><FONT SIZE=-1>'.$startBlock.'</FONT></TD><TD ALIGN="CENTER"><FONT SIZE=-1>'
	       .$endBlock.'</FONT></TD> <TD ALIGN="CENTER"><FONT SIZE=-1>'.$addText.'</FONT></TD></TR>';
	  }
          else {
             $Output = $Output.'<TR> <TD ALIGN="CENTER"><FONT SIZE=-1>Nothing To Report</FONT></TD></TR>';
          }
    }



$Output = $Output.'</TABLE></CENTER>';
# Print Html

$HTML =~ s/!MARKET/$Market/g;
$HTML =~ s/!TITLE/$Title/g;
$HTML =~ s/!OUTPUT/$Output/g;
$HTML =~ s/!LINK/$PageLink/g;
print STDOUT $HTML;


exit(0);

