#!/usr/bin/perl
#####################################################
# script     : calldump_gnti.pl
# description: GSM voice report
# author     : David G. Balchen July 6th 2010
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
format REPORTVOICE =
@<<<<<<<<<<@<<<<<<<<<@<<<<<       @<<<<<<<<<<<<<< @<<<<<<<<<<<<<< @<<<<<<<<<<<<< @<<<<<<<<<<<<<   @<<<<<<<<<<<<< @<<  @   @  @  @  @<<<<< @<<<<< @<<<<< @<<<<<
$date,$ctime,$duration,$esn,$msid,$calling_tn,$dialed_tn,$called_tn,$ct,$ans,$o3w,$tc,$tcf,$oloc,$ocid,$tloc,$tcid
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

  if ($ARGV[$a] eq "-i" ) {
    $calldnbr = "-i";
  }

  if ($ARGV[$a] eq "-d" ) {
    $dialdnbr = "-d";
  }
}

  #print STDOUT "\n\n$inputfile, $searchstring, $cellsite, $callgnbr, $calldnbr, $dialdnbr\n\n";

  #---OPEN FILE----------------------------------------
#  open( STDIN, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

  #---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---

while ( $buff = <STDIN> ) {
  chomp($buff);
  if ( substr( $buff, 11, 2 ) ne "aa" && substr( $buff, 11, 2 ) ne "aa" ) {
    if ( ( index( $buff, $searchstring ) ) != -1 ) {
      format12();
      $~ = REPORTVOICE;

      if ($exact) {
	exactSearch();
      } else {
	standardSearch();
      }

    }
  }
}

#---CLOSE FILE---------------------------------------
#close(STDIN);
exit(0);

  sub standardSearch
    {
      if ((( index( $oloc, $searchstring )  != -1 ) || ( index( $ocid, $searchstring )  != -1 ))
	  && $Iocli == 1 ) {
	write;
      } elsif ((( index( $tloc, $searchstring )  != -1 ) || ( index( $tcid, $searchstring )  != -1 ))
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


#---FORMAT 12---------------------------------------
sub format12 {

    #Initialize variables
    $date       = "";
    $ctime      = "";
    $duration   = "";
    $esn        = "";
    $msid       = "";
    $calling_tn = "";
    $dialed_tn  = "";
    $called_tn  = "";
    $ct         = "";
    $ans        = "";
    $o3w        = "";
    $tc         = "";
    $tcf        = "";
    $ocli       = "";
    $tcli       = "";

    ($date,$duration,$esn,$msid,$calling_tn,$dialed_tn,$called_tn,$ct,$ans,$o3w,$tc,$tcf,$oloc,$ocid,$tloc,$tcid) = split(/\|/,$buff);
    ($date,$ctime) = split(/ /,$date);

}
