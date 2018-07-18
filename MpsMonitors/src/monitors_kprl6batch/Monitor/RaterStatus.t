#!/usr/local/bin/perl

=head2 RaterStatus Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl RaterStatus.t MpsLib <path> night_start <hour> night_end <hour> 
                     SqlLib <path> sql_night <file> sql_day <file>
                     market <market> Log <path>
                     [op_job <job>] [op_sid <db instance>]
                     [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  Tests basic functionality of the RaterStatus class.

=head3 INPUT PARAMETERS

  The input parameters comprise of the following pairs:
  Key:          Value:    Description:
  MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
  SqlLib        <path>    Attribute of monitor.xml <M0X> tab.
  night_start   <hour>    Attribute of monitor.xml <params> tab.
  night_end     <hour>    Attribute of monitor.xml <params> tab.
  sql_night     <file>    Attribute of monitor.xml <params> tab.
  sql_day       <file>    Attribute of monitor.xml <params> tab.
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

=head3 Test Monitor::RaterStatus

  Verifies that the RaterStatus module is visible and accessible.

=cut

use_ok('Monitor::RaterStatus');

=head3 Test Inheritance

  Verifies that RaterStatus is a sub class of Monitor.

=cut

my $rater_status = Monitor::RaterStatus->new(%args);

ok($rater_status->isa('Monitor::RaterStatus'),
    "Object is of type Monitor::RaterStatus");

=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($rater_status->get_market()),
    'M01', "Object is set up for the correct market");

=head3 Test get_night_start

  Test accessor method get_night_start().

=cut

is($rater_status->get_night_start(), '4', "Night start time is set correctly");

=head3 Test get_night_end

  Test accessor method get_night_end().

=cut

is($rater_status->get_night_end(), '13', "Night end time is set correctly");

=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($rater_status->get_MpsLib(), $args{MpsLib}, "MpsLib is set correctly");

=head3 Test night_paging_timeframe()

  Verify that night_paging_timeframe() returns the correct boolean.

=cut

test_night_paging_timeframe();

=head3 Test run_check()

  Verify that run_check() returns a string.

=cut

my $return_str = $rater_status->run_check();
ok($return_str, 'run_check() successful');

=head3 Test get_sql_query() 

  Verify that get_sql_query() returns a string.

=cut

my $query = $rater_status->get_sql_query($args{SqlLib} . $args{sql_night});

#print $query , "\n"; #debug
ok($query, "get_sql_query() successful for night query");

=head3 Test get_sql_query()

  Verify that get_sql_query() returns a string.

=cut

$query = $rater_status->get_sql_query($args{SqlLib} . $args{sql_day});

#print $query , "\n";  #debug
ok($query, "get_sql_query() successful for day query");

=head3 Test get_raters_()

  Verify that get_raters() returns a defined array.

=cut

# it is not invalid for get_raters to return an empty
# array of raters at nighttime.
unless ($rater_status->night_paging_timeframe())
{
    ok($rater_status->get_raters($query), "get_raters() successful");
}

=head3 SUPPORTING SUBROUTINES

  Supporting subroutines for more complex tests.

=cut

=head3 test_night_paging_timeframe()

  The subroutine is supposed to return a true value if current time is
  within the night-time paging timeframe.  
  Otherwise it shoud return undef.

=cut


sub test_night_paging_timeframe
{
    my $rater_status =
      Monitor::RaterStatus->new(
                                market      => 'M01',
                                night_start => 4,
                                night_end   => 13
                               );
    my $night_start = $rater_status->get_night_start();
    my $night_end   = $rater_status->get_night_end();

    my $cur_time = (gmtime)[2];
    $cur_time++ if (localtime)[8];

    if ($cur_time >= $night_start && $cur_time <= $night_end)
    {
        ok($rater_status->night_paging_timeframe(),
            "Currently, it is nighttime paging time");
    } else
    {
        ok(!($rater_status->night_paging_timeframe()),
            "Currently it is daytime paging time");
    }
}
