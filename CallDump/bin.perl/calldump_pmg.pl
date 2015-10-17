#!/usr/bin/perl
#####################################################
# script     : callinput_pmg.pl
# description: PMG report
# author     : David A. Smith - July 13, 2007
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
format REPORTPMG =
@<<<<<<<<<<<<<<     @<<<<<<<<<<<<<<      @<<<<<<<<<<<<   @<<<<<<<<<<<<<<     @<<<<<<<<<<<<<<     @<<<<<<<<<    @<<<<<<<<<   @<<     @<<<<<<< @<<<< @<<<< @<<<<<<<<<<<<
$startdate,$enddate,$loginName,$clientip,$serverip,$bytesin,$bytesout,$msgdir,$roamInd,$homeSid,$serveSid,$carrierId
.

#---INITIALIZE VARIBLES------------------------------
$searchstring = "";
$name         = "";
$filetype = "PMG";

#---INPUTS-------------------------------------------
#$inputfile = $ARGV[0];
#$inputfile =~ s/ //g;

for ( $a = 0 ; $a < @ARGV ; $a++ ) {
  if ($ARGV[$a] eq "-s" ) {
    $searchstring = lc( $ARGV[ $a + 1 ] );
  }
  if ($ARGV[$a] eq "-g" ) {
    $name = "-g";
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
    if ( ( index( $buff, $searchstring ) ) != -1 ) {
      reportPMG();
      $~ = REPORTPMG;
      if ( ( ( index( $loginName, $searchstring ) ) != -1 )
	   && $name eq "-g" ) {
	write;
      }
    }
  }
}

exit(0);

#---FORMAT PMG---------------------------------------
sub reportPMG {
  $startdate = "";
  $enddate   = "";
  $loginName = "";
  $clientip  = "";
  $serverip  = "";
  $bytesin   = "";
  $bytesout  = "";
  $msgdir    = "";
  $roamInd   = "";
  $homeSid   = "";
  $serveSid  = "";
  $carrierId = "";

  if ($filetype eq "PMG") {
    formatPMG();
  } else {
    formatUFF();
  }

}

sub formatPMG {
  @Stuff     = split( /\|/, $buff );
  $startdate = $Stuff[4];
  $enddate   = $Stuff[5];
  $loginName = $Stuff[3];
  ($clientip,$crap)  = split('@',$Stuff[6]);
  ($serverip,$crap)  = split('@',$Stuff[7]);
  $bytesin   = $Stuff[8];
  $bytesout  = $Stuff[9];
  $msgdir    = $Stuff[12];
  $roamInd   = $Stuff[34];
  $homeSid   = $Stuff[35];
  $serveSid  = $Stuff[36];
  $carrierId = $Stuff[29];
}


sub formatUFF {
  @Stuff     = split( /\|/, $buff );

  #    $startdate = $Stuff[4];
  #    $enddate   = $Stuff[5];

  my $start_date            = $Stuff[7];
  my $sYear                 = substr( $start_date, 0, 4);
  my $sMnth                 = substr( $start_date, 4, 2 );
  my $sDay                  = substr( $start_date, 6, 2 );

  my $start_time            = $Stuff[8];
  my $sHour                 = substr( $start_time, 0, 2 );
  my $sMin                  = substr( $start_time, 2, 2 );
  my $sSec                  = substr( $start_time, 4, 2 );

  $startdate = $start_date.$start_time;

  my $etime = timelocal($sSec,$sMin,$sHour,$sDay,$sMnth-1,$sYear) + $Stuff[35];
  (my $dSec,my $dMin,my $dHour,my $dDay,my $dMnth,my $dYear) = localtime($etime);
  $dYear = $dYear + 1900;
  $dSec = padBefore($dSec);
  $dMin = padBefore($dMin);
  $dHour = padBefore($dHour);
  $dDay = padBefore($dDay);
  $dMnth = padBefore($dMnth+1);
 
  $enddate = $dYear.$dMnth.$dDay.$dHour.$dMin.$dSec;

  $loginName = $Stuff[19];
  ($clientip,$crap)  = split('@',$Stuff[22]);
  ($serverip,$crap)  = split('@',$Stuff[26]);


#  $clientip  = $Stuff[22];
#  $serverip  = $Stuff[26];
  $bytesin   = $Stuff[39];
  $bytesout  = $Stuff[40];
  $msgdir    = $Stuff[12];
  $roamInd   = $Stuff[36];

  if ($roamInd == 1) {
    $roamInd = "R";
  } else {
    $roamInd = "H";
  }

  $homeSid   = $Stuff[10];
  $serveSid  = $Stuff[11];
  $carrierId = $Stuff[15];
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
