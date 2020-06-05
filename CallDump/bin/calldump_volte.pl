#!/usr/bin/perl
#####################################################
# script     : calldump_voLTE.pl
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

#---INITIALIZE VARIBLES------------------------------
#$inputfile    = "";

my $searchstring = "";
my $callgnbr     = "";
my $calldnbr     = "";
my $dialdnbr     = "";
my $switch       = "Volte";
my $exact        = 0;
my $Iocli        = 0;
my $enodeb       = "";
my $buff         = "";
my $date         = "";
my $ctime        = "";
my $duration     = "";
my $calling_tn   = "";
my $dialed_tn    = "";
my $called_tn    = "";
my $ct           = "";
my $ans          = "";
my $o3w          = "";
my $tc           = "";
my $tcf          = "";
my $oss          = "";
my $srvFeat      = "";
my $cd           = "";
my $ocli         = "";
my $tcli         = "";

#---REPORT FORMAT------------------------------------
#format REPORT12 =
#@<<<<<<<<<<@<<<<<<<<<@<<<<<  @<<<<<<<<< @<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<< @  @  @  @  @  @  @<<<<<<<<<<<<<<<<<< @<<<<< @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
#$date,$ctime,$duration,$calling_tn,$dialed_tn,$called_tn,$cd,$ans,$o3w,$tc,$tcf,$oss,$enodeb,$switch,$srvFeat
#.

format REPORT12 =
@<<<<<<<<<
$ctime
.

#---REPORT FORMAT------------------------------------

$~ = REPORT12;

#---INPUTS-------------------------------------------

for ( $a = 0 ; $a < @ARGV ; $a++ ) {

  if ( $ARGV[$a] eq "-s" ) {
    $searchstring = uc( $ARGV[ $a + 1 ] );
    $searchstring =~ s/ //g;

    if ( index( $searchstring, "=" ) >= 0 ) {
      $exact = 1;
      $searchstring =~ s/=//g;
    }
  }

  if ( $ARGV[$a] eq "-g" ) {
    $callgnbr = "-g";
  }

  if ( $ARGV[$a] eq "-i" ) {
    $calldnbr = "-i";
  }

  if ( $ARGV[$a] eq "-d" ) {
    $dialdnbr = "-d";
  }

  if ( $ARGV[$a] eq "-oc" ) {

    $Iocli = 1;

  }
  if ( $ARGV[$a] eq "-tc" ) {
    $Iocli = 1;
  }

}

if (( $Iocli == 1) && (($callgnbr ne "-g") && ($callgnbr ne "-d") && ($dialdnbr ne "-i") )) {
	$searchstring = '-' . $searchstring . '-';
}

#print STDOUT "\n\n$inputfile, $searchstring, $cellsite, $callgnbr, $calldnbr, $dialdnbr\n\n";

# $ARGV[0] = "/m01/switchb/tas/STAS1_FUFF_ID186242_T20200310202709.DAT";

#---OPEN FILE----------------------------------------
# open( STDIN, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---

while ( $buff = <STDIN> ) {
	chomp($buff);
	if ( substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR" ) {

		report12();
		if ($exact) {
			exactSearch();
		}
		else {
			standardSearch();
		}

	}
}

sub standardSearch {

    my $println = '';
    
        $date =~ s/^\s+//;

	if ( ( index( $enodeb, $searchstring ) != -1 ) && ( $Iocli == 1 ) ) {
		 $println = sprintf("%11s %10s %6s  %10s %16s %16s %1s  %1s  %1s  %1s  %1s %1s %19s %6s %33s",
			$date,      $ctime, $duration, $calling_tn, $dialed_tn,
			$called_tn, $cd,    $ans,      $o3w,        $tc,
			$tcf,       $oss,   $enodeb,   $switch,     $srvFeat
		     );

		 $println =~ s/^\s//;
		 
		 print("$println\n");

	}
	elsif ( ( ( index( $calling_tn, $searchstring ) ) != -1 )
		&& $callgnbr eq "-g" )
	{
	
 $println = sprintf("%11s %10s %6s  %10s %16s %16s %1s  %1s  %1s  %1s  %1s %1s %19s %6s %33s",
			$date,      $ctime, $duration, $calling_tn, $dialed_tn,
			$called_tn, $cd,    $ans,      $o3w,        $tc,
			$tcf,       $oss,   $enodeb,   $switch,     $srvFeat
		     );

		 $println =~ s/^\s//;
		 
		 print("$println\n");
	}
	elsif ( ( ( index( $called_tn, $searchstring ) ) != -1 )
		&& $calldnbr eq "-i" )
	{
$println = sprintf("%11s %10s %6s  %10s %16s %16s %1s  %1s  %1s  %1s  %1s %1s %19s %6s %33s",
			$date,      $ctime, $duration, $calling_tn, $dialed_tn,
			$called_tn, $cd,    $ans,      $o3w,        $tc,
			$tcf,       $oss,   $enodeb,   $switch,     $srvFeat
		     );

		 $println =~ s/^\s//;
		 
		 print("$println\n");

	}
	elsif ( ( ( index( $dialed_tn, $searchstring ) ) != -1 )
		&& $dialdnbr eq "-d" )
	{

$println = sprintf("%11s %10s %6s  %10s %16s %16s %1s  %1s  %1s  %1s  %1s %1s %19s %6s %33s",
			$date,      $ctime, $duration, $calling_tn, $dialed_tn,
			$called_tn, $cd,    $ans,      $o3w,        $tc,
			$tcf,       $oss,   $enodeb,   $switch,     $srvFeat
		     );

		 $println =~ s/^\s//;
		 
		 print("$println\n");

	}
}

