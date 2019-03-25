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
@<<<<<<<<<<@<<<<<<<<<@<<<<<  @<<<<<<<<<<  @<<<<<<<<< @<<<<<<<<< @<<<<<<<<<<<<< @<<<<<<<<<<<<  @<<<<<<<<<<<<<< @<<  @  @  @  @  @  @    @<<< @<<< @<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$date,$ctime,$duration,$esn,$msid,$calling_tn,$dialed_tn,$tmsid,$called_tn,$ct,$cd,$ans,$o3w,$tc,$tcf,$oss,$ocli,$tcli,$switch,$srvFeat
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

  @backdoor = `cat /home/dbalchen/Desktop/backdoor.db`;

  #---INPUTS-------------------------------------------
  $inputfile = "/home/dbalchen/Desktop/SCDR2_FUFF_ID060000_T20190318050500.DAT";
  $inputfile =~ s/ //g;

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
      $switch = uc( $ARGV[ $a + 1 ] );
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
  open( STDIN, $inputfile ) || die "cannot open $inputfile\n\n";

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
    $srvFeat    = "";
    $cd         = "";
    $tmsid = "";



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
    $tmsid      = $Stuff[23];
    $calling_tn = $Stuff[21];
    $dialed_tn  = $Stuff[25];
    $called_tn  = $Stuff[24];

    $ct         = $Stuff[17];
    $ans        = bitMask($Stuff[33]);
    $o3w        = bitMask($Stuff[32]);
    $tc         = bitMask($Stuff[31]);
    $tcf        = bitMask($Stuff[29]);
    $oss        = "N";

    $ocli       = uc(remCFW($Stuff[12]));
    $tcli       = uc(remCFW($Stuff[13]));

    $cd = $Stuff[18];

    if ($cd eq "MO") {
      $cd = "O";
    } elsif ($cd eq "MT") {
      $cd = "I";
    }
    $srvFeat = $Stuff[28];

     my $prefix = "";
# Things can change here...
     if (length($dialed_tn) > 10) {
       $prefix = substr($dialed_tn,0,-10);
       $dialed_tn = substr($dialed_tn,-10);
     }

     if (find_tldn($called_tn) eq "TLDN") {
       my $tmp = $calling_tn;
       $calling_tn = $dialed_tn;
       $dialed_tn = $tmp;
     } elsif (find_tldn($dialed_tn) eq "TLDN") {
       my $tmp = $called_tn;
       $called_tn = $dialed_tn;
       $dialed_tn = $tmp;
     }

    
    if ((index($srvFeat,"VMD") >= 0) && (index($ct,"L-L") >= 0))
    {
       my $tmp = $calling_tn;
       $calling_tn = $dialed_tn;
       $dialed_tn = $tmp;
    }
       
     $dialed_tn = $prefix.$dialed_tn;

  }

   sub remCFW {

     my $bad = shift;

     if (index($bad,"CFW") >= 0) {
       $bad = substr($bad,-5);
     }

     return $bad;
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


   sub find_tldn
     {
       my $fmsid = shift;
       my $found_tldn = "NULL";

	 for (my $a = 0;$a < @backdoor;$a = $a + 1) {
	   my($st,$ed) = split(/,/,$backdoor[$a]);
	   if ($fmsid >= $st && $fmsid <= $ed) {
	       $found_tldn = "TLDN";
	   last;
	   } 
	 }

        chomp($found_tldn);
       return $found_tldn;
     }
