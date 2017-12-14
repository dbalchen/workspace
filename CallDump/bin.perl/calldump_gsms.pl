#!/usr/bin/perl
#####################################################
# script     : calldump_gsms.pl
# description: GSM  SMS report
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
format REPORTMOT =
@<<<<<  @<<<<<<<<<<<<<  @<<<<<<<<<<<<<<  @<<<<<<<<< @<<<<<<<  @<<<<<<<<< @<<<<<<<  @<<<  @<<<<<<<<<<<<<< @<<<<<<<<<<<<<<
$record_type,$calling_tn,$called_tn,$start_date,$sdate_time,$end_date,$edate_time,$call_termination_code,$esn,$msid
.

#---INITIALIZE VARIBLES------------------------------
$inputfile    = "";
$searchstring = "";
$callgnbr     = "";
$calldnbr     = "";


#---INPUTS-------------------------------------------
#$inputfile = $ARGV[0];
#$inputfile =~ s/ //g;

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
}

  #---OPEN FILE----------------------------------------
#  open( STDIN, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---

while ( $buff = <STDIN> ) {
  chomp($buff);
  if ( substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR" ) {
    formatMOT();
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

#---CLOSE FILE---------------------------------------
#close(STDIN);


exit(0);

#---FORMAT MOT---------------------------------------
sub formatMOT {

    #Initialize variables
    $record_type           = "";
    $calling_tn            = "";
    $called_tn             = "";
    $start_date            = "";
    $end_date              = "";
    $call_termination_code = "";
    $esn                   = "";
    $msid                  = "";
    $sdate_time            = "";
    $edate_time            = "";

    #Parse records from STDIN into 'Call input Report Fields'
    @Stuff = split( /\|/, $buff );
    $record_type = $Stuff[0];
    $calling_tn            = $Stuff[1];
    $called_tn             = $Stuff[2];
    $start_date            = substr($Stuff[3],0,10);
    $sdate_time            = substr($Stuff[3],10);
    $end_date              = substr($Stuff[4],0,10);
    $edate_time            = substr($Stuff[4],10);
    $call_termination_code = $Stuff[5];
	$esn                   = $Stuff[6];
	$msid                  = $Stuff[7];
}
