#! /usr/local/bin/perl

my $total             = 0;
while ( $buff = <STDIN> ) {
	chomp($buff);

	$total = $total + 1;
	$total_cost        = $buff + $total_cost;
}

$total_cost = $total_cost / 100;

print $total. "\t" . $total_cost . "\n";

exit(0);
