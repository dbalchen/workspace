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
@<<<<<<<<<<@<<<<<<<<<@<<<<<  @<<<<<<<<< @<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<< @  @  @  @  @  @  @<<<<<<<<<<<<<<<<<< @<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$date,$ctime,$duration,$calling_tn,$dialed_tn,$called_tn,$cd,$ans,$o3w,$tc,$tcf,$oss,$enodeb,$switch,$srvFeat
.


#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---

while ( $buff = <STDIN> ) {
  chomp($buff);
      report12();
      $~ = REPORT12;
      write;
}


exit(0);

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

  if (length($dialed_tn) > 15) {
    $prefix = substr($dialed_tn,0,-15);
    $dialed_tn = substr($dialed_tn,-15);
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

