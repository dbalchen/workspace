#!/usr/bin/perl

my $howMany = $ARGV[0];
my $hh      = "";

my $rc = 0;

$hh =
"cp /m01/switch/wedo/create_wedo_archive.sh.null /m01/switch/wedo/create_wedo_archive.sh;
 cp /m01/switch/to_wedo.sh_null /m01/switch/to_wedo.sh";

print "$hh\n";

#system($hh);

for ( my $a = 0 ; $a < $howMany ; $a = $a + 1 ) {

	$hh =
"/m01/switch/to_wedo_thread.sh m01-switchb &;
/m01/switch/to_wedo_thread.sh m01-switch  &;
/m01/switch/to_wedo_thread.sh m02-switch  &;
/m01/switch/to_wedo_thread.sh m03-switch &;
/m01/switch/to_wedo_thread.sh m03-switchb &;
/m01/switch/to_wedo_thread.sh m04-switch &;
/m01/switch/to_wedo_thread.sh m05-switch &;
/m01/switch/to_wedo_thread.sh m04-switchb &";

	print "$hh\n";

	#system($hh);

	while ( $rc != 0 ) {
		$rc = checkWedo();
		sleep( 60 * 5 );
	}

	$hh = "/m01/switch/wedo/create_wedo_archive.sh.real";

	print "$hh\n";

	#system($hh);

}

$hh =
"cp /m01/switch/wedo/create_wedo_archive.sh.real /m01/switch/wedo/create_wedo_archive.sh;
 cp /m01/switch/to_wedo.sh.real /m01/switch/to_wedo.sh";

print "$hh\n";

#system($hh);

exit(0);

sub checkWedo {

	my $hh = "ps aux | grep ." . 'to_wedo.sh' . " | grep -v grep | wc -l";

	my $rc = `$hh`;

	return $rc;
}

