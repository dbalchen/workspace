#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      Monitor.tmpl.pl
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
# Date          : Thu Aug  2 10:49:19 CDT 2012
#-------------------------------------------------------------------------------

     ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$idst)
                                             = localtime;
     # Format time variables

     $year = $year + 1900;
     $sec  = Tclean($sec);
     $hour = Tclean($hour);
     $min  = Tclean($min);
     $mday = Tclean($mday);

     $mon = $mon + 1;
     $mon  = Tclean($mon);

$HTML = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN"><HTML>
         <HEAD><TITLE>!TITLE</TITLE><META HTTP-EQUIV="refresh" CONTENT="300"></HEAD>
         <BODY><CENTER><TABLE CELLPADDING=3 ><TR><TD ALIGN="CENTER"><B><FONT COLOR="#FF0000">!LINK</FONT></B></TD>
         </TR></TABLE></CENTER><CENTER><TABLE CELLPADDING=3 ><TR><TD ALIGN="LEFT">
         <TABLE CELLPADDING=3 ><TR><TD ALIGN="LEFT"><B><FONT COLOR="#004080"><FONT SIZE=-1>Date</FONT></FONT></B></TD>
         </TR><TR><TD ALIGN="LEFT"><B><FONT COLOR="#004080"><FONT SIZE=-1>'."$mon/$mday/$year".'</FONT></FONT></B></TD>
         </TR></TABLE><FONT SIZE=-1></FONT></TD><TD ALIGN="CENTER"><FONT SIZE=-1><B><FONT COLOR="#FF0000">!TITLE</FONT></B>
         </FONT></TD><TD ALIGN="RIGHT"><FONT SIZE=-1></FONT><TABLE CELLPADDING=3 >
         <TR><TD ALIGN="RIGHT"><B><FONT COLOR="#004080"><FONT SIZE=-1>Time</FONT></FONT></B></TD>
         </TR><TR><TD ALIGN="RIGHT"><B><FONT COLOR="#004080"><FONT SIZE=-1>'."$hour:$min:$sec".'</FONT></FONT>
         </B></TD></TR></TABLE></TD></TR></TABLE></CENTER><P><HR WIDTH="100%"></P>!OUTPUT</BODY></HTML>';

sub Tclean {

 local($Tmp) = @_;

 $Tmp =~ s/ //g;

 if($Tmp < 10)
 {
  $Tmp = "0".$Tmp;
 }

 return $Tmp;

}

1;
