#! /usr/local/bin/perl
#exit(0);

BEGIN {
#	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
#	push( @INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5' );
}

#use Schedule::Cron;
#use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush();

my $pid = "runRecon.pid";

&scheduledTask();

#my $cron = new Schedule::Cron( \&scheduledTask, processprefix => "runRecon" );
#my $time = "0 10 * * *";
#$cron->add_entry($time);
#$cron->run( detach => 1, pid_file => "/apps/ebi/ebiap1/bin/roamRecon/$pid" );

exit(0);

sub scheduledTask {

	#return;

	chdir("/apps/ebi/ebiap1/bin/roamRecon/roaminRecon");

	# Get the date of the day before.
	my $timeStamp = "20190319";
	my $hh = "/apps/ebi/ebiap1/bin/roamRecon/listBuilder.pl";
	system($hh);
	#return;

	my $hh =
"/apps/ebi/ebiap1/bin/roamRecon/roamingReconciliation.pl SDIRI_FCIBER $timeStamp & ";

	print "$hh\n";
	system($hh);

}

sub pad {

	my ( $padString, $padwith, $length ) = @_;

	while ( length($padString) < $length ) {
		$padString = $padwith . $padString;
	}

	return $padString;

}

