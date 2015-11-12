#! /opt/perl5/bin/perl
#----------------------------------------------------------------------------
# Script:      Qmon.pl
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
#----------------------------------------------------------------------------
# Revision(s):
#----------------------------------------------------------------------------
#
#
#----------------------------------------------------------------------------

BEGIN {
   push(@INC, "./");
}

require "Monitor/db_utils_pl";
require "Monitor/mps_utils_pl";
use FileHandle;
use IO::Socket;
use USCDB;

# Flush buffer after every write.
STDOUT->autoflush(1);


$market   =  $ENV{'TLG_MARKET'};  $market =~ s/ //g;
$EnvName = uc($market);

$DBService = "PU2".$EnvName;
$DataBaseHost=$ENV{'HOST'};
$DBuser  = "read_all";
$DBpass  = "read_all";

$DBenv = $DBuser.'/'.$DBpass.'@'.$DBService;

$SQLPlUS = $ENV{'ORACLE_HOME'};
chomp($SQLPlUS);
$SQLPlUS = "$SQLPlUS/bin/sqlplus";


$hh = "$SQLPlUS -s $DBenv << !!
set heading off
set FEEDBACK off
COLUMN PGM                 FORMAT A2
COLUMN FILE_STATUS         FORMAT A2
COLUMN DATA_GROUP          FORMAT A6
COLUMN CNT                 FORMAT 9,999
COLUMN RECQ                FORMAT 9,999,999

SELECT decode(fpfc_nxt_pgm_name,'MAF2COLL','NM','UPS2COLL','CO','UPS2MDRV','MD','mpgd_100mn','GD','mpup_100mn','RT', fpfc_nxt_pgm_name) PGM, file_status, data_group, count(*) CNT, sum(wr_rec_quantity) recq FROM ac_processing_accounting WHERE fpfc_nxt_pgm_name in ('MAF2COLL','UPS2COLL','UPS2MDRV','mpgd_100mn','mpup_100mn') AND file_status in ('IU','AF','AE','RD','WA') GROUP BY fpfc_nxt_pgm_name, file_status, data_group;
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
<FORM action="http://chi1pas1.uscc.com:8082/WebMonitor/servlet/WebMonitor" METHOD="GET" ></P> ';

print '<TABLE CELLPADDING=3 > <TR> <TD ALIGN="CENTER"><B><FONT COLOR="#800040"><a HREF="http://chi1pas1.uscc.com:8082/WebMonitor/servlet/WebMonitor?MonName=Oncall3'.$EnvName.'" target="Qmon3'.$EnvName.'">'.$EnvName.'</a></FONT></B></TD> </TR> </TABLE>';
print '<TABLE BORDER=1 CELLPADDING=3 >'."\n";
print '<TR>'."\n";
print '<TD ALIGN="CENTER">&nbsp;</TD>'."\n";
print '<TD ALIGN="CENTER">&nbsp;</TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">DATA</FONT></B></TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">FILE</FONT></B></TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">RECORD</FONT></B></TD>'."\n";
print '</TR>'."\n";
print '<TR>'."\n";
print '<TD ALIGN="CENTER"><B><FONT SIZE="-2">PROG</FONT></B></TD>'."\n";
print '<TD ALIGN="CENTER"><B><FONT SIZE="-2">FS</FONT></B></TD>'."\n";
print '<TD ALIGN="RIGHT"><B><FONT SIZE="-2">GROUP</FONT></B></TD>'."\n";
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

  $OutPut[3] = '<TD ALIGN="RIGHT"> <FONT SIZE="-2">'.$OutPut[3].'</FONT></TD>';


  $OutPut[4] = '<TD ALIGN="RIGHT"> <FONT SIZE="-2">'.$OutPut[4].'</FONT></TD> </TR>';

 $stuff[$a] = join(" ",@OutPut);

  print "$stuff[$a]\n";
 }
} 

print '</TABLE>'."\n";
print '</CENTER>';
print '</BODY> </HTML>'."\n";

