#! /usr/local/bin/perl

use Time::Piece;
use Time::Seconds;

#$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
$ENV{'REC_HOME'} = '/apps/ebi/ebiap1/bin/roamRecon/';

my $date  = $ARGV[0];

my $today        = Time::Piece->strptime( "$date", "%Y%m%d" );
my $yesterday    = $today - ONE_DAY;
my $daybefore    = $yesterday - ONE_DAY;
my $tomorrow     = $today + ONE_DAY;
my $dayafter     = $tomorrow + ONE_DAY;
my $dayafterthat = $dayafter + ONE_DAY;
my $dayafterthatPush = $dayafterthat + ONE_DAY;

my $dayMon = $daybefore->monname;
$daybefore =
    $daybefore->year . "-"
  . pad( $daybefore->mon,  '0', 2 ) . "-"
  . pad( $daybefore->mday, '0', 2 );

my $yesMon = $yesterday->monname;
$yesterday =
    $yesterday->year . "-"
  . pad( $yesterday->mon,  '0', 2 ) . "-"
  . pad( $yesterday->mday, '0', 2 );

my $todMon = $today->monname;
$today =
    $today->year . "-"
  . pad( $today->mon,  '0', 2 ) . "-"
  . pad( $today->mday, '0', 2 );

my $tomMon = $tomorrow->monname;
$tomorrow =
    $tomorrow->year . "-"
  . pad( $tomorrow->mon,  '0', 2 ) . "-"
  . pad( $tomorrow->mday, '0', 2 );

my $dayaMon = $dayafter->monname;
$dayafter =
    $dayafter->year . "-"
  . pad( $dayafter->mon,  '0', 2 ) . "-"
  . pad( $dayafter->mday, '0', 2 );

my $dayafMon = $dayafterthat->monname;
$dayafterthat =
    $dayafterthat->year . "-"
  . pad( $dayafterthat->mon,  '0', 2 ) . "-"
  . pad( $dayafterthat->mday, '0', 2 );

my $dayafpMon = $dayafterthatPush->monname;
$dayafterthatPush =
    $dayafterthatPush->year . "-"
  . pad( $dayafterthatPush->mon,  '0', 2 ) . "-"
  . pad( $dayafterthatPush->mday, '0', 2 );
  

my $inGrep = "egrep '^$daybefore|^$yesterday|^$today|^$tomorrow' |awk -F'".'"'."' -vOFS='".'"'."' '{for(i=2; i<=NF; i+=2) ".'gsub("\t", "", $i)} 1'."'";
print "$inGrep\n";

my $hh = "cat $ENV{'REC_HOME'}/IncollectDCH_data.csv.all | $inGrep | sort -u > $ENV{'REC_HOME'}/IncollectDCH_data.csv";
system($hh);

$hh = "cat $ENV{'REC_HOME'}/IncollectDCH_voice.csv.all | $inGrep | sort -u > $ENV{'REC_HOME'}/IncollectDCH_voice.csv";
system($hh);

$hh = "cat $ENV{'REC_HOME'}/IncollectDCH_GSM.csv.all | $inGrep | sort -u > $ENV{'REC_HOME'}/IncollectDCH_GSM.csv";
system($hh);

$inGrep = "egrep '^$yesterday|^$today|^$tomorrow|^$dayafter|^$dayafterthat' |awk -F'".'"'."' -vOFS='".'"'."' '{for(i=2; i<=NF; i+=2) ".'gsub("\t", "", $i)} 1'."'";
print "$inGrep\n";
$hh =
"cat $ENV{'REC_HOME'}/OutcollectDCH_voice.csv.all | $inGrep | sort -u > $ENV{'REC_HOME'}/OutcollectDCH_voice.csv";
system($hh);

open(IN,"<$ENV{'REC_HOME'}/IncollectDCH_GSM.csv.all") || exit(1);
open(OUT,">$ENV{'REC_HOME'}/IncollectDCH_GSM.csv") || exit(1);

while(my $buff = <IN>)
{
	chomp($buff);
	my @arry = split( /\t/, $buff );

	if (   ( $arry[1] eq $today )
		|| ( $arry[1] eq $yesterday )
		|| ( $arry[1] eq $tomorrow )
		|| ( $arry[1] eq $dayafter ) )
	{
		print OUT "$buff\n";
	}
}

close(IN);
close(OUT);

my @arry = split("-", $yesterday);
$yesterday = ($arry[2]-0)."-$yesMon-".($arry[0]-2000);
$yesterday = pad($yesterday,'0',9);

@arry = split("-", $today);
$today = ($arry[2]-0)."-$todMon-".($arry[0]-2000);
$today = pad($today,'0',9);

@arry = split("-", $tomorrow);
$tomorrow = ($arry[2]-0)."-$tomMon-".($arry[0]-2000);
$tomorrow = pad($tomorrow,'0',9);

@arry = split("-", $dayafter);
$dayafter = ($arry[2]-0)."-$dayaMon-".($arry[0]-2000);
$dayafter = pad($dayafter,'0',9);

@arry = split("-", $dayafterthat);
$dayafterthat = ($arry[2]-0)."-$dayafMon-".($arry[0]-2000);
$dayafterthat = pad($dayafterthat,'0',9);

@arry = split("-", $dayafterthatPush);
$dayafterthatPush = ($arry[2]-0)."-$dayafpMon-".($arry[0]-2000);
$dayafterthatPush = pad($dayafterthatPush,'0',9);


open(IN,"<$ENV{'REC_HOME'}/tnsIncollect.csv.all") || exit(1);
open(OUT,">$ENV{'REC_HOME'}/tnsIncollect.csv") || exit(1);

while(my $buff = <IN>)
{
	chomp($buff);
	my @arry = split(/\t/,$buff);
	
	if(($arry[5] eq $today) || ($arry[5] eq $yesterday) || ($arry[5] eq $tomorrow) || ($arry[5] eq $dayafter))
	{
		print OUT "$buff\n";
	}
}

close(IN);
close(OUT);


open(IN,"<tnsOutcollect.csv.all") || exit(1);
open(OUT,">tnsOutcollect.csv") || exit(1);

while(my $buff = <IN>)
{
	chomp($buff);
	my @arry = split(/\t/,$buff);
	
	if(($arry[5] eq $today) || ($arry[5] eq $yesterday) || ($arry[5] eq $tomorrow) || ($arry[5] eq $dayafter) || ($arry[5] eq $dayafterthat) || ($arry[5] eq $dayafterthatPush))
	{
		print OUT "$buff\n";
	}
}

close(IN);
close(OUT);

exit(0);

sub pad {

  my ( $padString, $padwith, $length ) = @_;

  while ( length($padString) < $length ) {
    $padString = $padwith . $padString;
  }

  return $padString;

}
