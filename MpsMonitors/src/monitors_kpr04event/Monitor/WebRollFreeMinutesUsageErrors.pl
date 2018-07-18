#!/usr/local/bin/perl

BEGIN {
    push(@INC, "./");
}

require "Monitor/db_utils_pl";
require "Monitor/mps_utils_pl";
require "Monitor/Monitor.tmpl.pl";

use FileHandle;
use IO::Socket;
use USCDB;


#Get Environment Variables.
$market   =  $ENV{'ABP_MARKET'};  $market =~ s/ //g;
$EnvName = uc($market);
$Market = $EnvName;

#$DBService = "PU1".$EnvName;
$DataBaseHost=$ENV{'OP_ORA_INST'};
$DBuser  = $ENV{'APP_ORA_USER'};
$DBpass  = $ENV{'APP_ORA_PASS'};

#$DBenv = $DBuser.'/'.$DBpass.'@'.$DBService;  #CARES production
$DBenv = $DBuser.'/'.$DBpass.'@'.$DataBaseHost;   #TOPS sitabp12

$SQLPLUS = $ENV{'ORACLE_HOME'};
chomp($SQLPLUS);
$SQLPLUS = "$SQLPLUS/bin/sqlplus";

$Title = "Roll Free Minutes and Usage Errors";

$PageLink = '<a HREF="http://chi1pas1.uscc.com:8082/WebMonitor/servlet/WebMonitor?MonName=WebFreeMinUsgErrs&MARKET='.$Market.'" target="USAGE'.$Market.'">'.$EnvName.'</a>';


$hh = "grep 'mpgn_roll_fm: Number of rejected ban(s)' $ENV{'ABP_LOG'}/MPGNROLLFM*".$year.$mon.'*';

@Buff = `$hh`;
$Output = '<CENTER><TABLE CELLPADDING=3 ><TR><TD ALIGN="CENTER"><B><FONT COLOR="#FF0000" SIZE=-1 >MPGNROLLFM scan for Zero Rejects</FONT></B></TD>
            </TR></TABLE></CENTER><CENTER><TABLE BORDER=1 CELLPADDING=3 > <TR> <TD ALIGN="CENTER"><B><FONT SIZE=-1>Log File</FONT></B></TD>
            <TD ALIGN="CENTER"><B><FONT SIZE=-1>Rejects</FONT></B></TD></TR>';

for ($a = 0; $a < @Buff; $a++) {

    ($LogFile,$crap,$crap2,$BanRej) = split(/:/,$Buff[$a]);

    $BanRej =~ s/\[//g;
    $BanRej =~ s/\]//g;

    $Output = $Output.'<TR> <TD ALIGN="CENTER"><FONT SIZE=-2>'.$LogFile.'</FONT></TD>
            <TD ALIGN="CENTER"><B><FONT SIZE=-1>'.$BanRej.'</FONT></B></TD></TR>';
}


$Output = $Output.'<CENTER><TABLE CELLPADDING=3 ><TR>
            <TD ALIGN="LEFT"><FONT SIZE=-2>Check Usage Error Counts for unusually high numbers,</FONT></TD>
            </TR><TR><TD ALIGN="LEFT"><FONT SIZE=-2>IF THE RECORD COUNT IS ABOVE <B><FONT COLOR="#800040">2000</FONT></B>
            For any code other</FONT></TD></TR><TR><TD ALIGN="LEFT"><FONT SIZE=-2>Then <FONT COLOR="#FF8040"><B>UP_CC5015</B>,
            <B>UP_GD2210</B>, <B>UP_GD2218</B>, <B>UP_TL3040</B></FONT></FONT></TD></TR><TR>
            <TD ALIGN="LEFT"><FONT SIZE=-2>Then they should be investigated.</FONT></TD></TR>
            </TABLE></CENTER><CENTER><TABLE BORDER=1 CELLPADDING=3 ><TR><TD ALIGN="CENTER"><B><FONT SIZE=-2>Error Code</FONT></B></TD>
            <TD ALIGN="CENTER"><B><FONT SIZE=-2>Count</FONT></B></TD>
            <TD ALIGN="CENTER"><B><FONT SIZE=-2>Error Description</FONT></B></TD></TR>';



$hh = "$SQLPLUS -s $DBenv << !!
         set heading off
         set FEEDBACK off
         select error_code, count(1) from MF9_LSN_ERRORS where status is not null group by error_code;
         exit;
         !!";

@stuff = `$hh`;chomp(@stuff);

$b = 0;
for ($a = 0; $a < @stuff; $a++) {

    $stuff[$a] =~ s/\t/ /g;
    $stuff[$a] =~ s/  */ /g;

    if (length($stuff[$a]) != 0) {
	($error_code,$number) = split(/ /,$stuff[$a]);

	$hh = "$SQLPLUS -s $DBenv << !!  
    SET HEADING OFF 
    select FILE_TYPE from MF9_LSN_ERRORS where ERROR_CODE = '$error_code';
    exit;
    !!";

	@desc  = `$hh`;chomp(@desc);
	$Tdesc = join(" ",@desc);
	$Sdesc[$b] = "$error_code,$number,$Tdesc";
	$b++;
    }
}

for ($a = 0; $a < @Sdesc; $a++) {
    ($ERRORCODE,$TOTALERR,$ERRORDESC) = split(/,/,$Sdesc[$a]);


    $Output = $Output.'<TR><TD ALIGN="CENTER"><FONT SIZE=-2>'.$ERRORCODE.'</FONT></TD>';

    if ($TOTALERR >= 2000) {
	if ($ERRORCODE eq 'UP_CC5015' || $ERRORCODE eq 'UP_GD2210' || $ERRORCODE eq 'UP_GD2218' || $ERRORCODE eq 'UP_TL3040') {
	    $Output = $Output. '<TD ALIGN="CENTER"><FONT COLOR="#FF8040" SIZE=-2>'.$TOTALERR.'</FONT></TD>';
	} else {
	    $Output = $Output.'<TD ALIGN="CENTER"><FONT COLOR="#800040" SIZE=-2>'.$TOTALERR.'</FONT></TD>';
	}
    } else {
	$Output = $Output.'<TD ALIGN="CENTER"><FONT SIZE=-2>'.$TOTALERR.'</FONT></TD>';
    }

    $Output = $Output.'<TD ALIGN="CENTER"><FONT SIZE=-2>'.$ERRORDESC.'</FONT></TD></TR>';
}



# Print Html


$Output = $Output.'</TABLE></CENTER>';
$HTML =~ s/!MARKET/$Market/g;
$HTML =~ s/!TITLE/$Title/g;
$HTML =~ s/!OUTPUT/$Output/g;
$HTML =~ s/!LINK/$PageLink/g;
print STDOUT $HTML;



exit(0);
