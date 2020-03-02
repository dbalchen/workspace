#! /usr/local/bin/perl

chdir($ENV{'UTLITIES_HOME'});

my $subject="ALERT!!!! BAD SIDS FOUND";

my $salutation = "Dearest OPS,\n\nBad SIDS were found. Please see the list below:\n\n";

my $date = `date '+%Y%m%d'`;

my $hh =
    'find '.$ENV{"HOME"}.'/var/usc/projs/apr/log/ES* -name "ADJ1EVENTSRV*_'
  . $date
  . '*.log"'
  . " -print -follow | xargs -i egrep "
  . '"Event is rejected due to missing AVPs required for rating|'
  . 'exceed maximum defined size' . " '5'" . '" {}';

print "$hh\n";

my @output = `$hh`;

if ( @output > 0 ) {
	my $pid = open( WRITEME, "| $ENV{'UTLITIES_HOME'}/toEmail.py " )
	  or die "Couldn't fork: $!\n";

	print WRITEME "@output";

	close(WRITEME) or die "Couldn't close: $!\n";
}

print "$date Program Finished\n";

exit(0);
