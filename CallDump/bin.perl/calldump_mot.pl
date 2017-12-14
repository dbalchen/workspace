#!/usr/bin/perl
#####################################################
# script     : callinput_mot.pl
# description: PMG report
# author     : David A. Smith - July 23, 2007
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

#---REPORT FORMAT------------------------------------
format REPORTMOT =
@<<<<<  @<<<<<<<<<<<<<  @<<<<<<<<<<<<<<  @</@</@<<< @<:@<:@<  @</@</@<<< @<:@<:@<  @<<<  @<<
$record_type,$calling_tn,$called_tn,$sMnth,$sDay,$sYear,$sHour,$sMin,$sSec,$dMnth,$dDay,$dYear,$dHour,$dMin,$dSec,$call_termination_code,$number_of_attempts
.

#---INITIALIZE VARIBLES------------------------------
$searchstring = "";
$callgnbr     = "";
$calldnbr     = "";
$filetype = "MOT";

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

    if (index($ARGV[$a+1],"FUFF") != -1) {
      $filetype = "UFF";
    }

  }
}


#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---
while ( $buff = <STDIN> ) {
  chomp($buff);
  if ( substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR" ) {
    reportMOT();
    if (index( $calling_tn, $searchstring ) != -1 ||  index( $called_tn, $searchstring ) != -1 ) {


      $~ = REPORTMOT;

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

#---FORMAT MOT---------------------------------------
sub reportMOT {

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

  if ($filetype eq "MOT") {
    @Stuff = split( /,/, $buff );
    formatMOT();
  } else {
    @Stuff = split( /\|/, $buff );
    formatUFF();
  }

  if ( $call_termination_code eq "01" ) {
    $call_termination_code = "100C";
  } elsif ($call_termination_code eq "02") {
    $call_termination_code = "101C";
  } elsif ($call_termination_code eq "03") {
    $call_termination_code = "109C";
  } elsif ($call_termination_code eq "04") {
    $call_termination_code = "110C";
  } elsif ($call_termination_code eq "05") {
    $call_termination_code = "111C";
  } elsif ($call_termination_code eq "06") {
    $call_termination_code = "112C";
  } elsif ($call_termination_code eq "08") {
    $call_termination_code = "113C";
  } elsif ($call_termination_code eq "09") {
    $call_termination_code = "114C";
  } elsif ($call_termination_code eq "0B") {
    $call_termination_code = "115C";
  } elsif ($call_termination_code eq "11") {
    $call_termination_code = "116C";
  } elsif ($call_termination_code eq "12") {
    $call_termination_code = "117C";
  } elsif ($call_termination_code eq "13") {
    $call_termination_code = "118C";
  } elsif ($call_termination_code eq "14") {
    $call_termination_code = "119C";
  } elsif ($call_termination_code eq "15") {
    $call_termination_code = "120C";
  } else {
    $call_termination_code = "108C";
  }

  $number_of_attempts = 0;
}

sub formatMOT {
  $record_type = $Stuff[30];
  if ( $record_type eq "0C" || $record_type eq "0B") {
    $record_type = "2";
  } elsif ($record_type eq "08" || $record_type eq "09") {
    $record_type = "1";
  }
  $calling_tn            = $Stuff[9];
  $called_tn             = $Stuff[19];
  $start_date            = $Stuff[2];
  $sMnth                 = substr( $start_date, 4, 2 );
  $sDay                  = substr( $start_date, 6, 2 );
  $sYear                 = substr( $start_date, 0, 4 );
  $sHour                 = substr( $start_date, 8, 2 );
  $sMin                  = substr( $start_date, 10, 2 );
  $sSec                  = substr( $start_date, 12, 2 );
  $end_date              = $Stuff[3];
  $dMnth                 = substr( $end_date, 4, 2 );
  $dDay                  = substr( $end_date, 6, 2 );
  $dYear                 = substr( $end_date, 0, 4 );
  $dHour                 = substr( $end_date, 8, 2 );
  $dMin                  = substr( $end_date, 10, 2 );
  $dSec                  = substr( $end_date, 12, 2 );
  $call_termination_code = $Stuff[31];

}


#--- FORMAT UFF ---------------------------------------
sub formatUFF {
  $record_type = $Stuff[18];
  if ( $record_type eq "MT" ) {
    $record_type = "1";
  } else {
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


  #print "sSec = $sSec sMin = $sMin sHour = $sHour sDay = $sDay sMnth = $sMnth sYear = $sYear stuff = $Stuff[35]\n";
  $etime = timelocal($sSec,$sMin,$sHour,$sDay,$sMnth - 1,$sYear) + $Stuff[35];
  ($dSec,$dMin,$dHour,$dDay,$dMnth,$dYear) = localtime($etime);
  $dYear = $dYear + 1900;
  $dSec = padBefore($dSec);
  $dMin = padBefore($dMin);
  $dHour = padBefore($dHour);
  $dDay = padBefore($dDay);
  $dMnth = padBefore($dMnth+1);

  $call_termination_code = $Stuff[27];
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
