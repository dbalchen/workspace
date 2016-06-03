#!/usr/bin/perl
#####################################################
# script     : calldump_voice.pl
# description: perl report for all voice files.
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
format REPORT12 =
@<<<<<<<<<<@<<<<<<<<<@<<<<<  @<<<<<<<<< @<<<<<<<<<<<< @<<<<<<<<<<<< @  @  @  @  @  @  @<<<<<<<<<<<<<<<<<< @<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$date,$ctime,$duration,$calling_tn,$dialed_tn,$called_tn,$cd,$ans,$o3w,$tc,$tcf,$oss,$enodeb,$srvFeat
.

#---INITIALIZE VARIBLES------------------------------
#$inputfile    = "";
$searchstring = "";
$callgnbr     = "";
$calldnbr     = "";
$dialdnbr     = "";
#$switch       = "Volte";
$exact = 0;

#---INPUTS-------------------------------------------

for ( $a = 0 ; $a < @ARGV ; $a++ ) {

  if ($ARGV[$a] eq "-s" ) {
    $searchstring = uc( $ARGV[ $a + 1 ] );
    $searchstring =~ s/ //g;

    if (index($searchstring,"=") >= 0) {
      $exact = 1;
      $searchstring =~ s/=//g;
    }
  }

  if ($ARGV[$a] eq "-g" ) {
    $callgnbr = "-g";
  }

  if ($ARGV[$a] eq "-i" ) {
    $calldnbr = "-i";
  }

  if ($ARGV[$a] eq "-d" ) {
    $dialdnbr = "-d";
  }

}

#print STDOUT "\n\n$inputfile, $searchstring, $cellsite, $callgnbr, $calldnbr, $dialdnbr\n\n";

#---OPEN FILE----------------------------------------
#open( STDIN, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---

while ( $buff = <STDIN> ) {
  chomp($buff);
  if (substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR") {

    if ( ( index( $buff, $searchstring ) ) != -1 ) {
      report12();
      $~ = REPORT12;

      if ($exact) {
	exactSearch();
      } else {
	standardSearch();
      }

    }
  }
}

sub standardSearch
  {

    if ( ( ( index( $calling_tn, $searchstring ) ) != -1 )
	 && $callgnbr eq "-g" ) {
      write;
    } elsif ( ( ( index( $called_tn, $searchstring ) ) != -1 )
	      && $calldnbr eq "-i" ) {
      write;
    } elsif ( ( ( index( $dialed_tn, $searchstring ) ) != -1 )
	      && $dialdnbr eq "-d" ) {
      write;
    } else {

      if ( ($dialdnbr ne "-d") && ($calldnbr ne "-i") &&  ($callgnbr ne "-g") ) {
	write;
      }
    }
  }

sub exactSearch
  {
    $callingtn = $calling_tn;
    $callingtn =~ s/  *//g;

    $calledtn = $called_tn;
    $calledtn =~ s/  *//g;

    $dialedtn = $dialed_tn;
    $dialedtn =~ s/  *//g;

    if ( ($callingtn eq $searchstring)  && $callgnbr eq "-g" ) {
      write;
    } elsif ( ( $calledtn eq $searchstring ) && $calldnbr eq "-i") {
      write;
    } elsif ( ( $dialedtn eq $searchstring ) && $dialdnbr eq "-d" ) {
      write;
    } else {
      if ( ($dialdnbr ne "-d") && ($calldnbr ne "-i") &&  ($callgnbr ne "-g")) {
	write;
      }

    }
  }


#print STDOUT "\n";

#---CLOSE FILE---------------------------------------
#close(STDIN);

#---FORMAT 12---------------------------------------

sub report12 {

  #Initialize variables
  $date       = "";
  $ctime      = "";
  $duration   = "";
  $calling_tn = "";
  $dialed_tn  = "";
  $called_tn  = "";
  $ct         = "";
  $ans        = "";
  $o3w        = "";
  $tc         = "";
  $tcf        = "";
  $oss        = "";
  $srvFeat    = "";
  $cd         = "";
  $enodeb     = "";
  $ocli       = "";
  $tcli       = "";

  @Stuff = split( /\|/, $buff );
  my $start_date            = $Stuff[7];
  my $sYear                 = substr( $start_date, 0, 4);
  my $sMnth                 = substr( $start_date, 4, 2 );
  my $sDay                  = substr( $start_date, 6, 2 );

  $date = padString($sMnth,2).'/'.padString($sDay,2).'/'.$sYear;

  $ctime      = $Stuff[8];
  $ctime      = substr($ctime,0,2).':'.substr($ctime,2,2).':'.substr($ctime,4,2);
  $duration   = padString($Stuff[35],6);
  $calling_tn = $Stuff[21];
  $dialed_tn  = $Stuff[25];
  $called_tn  = $Stuff[24];

  $ans        = bitMask($Stuff[33]);
  $o3w        = bitMask($Stuff[32]);
  $tc         = bitMask($Stuff[31]);
  $tcf        = bitMask($Stuff[29]);
  $oss        = "N";

  $cd = $Stuff[18];
  $ocli       = uc($Stuff[12]);
  $tcli       = uc($Stuff[13]);

  if ($cd eq "MO") {
    $cd = "O";
    $enodeb     = $ocli;
  } elsif ($cd eq "MT") {
    $cd = "I";
    $enodeb     = $tcli;
  }

  $enodeb = $Stuff[15]."-".hex(substr($enodeb,0,6))."-".hex(substr($enodeb,-2,2));
  
  $srvFeat = $Stuff[28];

  my $prefix = "";

  if (length($dialed_tn) > 10) {
    $prefix = substr($dialed_tn,0,-10);
    $dialed_tn = substr($dialed_tn,-10);
  }

}

sub padString {

  my ($string2pad,$hm) = @_;

  while (length($string2pad) < $hm) {
    $string2pad = "0".$string2pad;
  }

  return $string2pad;
}


sub bitMask
  {
    my $truth = shift;

    if ($truth eq "1") {
      $truth = "Y";
    } else {
      $truth = "N";
    }
    return $truth;
  }
