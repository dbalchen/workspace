#!/usr/bin/perl
#####################################################
# script     : calldump_alu.pl
# description: ALU report
# author     : David Balchen
#####################################################
#Revisions:
#
#####################################################

BEGIN {
    push( @INC, $ENV{TLG_BIN} );
}

use POSIX;
use FileHandle;
use Time::Local;
use warnings;

open(STDIN,"< $ARGV[0]");

#print "$ARGV[0]\n";

#---REPORT FORMAT------------------------------------
format REPORTALU =
@<<<<<  @<<<<<<<<<<<<<  @<<<<<<<<<<<<<<  @</@</@<<< @<:@<:@<  @</@</@<<< @<:@<:@<  @<<<  @<<
$record_type,$calling_tn,$called_tn,$sMnth,$sDay,$sYear,$sHour,$sMin,$sSec,$dMnth,$dDay,$dYear,$dHour,$dMin,$dSec,$call_termination_code,$number_of_attempts
.

#---INITIALIZE VARIBLES------------------------------
$searchstring = "";
$callgnbr     = "";
$calldnbr     = "";
$filetype = "ALU";

#($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
@TimeArray = localtime(time);

$year = 1900 + $TimeArray[5];

#---INPUTS-------------------------------------------
for ( $a = 0 ; $a < @ARGV ; $a++ ) {
    if ($ARGV[$a] eq "-s" ) {
        $searchstring = lc( $ARGV[ $a + 1 ] );
        $searchstring =~ s/ //g;
    }
    if ($ARGV[$a] eq "-g" ) {
        $callgnbr = "-g";
    }
    if ($ARGV[$a] eq "-d" ) {
        $calldnbr = "-d";
    }
    if ($ARGV[$a] eq "-i" ) {
        $calldnbr = "-d";
    }
    if ($ARGV[$a] eq "-fn" ) {

      if(index($ARGV[$a+1],"FUFF") != -1)
	{
         $filetype = "UFF";
	}

    }

}


#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---
while ( $buff = <STDIN> ) {
  chomp($buff);
  if ( substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR" ) {
    reportALU();
    if (index( $calling_tn, $searchstring ) != -1 ||  index( $called_tn, $searchstring ) != -1 ) {


      $~ = REPORTALU;

      if ( ( ( index( $calling_tn, $searchstring ) ) != -1 )
	   && $callgnbr eq "-g" ) {
	write;
      } elsif ( ( ( index( $called_tn, $searchstring ) ) != -1 )
                && $calldnbr eq "-d" ) {
	write;
      } elsif ($calldnbr ne "-d" &&  $callgnbr ne "-g") {
	write;
      }
    }
  }
}

exit(0);

#--- Report ALU ---------------------------------------
sub reportALU {

    #Initialize variables
    $record_type           = "";
    $calling_tn            = "";
    $called_tn             = "";
    $start_date            = "";
    $sMnth                 = "";
    $sDay                  = "";
    $sYear                 = "";
    $sHour                 = "";
    $sMin                  = "";
    $sSec                  = "";
    $end_date              = "";
    $dMnth                 = "";
    $dDay                  = "";
    $dYear                 = "";
    $dHour                 = "";
    $dMin                  = "";
    $dSec                  = "";
    $call_termination_code = "";
    $number_of_attempts    = "";

    #Parse records from STDIN into 'Call input Report Fields'
    @Stuff = split( /\|/, $buff );

    if($filetype eq "ALU")
      {
	formatALU();
      }
    else
      {
	formatUFF();
      }

    if ( $call_termination_code eq "0" ) {
        $call_termination_code = "100C";
    }
    elsif ($call_termination_code eq "5") {
        $call_termination_code = "102C";
    }
   elsif ($call_termination_code eq "7") {
        $call_termination_code = "104C";
    }
   elsif ($call_termination_code eq "8") {
        $call_termination_code = "101C";
    }
   else {
        $call_termination_code = "108C";
    }

}

#--- FORMAT ALU ---------------------------------------
sub formatALU {

    $record_type = $Stuff[2];
    if ( $record_type eq "501" ) {
        $record_type = "1";
    }
    else {
        $record_type = "2";
    }
    $calling_tn            = $Stuff[14];
    $called_tn             = $Stuff[19];
    $start_date            = $Stuff[27];
    $sMnth                 = substr( $start_date, 1, 2 );
    $sDay                  = substr( $start_date, 3, 2 );
    
    $sYear                 = substr( $start_date, 0, 1 );
    if(substr($year,3,1) eq $sYear)
    { $sYear = $year;}
    else
    {$sYear = $year - 1;}

    $sHour                 = substr( $start_date, 5, 2 );
    $sMin                  = substr( $start_date, 7, 2 );
    $sSec                  = substr( $start_date, 9, 2 );
    $end_date              = $Stuff[15];
    $dMnth                 = substr( $end_date, 1, 2 );
    $dDay                  = substr( $end_date, 3, 2 );
    
    $dYear                 = substr( $end_date, 0, 1 );
     if(substr($year,3,1) eq $dYear)
    { $dYear = $year;}
    else
    {$dYear = $year - 1;}
    
    $dHour                 = substr( $end_date, 5, 2 );
    $dMin                  = substr( $end_date, 7, 2 );
    $dSec                  = substr( $end_date, 9, 2 );
    $call_termination_code = $Stuff[8];

    $number_of_attempts = 0;
}


#--- FORMAT UFF ---------------------------------------
sub formatUFF {
    $record_type = $Stuff[18];
    if ( $record_type eq "MT" ) {
        $record_type = "1";
    }
    else {
        $record_type = "2";
    }

    $calling_tn            = $Stuff[21];
    $called_tn             = $Stuff[24];

    $start_date            = $Stuff[7];
    $sYear                 = substr( $start_date, 0, 4);
    $sMnth                 = substr( $start_date, 4, 2 );
    $sDay                  = substr( $start_date, 6, 2 );

    $start_time            = $Stuff[8];
    $sHour                 = substr( $start_time, 0, 2 );
    $sMin                  = substr( $start_time, 2, 2 );
    $sSec                  = substr( $start_time, 4, 2 );


    $etime = timelocal($sSec,$sMin,$sHour,$sDay,$sMnth-1,$sYear) + $Stuff[35];
    ($dSec,$dMin,$dHour,$dDay,$dMnth,$dYear) = localtime($etime);
    $dYear = $dYear + 1900;
    $dSec = padBefore($dSec);
    $dMin = padBefore($dMin);
    $dHour = padBefore($dHour);
    $dDay = padBefore($dDay);
    $dMnth = padBefore(($dMnth+1));

    $call_termination_code = $Stuff[27];

    $number_of_attempts = 0;
}

sub padBefore
  {
    my ($theString) = shift;

    $theString =~ s/  *//g;

    while (length($theString) < 2) {
      $theString = "0".$theString;
    }

    return $theString;
  }
