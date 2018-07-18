#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
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
# Revision(s):
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Tue Jul  2 14:45:52 CDT 2013
#-------------------------------------------------------------------------------

BEGIN {
   push(@INC, "./");
}

require "Monitor/db_utils_pl";
require "Monitor/mps_utils_pl";
use DBI;
use FileHandle;
use IO::Socket;
use USCDB;

# Flush buffer after every write.
STDOUT->autoflush(1);

my $dbh;
my $sth;
my $sql;
my $user = "prdafc";
my $pass = "con8af8";
my $instance = "prdaf";

# Get Environment Variables.
$market  = $ENV{'_HOST'};  $market =~ s/ //g;
$EnvName = uc($market);

$dbh = DBI->connect('dbi:Oracle:' . $instance, $user, $pass,
{RaiseError => 1, AutoCommit => 0 } );
unless (defined $dbh) { die "Cannot connect to Oracle - exiting.\n";}

$sql = qq{select nxt_pgm_name, file_status, count(*) cnt, sum(wr_rec_quantity) rec_quan
          from ac1_control
          where nxt_pgm_name in ('AEM','FILE2E','HLD','LSN','MD','SPL')
          and file_status in ('AE','AF','CN','HO','WA','UD','IU','RD','RJ','RT','UA','US','SP','SM','SF','PR')
          having sum(wr_rec_quantity) > 0
          group by nxt_pgm_name, file_status
         };
         
$sth = $dbh->prepare($sql);
$sth->execute() or die $DBI::errstr;         

print '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV="refresh" CONTENT="180">
<META NAME="GENERATOR" CONTENT="Mozilla/3.01Gold (Win95; I) [Netscape]">
</HEAD>
<BODY>

<CENTER>
<FORM action="http://kpr01scdap.uscc.com:8082/WebMonitor/servlet/WebMonitor" METHOD="GET" ></P> ';

print '<TABLE CELLPADDING=3 > <TR> <TD ALIGN="CENTER"><B><FONT COLOR="#800040"><a HREF="http://kpr01scdap.uscc.com:8082/WebMonitor/servlet/WebMonitor?MonName=Oncall2'.$EnvName.'" target="Qmon2'.$EnvName.'">'.$EnvName.'</a></FONT></B></TD> </TR> </TABLE>';
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


while (my @row = $sth->fetchrow_array()){
	$row[0] = '<TD ALIGN="CENTER"> <FONT SIZE="-2">'.$row[0].'</FONT></TD>';
	   if($row[1] eq "RD") {
     $row[1] = '<TD ALIGN="CENTER"> <FONT COLOR="#008000" SIZE="-2">'.$row[1].'</FONT></TD>';
     } else {
       if($row[1] eq "WA") {
       $row[1] = '<TD ALIGN="CENTER"> <FONT COLOR="#FF8040" SIZE="-2">'.$row[1].'</FONT></TD>';
       } else {
         if($row[1] eq "AF" || $row[1] eq "AE" ) {
         $row[1] = '<TD ALIGN="CENTER"> <FONT COLOR="#800040" SIZE="-2">'.$row[1].'</FONT></TD>';
         } else {
           if($row[1] eq "IU") {
           $row[1] = '<TD ALIGN="CENTER"> <FONT COLOR="#0000FF" FONT SIZE="-2">'.$row[1].'</FONT></TD>';
           } else {
             $row[1] = '<TD ALIGN="CENTER"> <FONT SIZE="-2">'.$row[1].'</FONT></TD>';
           }
         }  
       }
     }

$row[2] = '<TD ALIGN="RIGHT"> <FONT SIZE="-2">'.$row[2].'</FONT></TD>';
$row[3] = '<TD ALIGN="RIGHT"> <FONT SIZE="-2">'.$row[3].'</FONT></TD>';
$row[4] = '<TD ALIGN="RIGHT"> <FONT SIZE="-2">'.$row[4].'</FONT></TD>';
print '<TR>'."\n";
print "$row[0]\n";
print "$row[1]\n";
print "$row[2]\n";
print "$row[3]\n";
print '</TR>'."\n";
} 

$sth->finish;
$dbh->disconnect();

print '</TABLE>'."\n";
print '</CENTER>';
print '</BODY> </HTML>'."\n";
