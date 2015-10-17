#!/usr/bin/perl
#####################################################
# script     : callinput_lte.pl
# description: LTE report
# author     : Steven M. Roehl - Mar 7 2014
#####################################################
#Revisions:
#####################################################

BEGIN {
  #    push( @INC, $ENV{TLG_BIN} );
}

use POSIX;
use FileHandle;
use warnings;
#                                                      DURATION                          ROAMING                       CARRIER I.P Adress
# TIMSI               CALLING_NUM      START_DATE      IN_SECONDS   TOTAL_BYTES          IND     SID     BSID          ID
# ---------------     ---------------  -------------   -----------  -------------------  ------- ----    ------------  ------  --------------

#---REPORT FORMAT------------------------------------
format REPORTAAA =
@<<<<<<<<<<<<<<<<<<<@<<<<<<<<<<<<<<  @<<<<<<<<<<<<<  @<<<<<<<<<   @<<<<<<<<<<<<<<<<<<<<@<<<    @<<<<   @<<<<<<<<<<<  @<<<<<  @<<<<<<<<<<<<<<<<<<<<<
$msid,$calling_tn,$startdate,$durationseconds,$totalbytes,$roamInd,$homeSid,$bsid,$carrierID,$ip
.

#---INITIALIZE VARIBLES------------------------------
$searchstring = "";
%CIDhash = createCIDhash();


#---INPUTS-------------------------------------------
#$inputfile = $ARGV[0];
#$inputfile =~ s/ //g;

for ( $a = 0 ; $a < @ARGV ; $a++ ) {
  if ($ARGV[$a] eq "-s" ) {
    $searchstring = lc( $ARGV[ $a + 1 ] );
  }
}

#print STDOUT "\n\n$searchstring, $callgnbr\n\n";

#---OPEN FILE----------------------------------------
#open( STDIN, $inputfile ) || die "cannot open $inputfile\n\n";

#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---
while ( $buff = <STDIN> ) {
  chomp($buff);

  if ( substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR" ) {

    if ( ( index( $buff, $searchstring ) ) != -1 ) {

      reportAAA();

      if(($bytesin + $bytesout) == 0)
	{
	  next;
	}

      $~ = REPORTAAA;

      if ((index( $calling_tn, $searchstring ) != -1 ) || (index( $msid, $searchstring ) != -1 ) || (index( $ip, $searchstring ) != -1) ) {
	write;
      } 
    }
  }
}

#print STDOUT "\n";

#---CLOSE FILE---------------------------------------
close(STDIN);

exit(0);

#---FORMAT AAA---------------------------------------
sub reportAAA {

  #Initialize variables
  $msid            = "";
  $ip              = "";
  $calling_tn      = "";
  $startdate       = "";
  $durationseconds = "";
  $bytesin         = "";
  $bytesout        = "";
  $servopt         = "";
  $roamInd         = "";
  $homeSid         = "";
  $bsid            = "";
  $carrierID       = "";
  $totalbytes      = 0;
 
    formatUFF();

  $totalbytes = $bytesin + $bytesout;

  $carrierID =~ s/  *//g;
  foreach my $key (keys %CIDhash) {
    if ($key eq $carrierID) {
      $carrierID = $CIDhash{"$carrierID"};
    }
  }
}

sub formatUFF
  {

    #Parse records from STDIN into 'Call input Report Fields'
    @Stuff           = split( /\|/, $buff );
    $msid            = $Stuff[53];
    $ip              = $Stuff[22];
    $calling_tn      = $Stuff[21];
    $startdate       = $Stuff[7].$Stuff[8];
    $durationseconds = $Stuff[35];
    $bytesin         = $Stuff[39];
    $bytesout        = $Stuff[40];
    $servopt         = $Stuff[28];
    $roamInd         = $Stuff[36];

     if($roamInd == 1)
     {
 	$roamInd = "R";
     }
     else
     {
 	$roamInd = "H";
     }

    $homeSid         = $Stuff[10];
    $bsid            = $Stuff[14];
    $carrierID       = $Stuff[15];
  }

#------------------------------------------------#
sub createCIDhash {

  my %hsh;

  my $hh = 'cat '.$ENV{'CALL_DUMP_BIN_DIR'}.'/carrierID.dat';

  my @iddata = `$hh`;

  chomp(@iddata);

  my $a = 0;

  for ($a = 0;$a < @iddata;$a++) {
    my ($t1,$t2) = split(",",$iddata[$a]);
    $hsh{$t1} = $t2;
  }

  return %hsh;
}
