#! /usr/bin/perl
use DBI;

$ARGV[0] = '/home/dbalchen/Desktop/SDIRI_FCIBER';

$ARGV[1] = '20170211';

my $hh = "cat $ARGV[0]*$ARGV[1]* | grep '^98' | sort -u | cut -b 3-8 | sort -u";
my @results = `$hh`;

my $grp = '';

foreach my $result (@results) {
	chomp($result);
	$result = "20" . $result;
	$result = makeDate($result);
	$grp    = $grp . "|^$result";
}

$grp = "'" . substr( $grp, 1 ) . "'";

my $dchfile = '/home/dbalchen/Desktop/IncollectDCH_voice.csv';

$hh = "cat $dchfile | egrep $grp |";

my %serSidSeq = {};

open( PIPE, "$hh" ) || exit(1);

while ( my $buff = <PIPE> ) {
	chomp($buff);

	my @vec = split( /\t/, $buff );
	my $key = $vec[3] . $vec[2] . $vec[4];
	$serSidSeq{$key} =
	  $vec[7] . "\t" . $vec[8] . "\t" . $vec[9] . "\t" . $vec[10];

}

close(PIPE) || exit(1);

$hh =
  "cat $ARGV[0]*$ARGV[1]* " . '|' . " grep '^98' " . '|' . " sort -u " . '|';

open( PIPE, $hh ) or exit(1);

my %dchInfo = {};

while ( my $buff = <PIPE> ) {
	chomp($buff);

#Outcollects
#my $mykey = substr( $buff, 11, 5 ).substr( $buff, 16, 5 ) ."0".substr( $buff, 8,  3 );
# Incollect
	my $mykey =
	    substr( $buff, 16, 5 )
	  . substr( $buff, 11, 5 ) . "0"
	  . substr( $buff, 8,  3 );
	my $result = $serSidSeq{$mykey};

	chomp($result);

	my ( $carrierID, $trecs, $tch, $tdur ) = split( /\t/, $result );

	my ( $trecs2, $tch2, $tdur2 ) = 0;

	if ( defined( $dchInfo{$carrierID} ) ) {

		$trecs2              = $trecs2 + $trecs;
		$tdur2               = $tdur2 + $tdur;
		$tch2                = $tch2 + $tch;
		$dchInfo{$carrierID} = "$trecs2\t$tdur2\t$tch2"

	}
	else {
		$dchInfo{$carrierID} = "$trecs\t$tdur\t$tch";
	}
}

my @keys = keys %dchInfo;

foreach my $key (@keys) {
	print "$key -- $dchInfo{$key}\n";
}

exit(0);

sub makeDate {
	my $date = shift;
	$date =
	    substr( $date, 0, 4 ) . '-'
	  . substr( $date, 4, 2 ) . '-'
	  . substr( $date, 6, 2 );

	return $date;

}
