#!/usr/bin/perl
#####################################################
# script     : callinput_aplx.pl
# description: APLX report
# author     : David A. Smith - July 23, 2007
#####################################################
#Revisions:
#Amy Schnelle: Updated call_to_tn display to print all characters-05/11
#####################################################

BEGIN {
    push( @INC, $ENV{TLG_BIN} );
}

use POSIX;
use FileHandle;
#use warnings;

#---REPORT FORMAT------------------------------------
format REPORTAPLX =
@<<<<<  @<<<   @< @<< @<<<<<<<<< @<<<<<<<<<< @<<<<<<<<< @<<<<<<<<<< @<<<<<<< @<<<< @<<<<<<<<<<<<<< @<<<  @<<<  @<<<<<<
$sCode,$cType,$aStat,$sFeat,$calling_tn,$esn,$msid,$sDate,$sTime,$durat,$called_tn,$ocli,$tcli,$switch 
.

#---INITIALIZE VARIBLES------------------------------
$searchstring = "";
$callgnbr     = "";
$calldnbr     = "";
$Iocli = 0;
$Itcli = 0;
$switch = "";

#---INPUTS-------------------------------------------

for ( $a = 0 ; $a < @ARGV ; $a++ ) {
  if ($ARGV[$a] eq "-s" ) {
    $searchstring = lc( $ARGV[ $a + 1 ] );
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
    if ($ARGV[$a] eq "-d" ) {
        $calldnbr = "-d";
    }
    if ($ARGV[$a] eq "-i" ) {
        $calldnbr = "-d";
    }
}



#open( STDIN, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

while ( $buff = <STDIN> ) {
  chomp($buff);
#  if ( substr( $buff, 11, 2 ) ne "aa" && substr( $buff, 11, 2 ) ne "aa" ) {
    if ( ( index( $buff, $searchstring ) ) != -1 ) {
      formatAPLX();
      $~ = REPORTAPLX;

      if ($exact) {
	exactSearch();
      } else {
	standardSearch();
      }
    }
#  }
}

sub standardSearch {
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
	    && $calldnbr eq "-d" ) {
    write;
  } else {
    if (($calldnbr ne "-d") && ($callgnbr ne "-g")  && ($Iocli != 1) && ($Itcli != 1) ) {
      write;
    }

  }
}

sub exactSearch {
  $callingtn = $calling_tn;
  $callingtn =~ s/  *//g;
  $callingtn =~ s/^00*//g;

  $calledtn = $called_tn;
  $calledtn =~ s/  *//g;
  $calledtn =~  s/^00*//g;

#  if ($callingtn eq $searchstring) {
#    write;
#  } elsif ($calledtn eq $searchstring) {
#    write;
#  }

  if ( ($callingtn eq $searchstring)  && $callgnbr eq "-g" ) {
#      write;
      print "$buff\n";
    } elsif ( ( $calledtn eq $searchstring ) && $calldnbr eq "-i") {
      write;
    } else {
	if (($calldnbr ne "-d") &&  ($callgnbr ne "-g")) {
          write;
        }

     }

}

sub pad2string {
  my ($string,$length,$padwith) = @_;

  while (length($string) < $length) {
    $string = $padwith.$string;
  }
  return $string;
}

#---CLOSE FILE---------------------------------------

#---FORMAT APLX---------------------------------------
sub formatAPLX {

    #Initialize variables
    $sCode        = "";
    $cType        = "";
    $aStat        = "";
    $sFeat        = "";
    $calling_tn   = "";
    $msid         = "";
    $sDate        = "";
    $sTime        = "";
    $durat        = "";
    $called_tn    = "";
    $esn          = "";
    $ocli         = "";
    $tcli         = "";
    $octal_mfg    = "";
    $octal_mfg    = "";
    $decimal_esn  = "";
    $expanded_mfg = "";
    $expanded_esn = "";
    $buff =~ s/  */ /g;


    ($sCode,$cType,$aStat,$sFeat,$calling_tn,
     $esn,$msid,$sDate,$sTime,$durat,$called_tn,
     $ocli,$tcli) = split(/ /,$buff);

    $esn = sprintf "%11o", $esn;
    $octal_mfg = substr( $esn, 0, 3 );
    $octal_esn = substr( $esn, 3, 8 );
    $decimal_esn  = oct $octal_esn;
    $decimal_mfg  = oct $octal_mfg;
    $expanded_mfg = sprintf "%03d", $decimal_mfg;
    $expanded_esn = sprintf "%08d", $decimal_esn;
    $esn          = "$expanded_mfg$expanded_esn";

}
