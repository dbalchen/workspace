#! /usr/local/bin/perl

my $hostname = `hostname`;

#my $email = 'USCDLISBillingandRevenueOpsOn-Call@uscellular.com:USCDLISOps-BillingandAROperations@uscellular.com';

my $email = 'david.balchen@uscellular.com';

chomp($hostname);

my $rdate = `date '+%A %B %d %T %Z'`;

chomp($rdate);

$ENV{'UTLITIES_HOME'} = '/apps/ebi/ebiap1/bin/usageUtlities';

chdir( $ENV{'UTLITIES_HOME'} );

my $subject = "Usage Graphs for $rdate";

my $salutation = "'"."Ms. Connie and Cindy,

Here are the usage graphs for $rdate.

Dave

"."'";

my @output = "\n+\n\n";

my $hh =
    " | $ENV{'UTLITIES_HOME'}/lib/bin/toEmail.py -s "
  . $salutation
  . " -sb ".'"'
  . $subject
  . '" -a "'
  . "$ENV{'UTLITIES_HOME'}/usageGraphs.zip"
  . '" -e "'
  . $email . '"';

my $pid = open( WRITEME, "$hh" )
  or die "Couldn't fork: $!\n";

print WRITEME "@output";

close(WRITEME) or die "Couldn't close: $!\n";
print "$hh\n";

print "$rdate Program UsageGraphs Finished\n";

exit(0);
