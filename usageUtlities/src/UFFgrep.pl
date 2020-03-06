#! /usr/local/bin/perl

my $stdin_file = "/home/dbalchen/Desktop/allProd.dat";

open( STDIN, "< $stdin_file" ) || exit(1);

my %switches = {};

for ( my $args = 0 ; $args < @ARGV ; $args++ ) {

	if ( $ARGV[$args] eq "-f" ) {

		$switches{"$ARGV[$args + 1]"} = $ARGV[ $args + 2 ];
		$args = $args + 2;

	}

}

while ( my $buff = <STDIN> ) {

	chomp($buff);

	my $hits = 0;

	my @fields = split( /\|/, $buff );

	foreach my $key ( keys %switches ) {

		if ( substr($fields[ $key - 1 ],0,length($switches{$key})) eq $switches{$key} ) {

			$hits = $hits + 1;

		}
	}

	if ( $hits == keys %switches ) {

		print "$buff\n";

	}
}

exit(0);
