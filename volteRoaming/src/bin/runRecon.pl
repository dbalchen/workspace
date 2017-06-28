#! /usr/local/bin/perl

use Time::Piece;
use Time::Seconds;

BEGIN {
  push(@INC, '/home/dbalchen/workspace/perl_lib/lib/perl5');
 # push(@INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5');
}

#use Schedule::Cron;
use FileHandle;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush();

my $pid = "ROAMRECON.pid";

scheduledTask();

my $cron = new Schedule::Cron(\&scheduledTask,processprefix=>"ROAMRECON");
my $time = "00 11 * * *";
#$cron->add_entry($time);
#$cron->run(detach=>1,pid_file=>"/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/$pid");

exit(0);

sub scheduledTask{

chdir("/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon");

# Get the date of the day before.

my $day = (((Time::Piece->new) - ONE_DAY) - ONE_DAY);

my $timeStamp = $day->strftime('%Y%m%d');

$timeStamp = '20170619';

my $hh = "/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/roamingReconciliation.pl SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER,DATA_CIBER,LTE,DISP_RM,NLDLT $timeStamp & ";

#system($hh);

print("$hh\n")

};

sub pad {

  my ( $padString, $padwith, $length ) = @_;

  while ( length($padString) < $length ) {
    $padString = $padwith . $padString;
  }

  return $padString;

}


