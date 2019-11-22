#!/bin/perl

#my $stdin_file = "/home/dbalchen/workspace/usageUtlities/src/STAS1_FUFF_ID000769_T20190517150122.csv";
#
#open( STDIN, "< $stdin_file" ) || exit(1);

while ( my $buff = <STDIN> ) {
	chomp($buff);

	my @fields = split( /\|/, $buff );

	if ( $fields[51] == 3 ) {
		print "$buff\n";
	}
}
