#! /usr/local/bin/perl

#Test parameters remove when going to production.
$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR";

# Setup Initial variables
my $max_process = 10;

# Setup switch types and their directory location
my %dirs = {};

$dirs{'SDIRI_FCIBER'} =
  '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DIRI';

$dirs{'SDATACBR_FDATACBR'} =
  '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DATACBR';

# Get Roaming switches to check

my @switches = split( ',', $ARGV[0] );

# Get the date of the day before.
my ( $day, $month, $year ) =
  ( localtime( ( time - 60 * 60 * ( 12 + (localtime)[2] ) ) ) )[ 3, 4, 5 ];
my $timeStamp = 1900 + $year . pad( $month + 1, '0', 2 ) . pad( $day, '0', 2 );

# Get Roaming files
foreach my $switch (@switches) {

	chdir( $dirs{$switch} );

	my $hh = 'find . -name "' . $switch . '*' . $timeStamp . '*DAT*" -print |';

	print "$hh\n";

	if ( !open( FINDLIST, "$hh" ) ) {
		errorExit("Cannot create FINDLIST: $!\n");
	}

	while ( my $filename = <FINDLIST> ) {
		$hh = "$ENV{'REC_HOME'}/getFileInfo.pl $dirs{$switch}/$filename";
		print "$hh\n";

		while ( getTotalProc > $max_process ) {
			sleep 10;
		}
	}

}

# For each file get DB counts

exit(0);

sub getTotalProc {

	my $total_proc = `ps aux | grep getFileInfo.pl | wc -l`;
	chomp $total_proc;
	return $total_proc;
}

sub pad {

	my ( $padString, $padwith, $length ) = @_;

	while ( length($padString) < $length ) {
		$padString = $padwith . $padString;
	}

	return $padString;

}
