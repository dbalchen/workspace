#!/usr/local/bin/perl
#----------------------------------------------------------------------------
# Script:      acpa2.pl
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
# Revision      : TBD
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

BEGIN {
   push(@INC, "./");
}

require "Monitor/db_utils_pl";
require "Monitor/mps_utils_pl";
require "Monitor/Monitor.tmpl.pl";
use FileHandle;
use IO::Socket;
use USCDB;

# Flush buffer after every write.
STDOUT->autoflush(1);

# Get Environment Variables.
$Market   =  uc($ENV{'PROJECT_NAME'});  $Market =~ s/ //g;
$PageLink = '<a HREF="http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor?MonName='.$Market.'" target="GRL'.$Market.'">'.$Market.'</a>'; 

$HTML =~ s/!MARKET/$Market/g;
$HTML =~ s/!TITLE/$Title/g;
$HTML =~ s/!OUTPUT/$STDOUT/g;
$HTML =~ s/!LINK/$PageLink/g;

print STDOUT $HTML;

$DataBaseHost = "prdaprm";
$DBuser = "prdappc";
$DBpass = "Con5app5";
$DBenv = $DBuser.'/'.$DBpass.'@'.$DataBaseHost;

#$SQLPLUS = $ENV{'ORACLE_HOME'};
my $SQLPLUS = "/u01/app/oracle/product/11.2.0.3/client64/";
chomp($SQLPLUS);
$SQLPLUS = "$SQLPLUS/bin/sqlplus";

$hh = "$SQLPLUS -s $DBenv << !!
set heading off
set FEEDBACK off
COLUMN PGM  FORMAT A15
COLUMN STT  FORMAT A2
COLUMN CNT  FORMAT 99,999
COLUMN QTY  FORMAT 9,999,999

SELECT decode (nxt_pgm_name, 'ICLISTENER','LSN01','ICUSGMGR','MGR01','ICRATER','RTR01','UPRTUSAGE','UPT01', nxt_pgm_name), file_status as STT, count(*) as CNT, sum(wr_rec_quantity) as QTY 
FROM ac_control_01
WHERE nxt_pgm_name in ('ICLISTENER','ICUSGMGR','ICRATER','UPRTUSAGE')
HAVING sum(wr_rec_quantity) > 0
GROUP BY nxt_pgm_name, file_status
UNION
SELECT decode (nxt_pgm_name, 'ICLISTENER','LSN02','ICUSGMGR','MGR02','ICRATER','RTR02','UPRTUSAGE','UPT02', nxt_pgm_name), file_status as STT, count(*) as CNT, sum(wr_rec_quantity) as QTY 
FROM ac_control_02
WHERE nxt_pgm_name in ('ICLISTENER','ICUSGMGR','ICRATER','UPRTUSAGE')
HAVING sum(wr_rec_quantity) > 0
GROUP BY nxt_pgm_name, file_status
UNION
SELECT decode (nxt_pgm_name, 'ICLISTENER','LSN03','ICUSGMGR','MGR03','ICRATER','RTR03','UPRTUSAGE','UPT03', nxt_pgm_name), file_status as STT, count(*) as CNT, sum(wr_rec_quantity) as QTY 
FROM ac_control_03
WHERE nxt_pgm_name in ('ICLISTENER','ICUSGMGR','ICRATER','UPRTUSAGE')
HAVING sum(wr_rec_quantity) > 0
GROUP BY nxt_pgm_name, file_status;
exit;
!!";

@stuff = `$hh`;
chomp(@stuff);
print '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="refresh" CONTENT="180">
<META NAME="GENERATOR" CONTENT="Mozilla/3.01Gold (Win95; I) [Netscape]">
</HEAD>
<BODY>

<CENTER>
<FORM action="http://kpr01scdap.uscc.com:8080/WebMonitor/servlet/WebMonitor" METHOD="GET" ></P> ';
print '<TABLE BORDER=1 CELLPADDING=3 >'."\n";
print '<TR>'."\n";
print '<TD ALIGN="CENTER">&nbsp;</TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">FILE</FONT></B></TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">FILE</FONT></B></TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">RECORD</FONT></B></TD>'."\n";
print '</TR>'."\n";
print '<TR>'."\n";
print '<TD ALIGN="CENTER"><B><FONT SIZE="-2">PROGRAM</FONT></B></TD>'."\n";
print '<TD ALIGN="CENTER"><B><FONT SIZE="-2">STATUS</FONT></B></TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">COUNT</FONT></B></TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">COUNT</FONT></B></TD>'."\n";
print '</TR>'."\n";
for($a = 0; $a < @stuff; $a++)
{
 $stuff[$a] =~ s/\t/ /g;
 $stuff[$a] =~ s/  */ /g;

 if(length($stuff[$a]) != 0)
 {
  @OutPut = split(/ /,$stuff[$a]);

  $OutPut[0] = '<TR> <TD ALIGN="CENTER"> <FONT SIZE="-2">'.$OutPut[0].'</FONT></TD>'; 

  if($OutPut[1] eq "RD")
  {
   $OutPut[1] = '<TD ALIGN="CENTER"> <FONT COLOR="#008000" SIZE="-2">'.$OutPut[1].'</FONT></TD>';
  }
  else {
  
   if($OutPut[1] eq "WA")
   {
    $OutPut[1] = '<TD ALIGN="CENTER"> <FONT COLOR="#FF8040" SIZE="-2">'.$OutPut[1].'</FONT></TD>';
   }

   else {

    if($OutPut[1] eq "AF" || $OutPut[1] eq "AE" )
    {
     $OutPut[1] = '<TD ALIGN="CENTER"> <FONT COLOR="#800040" SIZE="-2">'.$OutPut[1].'</FONT></TD>';
    }
    else {

     if($OutPut[1] eq "IU")
     {
      $OutPut[1] = '<TD ALIGN="CENTER"> <FONT COLOR="#0000FF" FONT SIZE="-2">'.$OutPut[1].'</FONT></TD>';
     }
     else {
      $OutPut[1] = '<TD ALIGN="CENTER"> <FONT SIZE="-2">'.$OutPut[1].'</FONT></TD>';
     }

    }

   
   }

  }

  $OutPut[2] = '<TD ALIGN="RIGHT"> <FONT SIZE="-2">'.$OutPut[2].'</FONT></TD>';

  $OutPut[3] = '<TD ALIGN="RIGHT"> <FONT SIZE="-2">'.$OutPut[3].'</FONT></TD> </TR>';

  $stuff[$a] = join(" ",@OutPut);

  print "$stuff[$a]\n";
 }
} 
print '</TABLE>'."\n";
print '</CENTER>';
print '</BODY> </HTML>'."\n";

