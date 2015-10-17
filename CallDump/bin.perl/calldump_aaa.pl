#!/usr/bin/perl
#####################################################
# script     : callinput_aaa.pl
# description: PMG report
# author     : David A. Smith - July 23, 2007
#####################################################
#Revisions:
#Added functionality to check the subscriber ip. Amy Schnelle - 11/2010
#Replaced blank ServeSid with BSid. Amy Schnelle - 05/2011
#####################################################

BEGIN {
  #    push( @INC, $ENV{TLG_BIN} );
}

use POSIX;
use FileHandle;
use warnings;

#---REPORT FORMAT------------------------------------
format REPORTAAA =
@<<<<<<<<<<<<<<<<<<@<<<<<<<<<<<<<<     @<<<<<<<<<<<<<   @<<<<<<<<<   @<<<<<<<<<<<<  @<<<  @<<<<<<   @<<< @<<< @<<<  @<<<<<<<<<<<<<<<<<<<<<  @<<<<<<<<<<<<<<<<
$msid,$calling_tn,$startdate,$durationseconds,($bytesin+$bytesout),$servopt,$roamInd,$sid,$nid,$cell,$carrierID,$sessionID
.

#---INITIALIZE VARIBLES------------------------------
$searchstring = "";
$callgnbr     = "";
$filetype = "AAA";

%CIDhash = createCIDhash();


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
  if ($ARGV[$a] eq "-fn" ) {

    if (index($ARGV[$a+1],"FUFF") != -1) {
      $filetype = "UFF";
    }

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

      reportAAA();
      $~ = REPORTAAA;

      if ($callgnbr eq "" || ((index( $calling_tn, $searchstring ) != -1 ) && $callgnbr eq "-g")) {
	write;
      } elsif (index( $ip, $searchstring ) != -1) {
	$calling_tn = $ip;
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
  $bSid            = "";
  $sid             = "";
  $nid             = "";
  $cell            = "";
  $carrierID       = "";
  $sessionID       = "";

  if ($filetype eq "AAA") {
    formatAAA();
  } else {
    formatUFF();
  }

#  print "BSID = $bSid\n";
  $sid = substr($bSid,0,4);
  $nid = substr($bSid,4,4);
  $cell = substr($bSid,8,4);


  $carrierID =~ s/  *//g;
  foreach my $key (keys %CIDhash) {
    if ($key eq $carrierID) {
      $carrierID = $CIDhash{"$carrierID"};
    }
  }
}

sub formatAAA
  {

    #Parse records from STDIN into 'Call input Report Fields'
    @Stuff           = split( /,/, $buff );
    $msid            = $Stuff[3];
    $ip              = $Stuff[17];
    $calling_tn      = $Stuff[4];
    $startdate       = $Stuff[5];
    $durationseconds = $Stuff[6];
    $bytesin         = $Stuff[7];
    $bytesout        = $Stuff[8];
    $servopt         = $Stuff[30];
    $roamInd         = $Stuff[31];
    $homeSid         = $Stuff[32];
    $bSid            = $Stuff[23];
    $carrierID       = $Stuff[26];
    $sessionID       = $Stuff[2];
  }

sub formatUFF
  {

    #Parse records from STDIN into 'Call input Report Fields'
    @Stuff           = split( /\|/, $buff );
    $msid            = $Stuff[19];
#    $ip              = $Stuff[22];
    $calling_tn      = $Stuff[22];
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
    $bSid            = $Stuff[14];
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
