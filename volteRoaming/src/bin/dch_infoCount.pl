#! /usr/bin/perl

my $file     = $ARGV[0];
my $dch_file = $ARGV[1];

#$file ="/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output/CIBER_CIBER_20170622121615_3155473_0021.dat.done";
#$dch_file = 'OutcollectDCH_voice.csv';

my $total_records = 0;
my $total_charges = 0;
my $total_volume  = 0;

my %serSidSeq = {};

open( DCH, "< $dch_file" ) || exit(1);

while ( my $buff = <DCH> ) {
	chomp($buff);
	my @vec = split( /\t/, $buff );

	if ( index( $file, "CIBER_CIBER" ) >= 0 ) {
		my $key = pad( $vec[2], 5 ) . pad( $vec[3], 5 ) . pad( $vec[4], 4 );
		$serSidSeq{$key} = $vec[6] . "\t" . $vec[7] . "\t" . $vec[8];
	}
	else {
		my $key = pad( $vec[2], 5 ) . pad( $vec[4], 5 ) . pad( $vec[7], 4 );
		$serSidSeq{$key} = $vec[5] . "\t" . $vec[6] . "\t" . $vec[8];
	}
}

my $hh = "cat $file " . '|' . " grep '^98' " . '|' . " sort -u " . '|';

open( PIPE, $hh ) or exit(1);

while ( my $buff = <PIPE> ) {
	chomp($buff);

	my $mykey = "";

	$mykey =
	    substr( $buff, 16, 5 )
	  . substr( $buff, 11, 5 ) . "0"
	  . substr( $buff, 8,  3 );

	my $result = "";

	if ( !( defined( $serSidSeq{$mykey} ) ) ) {

		#print "$buff\n";
	}
	else {
		$result = $serSidSeq{$mykey};
	}

	my ( $records, $charges, $volumes ) = split( /\t/, $result );

	$total_records = $total_records + $records;
	$total_charges = $total_charges + $charges;
	$total_volume  = $total_volume + $volumes;

}

print "$total_records\n";
print "$total_charges\n";
print "$total_volume\n";

close(PIPE);

exit(0);

sub pad {

	my ( $string2pad, $padw ) = @_;

	while ( length($string2pad) < $padw ) {
		$string2pad = "0" . $string2pad;
	}

	return $string2pad;
}
