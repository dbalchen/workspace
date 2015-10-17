#!/usr/bin/perl

#####################################################
#     Name:          callinput_wtxt.pl
#     Description:   WTXT report
#     Author:        Charlie Jamieson  March 2008
#####################################################

#####################################################
#     Revisions:
#
#####################################################
   
BEGIN {
    push( @INC, $ENV{TLG_BIN} );
}

use POSIX;
use FileHandle;
use warnings;

####################################################
#     REPORT FORMAT                                #
####################################################

format REPORTWTXT =
@<<<<<<<<<<<<<  @<<<<<<<<<<<<<<   @</@</@<<< @<:@<:@<  @<<<<<<<<<<<<     @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$calling_tn,$called_tn,$sMnth,$sDay,$sYear,$sHour,$sMin,$sSec,$ip_address,$text_message
.

####################################################
#     INITIALIZE VARIBLES                          #
####################################################

$searchstring = "";
$callgnbr     = "";
$calldnbr     = "";

####################################################
#    Input Arguments                               #
####################################################

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


#######################################################
#    LOOP THROUGH SWITCH FILE AND WRITE DATA RECORDS  #
#######################################################

while ( $buff = <STDIN> ) 
{
  chomp($buff);

  if ( substr( $buff, 0, 2 ) ne "HR" && substr( $buff, 0, 2 ) ne "TR" )
  {
      formatWTXT();
          if (index( $calling_tn, $searchstring ) != -1 ||  index( $called_tn, $searchstring ) != -1 ) 
          {
              $~ = REPORTWTXT;
              if ( ( ( index( $calling_tn, $searchstring ) ) != -1 )
	               && $callgnbr eq "-g" )
              {
	          write;
              }
              elsif ( ( ( index( $called_tn, $searchstring ) ) != -1 )
                          && $calldnbr eq "-d" )
              {
	          write;
              } 
              elsif ($calldnbr ne "-d" &&  $callgnbr ne "-g") 
              {
	          write;
              }
          }
  }
}

exit(0);

######################################
#   FORMAT WEB SMS RECORD            #
######################################

sub formatWTXT 

{

    $calling_tn            = "";
    $called_tn             = "";
    $call_date             = "";
    $sMnth                 = "";
    $sDay                  = "";
    $sYear                 = "";
    $sHour                 = "";
    $sMin                  = "";
    $sSec                  = "";
    $ip_address            = "";
    $text_message          = "";
    

    @Stuff = split( /\|/, $buff );
    $calling_tn            = $Stuff[0];
    $called_tn             = $Stuff[1];
    $call_date             = $Stuff[2];
    $sMnth                 = substr( $call_date, 4, 2 );
    $sDay                  = substr( $call_date, 6, 2 );
    $sYear                 = substr( $call_date, 0, 4 );
    $sHour                 = substr( $call_date, 8, 2 );
    $sMin                  = substr( $call_date, 10, 2 );
    $sSec                  = substr( $call_date, 12, 2 );
    $ip_address            = $Stuff[3];
    $text_message          = $Stuff[4];

}
