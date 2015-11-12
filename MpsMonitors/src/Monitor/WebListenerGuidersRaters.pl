#! /usr/local/bin/perl5
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

require "Monitor/Monitor.tmpl.pl";

# Set Title

  $Title = "Listener, Guiders and Raters";


# Get Market from STDIN

  $Market   =  uc($ENV{'TLG_MARKET'});  $Market =~ s/ //g;
  $PageLink = '<a HREF="http://chi1pas1.uscc.com:8082/WebMonitor/servlet/WebMonitor?MonName=WebListenGuideRate&MARKET='.$Market.'" target="GRL'.$Market.'">'.$Market.'</a>'; 


# 4) Call CheckRate2.bat using Hash Table and market name.

  @Stuff = `Monitor/getListenerGuidersRaters.pl`;
  chomp(@Stuff);


# 5) Display Listener

  ($pgm,$time) = split(/!/,$Stuff[0]);

   $Output = '<CENTER><TABLE BORDER=1 CELLPADDING=3 >
            <TR><TD ALIGN="CENTER"><B><FONT SIZE=-1>Listener</FONT></B></TD>
            <TD ALIGN="CENTER"><B><FONT SIZE=-1>Time</FONT></B></TD></TR><TR><TD ALIGN="CENTER">';

   if ($time ne "-")
   {
    $Output = $Output.'<FONT COLOR="#008040">';
   }
   else 
   {
    $Output = $Output.'<FONT COLOR="#FF0000">';
   }
   $Output = $Output.'<FONT SIZE=-1>'.$pgm.'</FONT></FONT></TD>
           <TD ALIGN="CENTER"><FONT SIZE=-1>'.$time.'</FONT></TD>
           </TR></TABLE></CENTER><P><HR WIDTH="100%"></P>';

# 6) Display Guiders

  @Guide = split(/;/,$Stuff[1]);


   $Output = $Output.'<CENTER><TABLE BORDER=1 CELLPADDING=3 >
           <TR><TD ALIGN="CENTER"><B><FONT SIZE=-1>Guiders</FONT></B></TD>
           <TD ALIGN="CENTER"><B><FONT SIZE=-1>Time</FONT></B></TD></TR>';

  for($b = 0;$b < @Guide;$b++)
  {
   ($pgm,$time) = split(/!/,$Guide[$b]);

   if($OutType eq "-t")
   {
    print STDOUT "Guiders --> $pgm  $time\n";
   }
   else
   {
    if($time ne "-")
    {
     $Output = $Output.'<TR>  <TD ALIGN="CENTER"><FONT COLOR="#008000"><FONT SIZE=-1>'.$pgm.'</FONT></FONT></TD>
                    <TD ALIGN="CENTER"><FONT SIZE=-1>'.$time.'</FONT></TD>  </TR>';
    }
    else
    {
     $Output = $Output.'<TR><TD ALIGN="CENTER"><FONT COLOR="#FF0000"><FONT SIZE=-1>'.$pgm.'</FONT></FONT></TD>
                    <TD ALIGN="CENTER"><FONT SIZE=-1>'.$time.'</FONT></TD></TR>';
    }
   }
  }

   $Output = $Output.'</TABLE></CENTER><P><HR WIDTH="100%"></P>';


# 7) Display Raters

  @Raters =  split(/;/,$Stuff[2]);

   $Output = $Output.'<CENTER><TABLE BORDER=1 CELLPADDING=3 >
                  <TR><TD ALIGN="CENTER"><B><FONT SIZE=-1>Raters</FONT></B></TD>
                  <TD ALIGN="CENTER"><B><FONT SIZE=-1>Status</FONT></B></TD></TR>';

  for($b = 0;$b < @Raters;$b++)
  {
   ($pgm,$Status) = split(/!/,$Raters[$b]);

    if($time ne "-")
    {
     $Output = $Output.'<TR><TD ALIGN="CENTER"><FONT COLOR="#008000"><FONT SIZE=-1>'.$pgm.'</FONT></FONT></TD>
               <TD ALIGN="CENTER"><FONT SIZE=-1>'
                    .$Status.'</FONT></TD></TR>';
    }
    else
    {
     $Output = $Output.'<TR><TD ALIGN="CENTER"><FONT COLOR="#FF0000"><FONT SIZE=-1>'.$pgm.'</FONT></FONT></TD>
                    <TD ALIGN="CENTER"><FONT SIZE=-1>'.$Status.'</FONT></TD></TR>';
    }

  }

   $Output = $Output.'</TABLE></CENTER>';


#  Print Html

   $HTML =~ s/!MARKET/$Market/g;
   $HTML =~ s/!TITLE/$Title/g;
   $HTML =~ s/!OUTPUT/$Output/g;
   $HTML =~ s/!LINK/$PageLink/g;
   print STDOUT $HTML;

exit(0);


   
