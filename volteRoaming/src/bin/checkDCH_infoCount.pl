#! /usr/bin/perl

my $file     = $ARGV[0];
my $dch_file = $ARGV[1];

$file ="/home/dbalchen/Desktop/CIBER_CIBER_20180622135109_3857788_0044.dat";
$dch_file = '/home/dbalchen/Desktop/Outcollect.csv';

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
		my $key = pad( $vec[3], 5 ) . pad( $vec[2], 5 ) . pad( $vec[4], 4 );
		$serSidSeq{$key} = $vec[6] . "\t" . $vec[7] . "\t" . $vec[8];
	}
}

my $hh = "cat $file " . '|' . " grep '^98' " . '|' . " sort -u " . '|';

open( PIPE, $hh ) or exit(1);

while ( my $buff = <PIPE> ) {
	chomp($buff);

	my $mykey = "";

    my $flag = 0;
    
	$mykey =
	    substr( $buff, 16, 5 )
	  . substr( $buff, 11, 5 ) . "0"
	  . substr( $buff, 8,  3 );

	my $rec_charges = substr( $buff, 25, 12 )/100;
	my $rec_totals = substr( $buff, 21,  4 );
	my $homeSid = substr( $buff, 16, 5 );
	my $serveSid = substr( $buff, 11, 5 );
	my $batchSeq = "0".substr( $buff, 8,  3 );
	my $result = "";

	if ( !( defined( $serSidSeq{$mykey} ) ) ) {

		print "Missing $mykey: $buff\n";
	}
	else {
		$result = $serSidSeq{$mykey};
	}

	my ( $records, $charges, $volumes ) = split( /\t/, $result );

	if($records != $rec_totals)
	{
		#print "Record totals Different\n";
		$flag = 1;
	}
	elsif($charges != $rec_charges)
	{
	 #print "charges Different\n";
	 		$flag = 1;
	}

	if ($flag == 1)
	{
		print "$homeSid\t$serveSid\t$batchSeq\t".($records-$rec_totals)."\t".($charges - $rec_charges)."\t$buff\n";
		$flag = 0;
	}

}


close(PIPE);

exit(0);

sub pad {

	my ( $string2pad, $padw ) = @_;

	while ( length($string2pad) < $padw ) {
		$string2pad = "0" . $string2pad;
	}

	return $string2pad;
}
