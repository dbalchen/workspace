#!/usr/bin/perl
#####################################################
# script     : calldump_12.pl
# description: 12 report
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
@<<<<<<<<<<@<<<<<<<<<@<<<<<  @<<<<<<<<<<  @<<<<<<<<< @<<<<<<<<< @<<<<<<<<<<<<<<< @<<<<<<<<<<<< @<<  @  @  @  @  @  @    @<<< @<<< @<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$date,$ctime,$duration,$esn,$msid,$calling_tn,$dialed_tn,$called_tn,$ct,$cd,$ans,$o3w,$tc,$tcf,$oss,$ocli,$tcli,$switch,$srvFeat
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
  #open( STDIN, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

  #---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---

while ( $buff = <STDIN> ) {
  chomp($buff);
  if ( substr( $buff, 11, 2 ) ne "aa" && substr( $buff, 11, 2 ) ne "aa" ) {
    if ( ( index( $buff, $searchstring ) ) != -1 ) {
      format12();
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
      if (( index( $ocli, uc($searchstring) )  != -1 )
	  && $Iocli == 1 ) {
	write;
      } elsif (( index( $tcli, uc($searchstring) )  != -1 )
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
    $oss        = "";
    $ocli       = "";
    $tcli       = "";
    $srvFeat    = "NA";
    $cd         = "*";
    #Parse records from STDIN into 'Call input Report Fields'
    $date       = substr( $buff, 0,   11 );
    my($mm,$dd,$yyyy) = split(/\//,$date);

    $mm = padString($mm);
    $dd = padString($dd);

    $date = $mm.'/'.$dd.'/'.$yyyy;
    
    $ctime      = substr( $buff, 11,  8 );
    $duration   = substr( $buff, 21,  8 );
    $esn        = substr( $buff, 29,  13 );
    $msid       = substr( $buff, 42,  11 );
    $calling_tn = substr( $buff, 53,  11 );
    $dialed_tn  = substr( $buff, 64,  17 );
    $dialed_tn  =~ s/f/ /g; 
    $called_tn  = substr( $buff, 81,  15 );
    $called_tn  =~ s/f/ /g;
    $ct         = substr( $buff, 96,  5 );
    $ans        = substr( $buff, 101, 3 );
    $o3w        = substr( $buff, 104, 3 );
    $tc         = substr( $buff, 107, 3 );
    $tcf        = substr( $buff, 110, 3 );
    $oss        = substr( $buff, 113, 5 );
    $ocli       = uc(substr( $buff, 118, 5 ));
    $tcli       = uc(substr( $buff, 123, 4 ));
}


sub padString {

$string2pad = shift;

if(length($string2pad) < 2)
  {
    $string2pad = "0".$string2pad;
  }

return $string2pad;
}
