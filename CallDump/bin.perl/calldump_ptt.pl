#!/usr/bin/perl
#####################################################
# script     : callinput_ptt.pl
# description: PMG report
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
format REPORTPTT =
@<<<<<<<<<<<<<< @<<<<<<<<<<<<<< @<<<<<<<<<<<<<< @<<<<<<<<<<<<<< @<<<<<<<<< @<<<<<<<<<<<<<<<<<< @</@</@<<< @<<<<<<<  @<<<<<<<<<  @<<<<<<<<<<< @<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<< @<<<<<< @<<<<< @<<<<<<<<
$msid,$calling_tn,$called_msid,$called_tn,$dialed_tn,$trans_dialed,$st_mon,$st_day,$st_year,$start_time,$durat_secs,$bytes_in,$bytes_out,$ptt_groupid,$ptt_calledip,$ptt_servicetype,$sid,$reas_ind
.

#---INITIALIZE VARIBLES------------------------------
$searchstring = "";
$callgnbr     = "";
$calldnbr     = "";
$dialdnbr     = "";

#---INPUTS-------------------------------------------


for ( $a = 0 ; $a < @ARGV ; $a++ ) {
    if ($ARGV[$a] eq "-s" ) {
        $searchstring = lc( $ARGV[ $a + 1 ] );
        $searchstring =~ s/ //g;
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


#---LOOP THROUGH INPUT FILE AND WRITE DATA RECORDS---
while ( $buff = <STDIN> ) {
    chomp($buff);
    if ( substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR" ) {
        if ( ( index( $buff, $searchstring ) ) != -1 ) {
            formatPTT();
            $~ = REPORTPTT;
            if ( ( ( index( $calling_tn, $searchstring ) ) != -1 )
                && $callgnbr eq "-g" )
            {
                write;
            }
            elsif ( ( ( index( $called_tn, $searchstring ) ) != -1 )
                && $calldnbr eq "-i" )
            {
                write;
            }
            elsif ( ( ( index( $dialed_tn, $searchstring ) ) != -1 )
                && $dialdnbr eq "-d" )
            {
                write;
            }
            elsif (($dialdnbr ne "-i" &&  $calldnbr ne "-d" && $callgnbr ne "-g") &&
		   (
		    ( index( $called_tn, $searchstring )  != -1 ) ||
		    ( index( $calling_tn, $searchstring ) != -1 ) ||
		    ( index( $dialed_tn, $searchstring ) != -1 ) )) {
	      write;
	    }

        }
    }
}

exit(0);

#---FORMAT PTT---------------------------------------
sub formatPTT {
    $msid            = "";
    $calling_tn      = "";
    $called_msid     = "";
    $called_tn       = "";
    $dialed_tn       = "";
    $trans_dialed    = "";
    $start_date      = "";
    $start_time      = "";
    $st_year         = "";
    $st_mon          = "";
    $st_day          = "";
    $durat_secs      = "";
    $bytes_in        = "";
    $bytes_out       = "";
    $ptt_groupid     = "";
    $ptt_calledip    = "";
    $ptt_servicetype = "";
    $sid             = "";
    $reas_ind        = "";
    @Stuff           = split( /,/, $buff );
    $msid            = $Stuff[9];
    $calling_tn      = $Stuff[10];
    $called_msid     = $Stuff[11];
    $called_tn       = $Stuff[12];
    $dialed_tn       = $Stuff[28];
    $trans_dialed    = $Stuff[29];
    ( $start_date, $start_time ) = split( /T/, $Stuff[7] );
    ( $st_year, $st_mon, $st_day ) = split( /-/, $start_date );
    $durat_secs      = $Stuff[15];
    $bytes_in        = $Stuff[14];
    $bytes_out       = $Stuff[13];
    $ptt_groupid     = $Stuff[18];
    $ptt_calledip    = $Stuff[19];
    $ptt_servicetype = $Stuff[26];
    $sid             = $Stuff[22];
    $reas_ind        = $Stuff[20];
}
