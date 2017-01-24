#! /usr/local/bin/perl

BEGIN {
  push(@INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5');
}

use Schedule::Cron;
use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush();

my $pid = "ROAMRECON.pid";

scheduledTask();

my $cron = new Schedule::Cron(\&scheduledTask,processprefix=>"ROAMRECON");
my $time = "00 11 * * *";
$cron->add_entry($time);
$cron->run(detach=>1,pid_file=>"/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/$pid");

exit(0);

sub scheduledTask{

chdir("/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon");

# Get the date of the day before.
my ($day,$month,$year) = (localtime((time - 60 * 60 * (12 + (localtime)[2] ) ) ) )[ 3, 4, 5 ];
my $timeStamp = 1900 + $year.pad( $month + 1, '0', 2 ).pad( $day, '0', 2 );

$hh = "/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/roamingReconciliation.pl SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER,DATA_CIBER,LTE,DISP_RM,NLDLT $timeStamp & ";

system($hh);

};

sub pad {

  my ( $padString, $padwith, $length ) = @_;

  while ( length($padString) < $length ) {
    $padString = $padwith . $padString;
  }

  return $padString;

}


