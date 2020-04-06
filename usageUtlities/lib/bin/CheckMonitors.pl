#! /usr/local/bin/perl

print "Checking the Monitor\n";

my $monitorPath = $ENV{'MONITOR_PATH'};

chdir($monitorPath);

my $hh = 'nc -w1 localhost 8999 < /dev/null 2>&1 | grep Howdy || echo "Fail"';

my $output = `$hh`;
chomp($output);

if ( index( $output, "Fail" ) > -1 ) {

	$hh = "./StartMonitors";

	print "Monitors are down -- Restarting\n";

	system("$hh");
}

exit(0);
