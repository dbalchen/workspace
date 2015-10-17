#! /usr/bin/perl

$server = $ARGV[0];
chomp($server);

$num = substr($server,2,1);

$hh = "su - calldmp".$num." -c 'cd ".$ENV{CALL_DUMP_BIN_DIR2}."; nohup ./restoreServer.pl m0".$num." &'";
print "$hh\n";
system($hh);

exit(0);
