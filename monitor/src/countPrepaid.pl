#! /usr/local/bin/perl

use DBI;

my $total_vol  = 0;
my $total_recs = 0;

my %dateH = {};

#open( STDIN, "< /home/dbalchen/Desktop/testData" ) || exit(0);

my @splitA = ();

while ( my $buff = <STDIN> ) {
	chomp($buff);

	@splitA = split( /\|/, $buff );

	my @sumData = ( 0, 0, 0, 0 );

	if ( defined $dateH{ $splitA[1] } ) {
		@sumData = @{ $dateH{ $splitA[1] } };
	}

	if ( $splitA[2] == 0 ) {
		$sumData[1] = $sumData[1] +
		  ( ( ( ( $splitA[3] + $splitA[4] ) / 1024 ) / 1024 ) / 1024 );
		$sumData[0] = $sumData[0] + 1;
	}
	else {
		$sumData[3] = $sumData[3] +
		  ( ( ( ( $splitA[3] + $splitA[4] ) / 1024 ) / 1024 ) / 1024 );
		$sumData[2] = $sumData[2] + 1;
	}

	$dateH{ $splitA[1] } = \@sumData;
}

foreach my $key ( keys %dateH ) {

	my @sumData = @{ $dateH{$key} };

	print "$key\t$sumData[0]\t$sumData[1]\t$sumData[2]\t$sumData[3]\n";

}

#close(STDIN);

exit(0);


#
#
# To work gunzip -c *2018012[3,4,5,6,7]*gz | grep 'DR' | cut -d'|' -f6,8,37,40,41 | grep '^10105' | ./
#
#