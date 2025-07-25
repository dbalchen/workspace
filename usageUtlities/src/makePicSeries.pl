#! /usr/local/bin/perl


my $ut_home = $ENV{'UTLITIES_HOME'};

my $title = "Stat Plot";
my $scale = 1;
my $out   = "out";
my $col   = 'Volume';

#my $stdin_file = "/home/dbalchen/Desktop/test.dat";

for ( my $args = 0 ; $args < @ARGV ; $args++ ) {

	if ( $ARGV[$args] eq "-i" ) {

		$stdin_file = $ARGV[ $args + 1 ];
		$args       = $args + 1;

	}

	if ( $ARGV[$args] eq "-t" ) {

		$title = $ARGV[ $args + 1 ];
		$args  = $args + 1;

	}

	if ( $ARGV[$args] eq "-s" ) {

		$scale = $ARGV[ $args + 1 ];
		$args  = $args + 1;
	}

	if ( $ARGV[$args] eq "-o" ) {

		$out  = $ARGV[ $args + 1 ];
		$args = $args + 1;
	}

	if ( $ARGV[$args] eq "-c" ) {

		$col  = $ARGV[ $args + 1 ];
		$args = $args + 1;
	}

}

my $hh = "cat $stdin_file | " . $ut_home . "/src/statAnalysis.py 2> /dev/null";

my @hhOut = `$hh`;

my %work = {};
my $key  = '';
my $data = '';

for ( my $a = 0 ; $a < @hhOut ; $a++ ) {

	chomp( $hhOut[$a] );

	( $key, $data ) = split( "\t", $hhOut[$a] );

	$work{$key} = $data;
}

$hh =
    '((printf "Date\t'
  . $col
  . '\tPolyfit 3 \n");cat '
  . $stdin_file . ' | '
  . $ut_home
  . '/src/functionGenerator.py -p 3) 2>/dev/null | '
  . $ut_home
  . '/src/statPlot.py -o '
  . $out
  . '.png -sc '
  . $scale . ' -t "'
  . $title
  . '" -md '
  . $work{'medium'} . " -i0 "
  . $work{'iq0'} . " -i1 "
  . $work{'iq3'} . " -uf "
  . $work{'Upper Fence'} . " -lf "
  . $work{'Lower Fence'} . " ";

system($hh);

exit(0);
