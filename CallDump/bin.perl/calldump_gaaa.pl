#!/usr/bin/perl
#####################################################
# script     : calldumo_gaaa.pl
# description: GSM Data report
# author     : David G. Balchen - July 16, 2010
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
format REPORTAAA =
@<<<<<<<<<<<<<<<<<<@<<<<<<<<<<<<<<    @<<<<<<<<<<<<<    @<<<<<<<<<   @<<<<<<<<<<<<  @<<<<<<<<<<<<@<<<<<<<<<<<<<<<
$msid,$calling_tn,$startdate,$durationseconds,$bytesin,$bytesout,$phoneip
.

#---INITIALIZE VARIBLES------------------------------
#$inputfile    = "";
$searchstring = "";
$callgnbr     = "";


#---INPUTS-------------------------------------------
#$inputfile = $ARGV[0];
#$inputfile =~ s/ //g;

for ( $a = 0 ; $a < @ARGV ; $a++ ) {
  if ($ARGV[$a] eq "-s" ) {
    $searchstring = lc( $ARGV[ $a + 1 ] );
  }
  if ($ARGV[$a] eq "-g" ) {
    $callgnbr = "-g";
  }

}

#print STDOUT "\n\n$searchstring, $callgnbr\n\n";

#---OPEN FILE----------------------------------------
#open( STDIN, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---
while ( $buff = <STDIN> ) {
  chomp($buff);

  if ( substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR" ) {

    if ( ( index( $buff, $searchstring ) ) != -1 ) {

      formatAAA();
      $~ = REPORTAAA;

      if ($callgnbr eq "" || ((index( $calling_tn, $searchstring ) != -1 ) && $callgnbr eq "-g")) {

	write;
      }
    }
  }
}

#print STDOUT "\n";

#---CLOSE FILE---------------------------------------
#close(STDIN);

exit(0);

#---FORMAT AAA---------------------------------------
sub formatAAA {

    #Initialize variables
    $msid            = "";
    $calling_tn      = "";
    $startdate       = "";
    $durationseconds = "";
    $bytesin         = "";
    $bytesout        = "";
    $phoneip         = "";


    #Parse records from STDIN into 'Call input Report Fields'
    @Stuff           = split( /\|/, $buff );
    $msid            = $Stuff[0];
    $calling_tn      = $Stuff[1];
    $startdate       = $Stuff[2];
    $durationseconds = $Stuff[3];
    $bytesin         = $Stuff[4];
    $bytesout        = $Stuff[5];
    $phoneip         = $Stuff[6];

}
