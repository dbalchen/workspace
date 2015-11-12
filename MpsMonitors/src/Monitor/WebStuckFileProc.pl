#!/opt/perl5/bin/perl

BEGIN {
   push(@INC, "./");
}

require 5.004;
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
  $market = uc($ENV{'TLG_MARKET'});chomp($market);

$PageLink = '<a HREF="http://chi1pas1.uscc.com:8082/WebMonitor/servlet/WebMonitor?MonName=WebStuckFileProc&MARKET='.$market.'" target="USAGE'.$market.'">'.
$market.'</a>';

# Get a new SWITCHBEHIND object

if ($market eq "M06")
{
	$hh = 'Monitor/SwitchBehind.pl  sql_query "switch_behindNonCBB.sql" ignore_list "'.$ignoreList.'" SqlLib "sql/" market "'.uc($market).'" threshold "8" Log "log/" title "SwitchBehindNonCBB" MpsLib ""';

	@stuff = `$hh`;chomp(@stuff);

	$FirstCol = '<CENTER><TABLE CELLPADDING=3 >'.'<TR><TD ALIGN="LEFT"><B>Switch Behind</B></TD>';

	if (index($stuff[0],"Nothing",0) < 0)
	{
		for($i=0;$i<@stuff;$i++)
		{
			($switch,$toss,$maxdate,$minute,$second) = split(/:/,$stuff[$i]);
			$maxdate = $maxdate.":$minute:$second";

			$Output = $Output. $FirstCol.'<TD ALIGN="LEFT">'."Switch Behind in Data: $switch Last File: $maxdate".'</B></TD></TR>';
			$FirstCol = '<TR><TD ALIGN="LEFT">&nbsp;</TD>';
		}
	}
	else
	{
		$Output =  '<CENTER><TABLE CELLPADDING=3 >'.'<TR><TD ALIGN="LEFT"><B>Switch Behind</B></TD>';
		$Output = $Output.'<TD ALIGN="LEFT">'."No Switches are Behind".'</B></TD></TR>';
	}

	$hh = 'Monitor/SwitchBehind.pl  sql_query "switch_behindCBB.sql" ignore_list "'.$ignoreList.'" SqlLib "sql/" market "'.uc($market).'" threshold "14" Log "log/" title "SwitchBehindCBB" MpsLib ""';

	@stuff = `$hh`;chomp(@stuff);

	$FirstCol = '<CENTER><TABLE CELLPADDING=3 >'.'<TR><TD ALIGN="LEFT"><B>CBB Switch Behind</B></TD>';

	if (index($stuff[0],"Nothing",0) < 0)
	{
		for($i=0;$i<@stuff;$i++)
		{
			($switch,$toss,$maxdate,$minute,$second) = split(/:/,$stuff[$i]);
			$maxdate = $maxdate.":$minute:$second";

			$Output6 = $Output6. $FirstCol.'<TD ALIGN="LEFT">'."Switch Behind in Data: $switch Last File: $maxdate".'</B></TD></TR>';
			$FirstCol = '<TR><TD ALIGN="LEFT">&nbsp;</TD>';
		}
	}
	else
	{
		$Output6 =  '<CENTER><TABLE CELLPADDING=3 >'.'<TR><TD ALIGN="LEFT"><B>CBB Switch Behind</B></TD>';
		$Output6 = $Output6.'<TD ALIGN="LEFT">'."No CBB Switches are Behind".'</B></TD></TR>';
	}
}

if ($market ne "M06")
{
	$hh = 'Monitor/SwitchBehind.pl  sql_query "switch_behind.sql" ignore_list "'.$ignoreList.'" SqlLib "sql/" market "'.uc($market).'" threshold "8" Log "log/" title "SwitchBehind" MpsLib ""';

	@stuff = `$hh`;chomp(@stuff);

	$FirstCol = '<CENTER><TABLE CELLPADDING=3 >'.'<TR><TD ALIGN="LEFT"><B>Switch Behind</B></TD>';

	if (index($stuff[0],"Nothing",0) < 0)
	{
		for($i=0;$i<@stuff;$i++)
		{
			($switch,$toss,$maxdate,$minute,$second) = split(/:/,$stuff[$i]);
			$maxdate = $maxdate.":$minute:$second";

			$Output = $Output. $FirstCol.'<TD ALIGN="LEFT">'."Switch Behind in Data: $switch Last File: $maxdate".'</B></TD></TR>';
			$FirstCol = '<TR><TD ALIGN="LEFT">&nbsp;</TD>';
		}
	}
	else
	{
		$Output =  '<CENTER><TABLE CELLPADDING=3 >'.'<TR><TD ALIGN="LEFT"><B>Switch Behind</B></TD>';
		$Output = $Output.'<TD ALIGN="LEFT">'."No Switches are Behind".'</B></TD></TR>';
	}
}

#  Get a new Stuck in use monitor

   $hh = 'Monitor/StuckFile.pl  sql_query "stuck_file.sql" SqlLib "sql/" market "'.$market.'" threshold "4" Log "log/" title "StuckFile" MpsLib ""';

   @stuff = `$hh`;chomp(@stuff);

   $FirstCol = '<TR><TD ALIGN="LEFT"><B>Files Stuck</B></TD>';

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
      $Output = $Output.$FirstCol.'<TD ALIGN="LEFT">'."File Stuck In-Use: $market :: File Stuck -> $filestuck : Stuck In -> $prog : Stuck Since -> $filedate";
      $FirstCol = '<TR><TD ALIGN="LEFT">&nbsp;</TD>';
     }
    }
   }
   else
   {
     $Output = $Output.'<TR><TD ALIGN="LEFT"><B>Files Stuck</B></TD>';
     $Output = $Output.'<TD ALIGN="LEFT">'."No Files Stuck In Use".'</B></TD></TR>';
   }



#  Get a new Behind Processing Monitor

   $hh = 'Monitor/ProgramBehind.pl  sql_query "program_behind.sql" SqlLib "sql/" market "'.$market.'" threshold "1400000" Log "log/" title "ProgramBehind" MpsLib ""';

   @stuff = `$hh`;chomp(@stuff);

#  Look for progs behind in processing

   $FirstCol = '<TR><TD ALIGN="LEFT"><B>Behind Process</B></TD>';

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
      $FirstCol = '<TR><TD ALIGN="LEFT">&nbsp;</TD>';
      $Output = $Output.'<TD ALIGN="LEFT">'."Program Behind in Processing: $market :: Program -> $prog : File Status -> $filestatus : File Count -> $filecount : Record Count -> $recordcount".'</TD></TR>';
     }
    }
   }
   else 
   {
     $Output = $Output.$FirstCol;
     $Output = $Output.'<TD ALIGN="LEFT">'."No Programs behind in processing".'</B></TD></TR>';
   } 


# Print Html

   $Output = $Output.'</TABLE></CENTER>';
   $HTML =~ s/!MARKET/$Market/g;
   $HTML =~ s/!TITLE/$Title/g;
   $HTML =~ s/!OUTPUT/$Output/g;
   $HTML =~ s/!LINK/$PageLink/g;
   print STDOUT $HTML;
   
if ($market eq "M06")
{
	$Output6 = $Output6.'</TABLE></CENTER>';
	$HTML6 =~ s/!OUTPUT6/$Output6/g;
	$HTML6 =~ s/!LINK/$PageLink/g;
	print STDOUT $HTML6;
}

exit(0);
