#!/opt/perl5/bin/perl

=head2 InfEventLoad Unit Test Suite. 

=head3 AUTHOR

Jacob Ray

=head3 SYNOPSIS

  perl InfEventLoad.t MpsLib <path> night_start <hour> night_end <hour> 
                     SqlLib <path> sql_night <file> sql_day <file>
                     market <market> Log <path>

=head3 DESCRIPTION

  Tests basic functionality of the InfEventLoad class.

=head3 INPUT PARAMETERS

  The input parameters comprise of the following pairs:
  Key:          Value:    Description:
  MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
  SqlLib        <path>    Attribute of monitor.xml <M0X> tab.
  night_start   <hour>    Attribute of monitor.xml <params> tab.
  night_end     <hour>    Attribute of monitor.xml <params> tab.
  market        <M0X>     Attribute of monitor.xml <params> tab.

=cut

use strict;
use warnings;

BEGIN
{
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Test::More 'no_plan';    # you can replace the 'no_plan' with (tests=>n)
                             # where n is the number of tests in the suite.

$| = 1;

my %args = @ARGV;

=head3 TESTS 

=head3 Test Monitor

  Verifies that the Monitor module is visible and accessible.

=cut

use_ok('Monitor');

=head3 Test Monitor::InfEventLoad

  Verifies that the InfEventLoad module is visible and accessible.

=cut

use_ok('Monitor::InfEventLoad');

=head3 Test Inheritance

  Verifies that InfEventLoad is a sub class of Monitor.

=cut

my $iel_status = Monitor::InfEventLoad->new(%args);

ok($iel_status->isa('Monitor::InfEventLoad'),
    "Object is of type Monitor::InfEventLoad");

=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($iel_status->get_market()),
    'M01', "Object is set up for the correct market");

=head3 Test get_night_start

  Test accessor method get_night_start().

=cut

is($iel_status->get_night_start(), '4', "Night start time is set correctly");

=head3 Test get_night_end

  Test accessor method get_night_end().

=cut

is($iel_status->get_night_end(), '13', "Night end time is set correctly");

=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($iel_status->get_MpsLib(), $args{MpsLib}, "MpsLib is set correctly");

=head3 Test night_paging_timeframe()

  Verify that night_paging_timeframe() returns the correct boolean.

=cut

test_night_paging_timeframe();

=head3 Test run_check()

  Verify that run_check() returns a string.

=cut

my $return_str = $iel_status->run_check();
ok($return_str, 'run_check() successful');

=head3 SUPPORTING SUBROUTINES

  Supporting subroutines for more complex tests.

=cut

=head3 test_night_paging_timeframe()

  The subroutine is supposed to return a true value if current time is
  within the night-time paging timeframe.  
  Otherwise it should return undef.

=cut


sub test_night_paging_timeframe
{
    my $iel_status =
      Monitor::InfEventLoad->new(
                                market      => 'M01',
                                night_start => 4,
                                night_end   => 13
                               );
    my $night_start = $iel_status->get_night_start();
    my $night_end   = $iel_status->get_night_end();

    my $cur_time = (gmtime)[2];
    $cur_time++ if (localtime)[8];

    if ($cur_time >= $night_start && $cur_time <= $night_end)
    {
        ok($iel_status->night_paging_timeframe(),
            "Currently, it is nighttime paging time");
    } else
    {
        ok(!($iel_status->night_paging_timeframe()),
            "Currently it is daytime paging time");
    }
}
