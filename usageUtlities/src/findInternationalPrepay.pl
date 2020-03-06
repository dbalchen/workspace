#! /usr/local/bin/perl

my $date = $ARGV[0];

chdir("/");

my $hh =
    'find m0* -name "*T'
  . $date
  . '*DAT*gz" -print -follow | xargs -i gunzip -c {} | grep '
  . "'|10105|' | grep '|011' |";

open( MYPIPE, $hh ) or die "can't fork: $!";

while ( my $buff = <MYPIPE> ) {
	chomp($buff);
	my @fields = split( /\|/, $buff );

	if ( ( $fields[5] eq '10105' ) && ( substr( $fields[25], 0, 3 ) eq '011' ) )
	{
		print "$buff\n";

	}

}

exit(0);
