#!/usr/bin/perl
#####################################################
# script     : callinput_qis.pl
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
use warnings;

#---REPORT FORMAT------------------------------------
format REPORTQIS =
@<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<< @<<<<<<<<<<< @<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  @<<<<   @<<<<<<  @<<<<<<<<<  @<<< @<<
$lts,$msid,$trid,$pn,$an,$et,$ca,$aa,$ar,$pm
.

#---INITIALIZE VARIBLES------------------------------
$searchstring = "";
$ms           = "";
$filetype = "QIS";

#---INPUTS-------------------------------------------

for ( $a = 0 ; $a < @ARGV ; $a++ ) {
  if ($ARGV[$a] eq "-s" ) {
    $searchstring = lc( $ARGV[ $a + 1 ] );
  }
  if ( $ARGV[ $a] eq "-m" ) {
    $ms = "-m";
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
      reportQIS();
      $~ = REPORTQIS;
      if ( ( ( index( $msid, $searchstring ) ) != -1 ) && $ms eq "-m" ) {
	write;
      }
    }
  }
}

exit(0);

#---FORMAT QIS---------------------------------------
sub reportQIS {
  $lts   = "";
  $msid  = "";
  $trid  = "";
  $pn    = "";
  $an    = "";
  $et    = "";
  $ca    = "";
  $aa    = "";
  $ar    = "";
  $pm    = "";

  if ($filetype eq "QIS") {
    formatQIS();
  } else {
    formatUFF();
  }
}


sub formatQIS {
  @Stuff = split( /,/, $buff );
  $lts   = $Stuff[13];
  $msid  = $Stuff[4];
  $trid  = $Stuff[1];
  $pn    = $Stuff[7];
  $an    = $Stuff[8];
  $et    = $Stuff[15];
  $ca    = $Stuff[46];
  $aa    = $Stuff[25];
  $ar    = $Stuff[24];
  if ( ( POSIX::isalpha($ar) ) != 0 ) {
    $ar = "";
  }
  $pm = $Stuff[16];
}


sub formatUFF {
  @Stuff = split( /\|/, $buff );

  my $dt = $Stuff[7];
  $lts = substr($dt,4,4).substr($dt,0,4).' '.$Stuff[8];
  $msid  = $Stuff[19];
  $trid  = $Stuff[37];
  $pn    = $Stuff[41];
  $an    = $Stuff[43];
  $et    = $Stuff[17];
  $ca    = $Stuff[46];
  $aa    = 0;
  $ar    = 0;
  $pm = 0;#$Stuff[];
}