sub exactSearch {
	$callingtn = $calling_tn;
	$callingtn =~ s/  *//g;

	$calledtn = $called_tn;
	$calledtn =~ s/  *//g;

	$dialedtn = $dialed_tn;
	$dialedtn =~ s/  *//g;

	if ( ( $callingtn eq $searchstring ) && $callgnbr eq "-g" ) {
		printf(
"%11s%10s%6s %10s %16s %16s %1s %1s %1s %1s %1s %1s %19s %6s %33s\n",
			$date,      $ctime, $duration, $calling_tn, $dialed_tn,
			$called_tn, $cd,    $ans,      $o3w,        $tc,
			$tcf,       $oss,   $enodeb,   $switch,     $srvFeat
		);
	}
	elsif ( ( $calledtn eq $searchstring ) && $calldnbr eq "-i" ) {
		printf(
"%11s%10s%6s %10s %16s %16s %1s %1s %1s %1s %1s %1s %19s %6s %33s\n",
			$date,      $ctime, $duration, $calling_tn, $dialed_tn,
			$called_tn, $cd,    $ans,      $o3w,        $tc,
			$tcf,       $oss,   $enodeb,   $switch,     $srvFeat
		);
	}
	elsif ( ( $dialedtn eq $searchstring ) && $dialdnbr eq "-d" ) {
		printf(
"%11s%10s%6s %10s %16s %16s %1s %1s %1s %1s %1s %1s %19s %6s %33s\n",
			$date,      $ctime, $duration, $calling_tn, $dialed_tn,
			$called_tn, $cd,    $ans,      $o3w,        $tc,
			$tcf,       $oss,   $enodeb,   $switch,     $srvFeat
		);
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

	my @Stuff      = split( /\|/, $buff );
	my $start_date = $Stuff[7];
	my $sYear      = substr( $start_date, 0, 4 );
	my $sMnth      = substr( $start_date, 4, 2 );
	my $sDay       = substr( $start_date, 6, 2 );

	$date = padString( $sMnth, 2 ) . '/' . padString( $sDay, 2 ) . '/' . $sYear;

	$ctime = $Stuff[8];
	$ctime =
	    substr( $ctime, 0, 2 ) . ':'
	  . substr( $ctime, 2, 2 ) . ':'
	  . substr( $ctime, 4, 2 );
	$duration   = padString( $Stuff[35], 6 );
	$calling_tn = $Stuff[21];
	$dialed_tn  = $Stuff[25];
	$called_tn  = $Stuff[24];

	$ans = bitMask( $Stuff[33] );
	$o3w = bitMask( $Stuff[32] );
	$tc  = bitMask( $Stuff[31] );
	$tcf = bitMask( $Stuff[29] );
	$oss = "N";

	$cd   = $Stuff[18];
	$ocli = uc( $Stuff[12] );
	$tcli = uc( $Stuff[13] );

	if ( $cd eq "MO" ) {
		$cd     = "O";
		$enodeb = $ocli;
	}
	elsif ( $cd eq "MT" ) {
		$cd     = "I";
		$enodeb = $tcli;
	}

	$enodeb =
	    $Stuff[15] . "-"
	  . hex( substr( $enodeb, 0,  6 ) ) . "-"
	  . hex( substr( $enodeb, -2, 2 ) );

	$srvFeat = $Stuff[28];

	$prefix = "";

	if ( length($dialed_tn) > 15 ) {
		$prefix = substr( $dialed_tn, 0, -15 );
		$dialed_tn = substr( $dialed_tn, -15 );
	}

}

sub padString {

	( $string2pad, $hm ) = @_;

	while ( length($string2pad) < $hm ) {
		$string2pad = "0" . $string2pad;
	}

	return $string2pad;
}

sub bitMask {
	$truth = shift;

	if ( $truth eq "1" ) {
		$truth = "Y";
	}
	else {
		$truth = "N";
	}
	return $truth;
}
