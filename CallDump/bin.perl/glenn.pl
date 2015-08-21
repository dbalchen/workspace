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
@<<<<<<<<<<@<<<<<<<<<@<<<<<  @<<<<<<<<<<  @<<<<<<<<< @<<<<<<<<< @<<<<<<<<<<<<<<< @<<<<<<<<<<<< @<<  @  @  @  @  @    @<<< @<<< @<<<<<
$date,$ctime,$duration,$esn,$msid,$calling_tn,$dialed_tn,$called_tn,$ct,$ans,$o3w,$tc,$tcf,$oss,$ocli,$tcli,$switch
.

#---INITIALIZE VARIBLES------------------------------
#$inputfile    = "";
$searchstring = "";
$callgnbr     = "";
$calldnbr     = "";
$dialdnbr     = "";
$Iocli = 0;
$Itcli = 0;
$switch       = "";
$exact = 0;

#---INPUTS-------------------------------------------
#$inputfile = $ARGV[0];
#$inputfile =~ s/ //g;

for ( $a = 0 ; $a < @ARGV ; $a++ ) {

  if ($ARGV[$a] eq "-s" ) {
    $searchstring = uc( $ARGV[ $a + 1 ] );
    $searchstring =~ s/ //g;

    if (index($searchstring,"=") >= 0) {
      $exact = 1;
      $searchstring =~ s/=//g;
    }
  }

  if ($ARGV[$a] eq "-sw" ) {
    $switch = lc( $ARGV[ $a + 1 ] );
    $switch =~ s/ //g;
  }

  if ($ARGV[$a] eq "-oc" ) {

    $Iocli = 1;
  }
  if ($ARGV[$a] eq "-tc" ) {

    $Itcli = 1;
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
    if (( index( $ocli, $searchstring )  != -1 )
	&& $Iocli == 1 ) {
      write;
    } elsif (( index( $tcli, $searchstring )  != -1 )
	     && $Itcli == 1 ) {
      write;
    } elsif ( ( ( index( $calling_tn, $searchstring ) ) != -1 )
	      && $callgnbr eq "-g" ) {
      write;
    } elsif ( ( ( index( $called_tn, $searchstring ) ) != -1 )
	      && $calldnbr eq "-i" ) {
      write;
    } elsif ( ( ( index( $dialed_tn, $searchstring ) ) != -1 )
	      && $dialdnbr eq "-d" ) {
      write;
    } else {

      if ( ($dialdnbr ne "-d") && ($calldnbr ne "-i") &&  ($callgnbr ne "-g")  && ($Iocli != 1) && ($Itcli != 1)) {
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
  $esn        = "";
  $msid       = "";
  $calling_tn = "";  #22 - originating mdn
  $dialed_tn  = "";  #26 - dialed digits
  $called_tn  = "";
  $ct         = "";  #18 - event type
  $ans        = "";
  $o3w        = "";
  $tc         = "";
  $tcf        = "";
  $oss        = "";
  $ocli       = "";
  $tcli       = "";
  $call_ftr   = ""; #29 - service feature

  @Stuff = split( /\|/, $buff );
  my $start_date            = $Stuff[7];
  my $sYear                 = substr( $start_date, 0, 4);
  my $sMnth                 = substr( $start_date, 4, 2 );
  my $sDay                  = substr( $start_date, 6, 2 );

  $date = padString($sMnth,2).'/'.padString($sDay,2).'/'.$sYear;

  $ctime      = $Stuff[8];
  $ctime      = substr($ctime,0,2).':'.substr($ctime,2,2).':'.substr($ctime,4,2);
  $duration   = padString($Stuff[35],6);
  $esn        = $Stuff[20];
  $msid       = $Stuff[19];
  $calling_tn = $Stuff[21];
  $dialed_tn  = $Stuff[25];
  $called_tn  = $Stuff[24];

  $ct         = $Stuff[17];
  $ans        = bitMask($Stuff[33]);
  $o3w        = bitMask($Stuff[32]);
  $tc         = bitMask($Stuff[31]);
  $tcf        = bitMask($Stuff[29]);
  $oss        = "N";

  $ocli       = uc($Stuff[12]);
  $tcli       = uc($Stuff[13]);
  $call_ftr   = $Stuff[28];
  my $swap    = "";

# if this is a voice mail deposit swap originating and receiving parties and override event type

  if(index($call_ftr,"CFW VMD") >= 0) {
    $ct="L-L";   
    $swap=$calling_tn;
    $calling_tn=$dialed_tn;
    $dialed_tn=$swap;
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
