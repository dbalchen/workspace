#!/usr/bin/perl

my $hh = "";

$hh =
"cp /m01/switch/wedo/create_wedo_archive.sh.null /m01/switch/wedo/create_wedo_archive.sh;
       cp /m01/switch/wedo/to_wedo.sh_null /m01/switch/wedo/to_wedo.sh";

system($hh);

my $rc = checkWedo();

if ( $rc > 0 ) {
	$hh = "touch /m01/switch/wedo.pull; touch /m01/switchb/wedo.pull;touch /m02/switch/wedo.pull;
	touch /m03/switch/wedo.pull;touch /m03/switchb/wedo.pull;
	touch /m04/switch/wedo.pull;touch /m04/switchb/wedo.pull;touch /m05/switch/wedo.pull;";

	system($hh);
}

while ( $rc != 0 ) {
	$rc = checkWedo();
}

$hh =
  "rm /m01/switch/wedo.pull; rm /m01/switchb/wedo.pull;rm /m02/switch/wedo.pull;
   rm /m03/switch/wedo.pull;rm /m03/switchb/wedo.pull;
   rm /m04/switch/wedo.pull;rm /m04/switchb/wedo.pull;rm /m05/switch/wedo.pull;";

system($hh);

print "WEDO is down --- You may now start the Clean up\n\n";

exit(0);

sub checkWedo {

	my $hh = "ps aux | grep ." . 'to_wedo.sh' . " | grep -v grep | wc -l";

	my $rc = `$hh`;

	return $rc;
}
