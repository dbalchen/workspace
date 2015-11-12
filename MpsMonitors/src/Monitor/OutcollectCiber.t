#!/opt/perl5/bin/perl

=head1 OutcollectCiber Unit Test Suite. 

=head2 AUTHOR

Pete Chudykowski

=head2 SYNOPSIS

  perl OutcollectCiber.t MpsLib <path> threshold <int hours>  
                         market <M0X> phys_dir <dir>

=head2 DESCRIPTION

  Tests basic functionality of the OutcollectCiber class.

=head2 INPUT PARAMETERS

  The input parameters comprise of the following pairs:
  Key:          Value:    Description:
  market        <M0X>     Attribute of monitor.xml <params> tab.
  MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
  threshold    <hours>    Attribute of monitor.xml <params> tab.
  phys_dir      <path>    Attribute of monitor.xml <params> tab.             

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
use Test::Pod;
use Test::Pod::Coverage;
use USCDB;
use Carp;
use Data::Dumper;

$| = 1;

my %args = @ARGV;

=head2 TESTS 

=head2 Test Monitor

  Verifies that the Monitor module is visible and accessible.

=cut

use_ok('Monitor');

=head2 Test Monitor::OutcollectCiber

  Verifies that the RaterStatus module is visible and accessible.

=cut

use_ok('Monitor::OutcollectCiber');

=head2 Test Inheritance

  Verifies that OutcollectCiber is a sub class of Monitor.

=cut

my $outcol_ciber = Monitor::OutcollectCiber->new(%args);

ok($outcol_ciber->isa('Monitor::OutcollectCiber'),
    "Object is of type Monitor::OutcollectCiber");

=head2 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($outcol_ciber->get_MpsLib(), $args{MpsLib}, "MpsLib is set correctly");

=head2 Test get_market()

  Test accessor method get_market().

=cut

is(uc($outcol_ciber->get_market()),
    uc($args{market}), "Object is set up for the correct market");

=head2 Test get_threshold

  Test accessor method get_threshold().

=cut

ok($outcol_ciber->get_threshold(), "Instance variable 'threshold' is defined.");

# on Sundays and Mondays get_threshold returns alternate threshold
if((localtime)[6] == 0 or (localtime)[6] == 1)
{
  is($outcol_ciber->get_threshold(),
     $args{alt_thresh}, "Instance variable 'threshold' is set correctly.");
}
else
{
  is($outcol_ciber->get_threshold(),
      $args{threshold}, "Instance variable 'threshold' is set correctly.");
}


=head2 Test get_phys_dir

  Test accessor method get_phys_dir()

=cut    

ok($outcol_ciber->get_phys_dir(), "Instance variable 'phys_dir' is defined.");

is($outcol_ciber->get_phys_dir(),
    $args{phys_dir}, "Instance variable 'phys_dir' is set correctly.");

=head2 Test run_check_problem()

    Test the behavior when there is an interruption in 
    Outcollect Ciber file receipt.

=cut

run_check_problem();

sub run_check_problem
{

    #place a file with a modified time stamp in 'phys_dir'.
    my $dummy_file = $args{phys_dir} . "CIBER_DUMMY_t" . time() . ".done";
    my $ctime = time() - (60 * 60 * 40);
    open(FILE, ">$dummy_file")
      or croak "Unable to open file for writing!\n file: $dummy_file\n";

    utime($ctime, $ctime, $dummy_file);

    close(FILE);

    my @ltime = localtime($ctime);
        my $month = $ltime[4]+1;
        my $day = $ltime[3];
        my $year = 1900 + $ltime[5];
        my $hour = $ltime[2];
        my $minute = $ltime[1];
        my $second = $ltime[0];
        
        my $max_date = $month . "/" . $day . "/" . $year . " "
                     . $hour . ":" . $minute . ":" . $second;
    my $expected_message =
      "most recent file: $dummy_file\n" . "date: $max_date\n\n";
    my $message = $outcol_ciber->run_check();

    is($message, $expected_message,
        "run_check() successful - detected problem!");

    unlink $dummy_file;
}


=head2 Test run_check_no_problem()

    Test the behavior when there is no interruption in 
    Outcollect Ciber file receipt.

=cut

run_check_no_problem();

sub run_check_no_problem
{

    #place a file with a modified time stamp in 'phys_dir'.
    my $dummy_file = $args{phys_dir} . "CIBER_DUMMY_t" . time() . ".done";
    my $ctime = time() - (60 * 60 * 20);
    open(FILE, ">$dummy_file")
      or croak "Unable to open file for writing!\n file: $dummy_file\n";

    utime($ctime, $ctime, $dummy_file);

    close(FILE);

    ok(!($outcol_ciber->run_check()), "run_check() successful - no problem.");

    unlink $dummy_file;
}


=head2 Test run_check_no_files()

    Test the behavior when there are no
    Outcollect Ciber files found in the directory.

=cut

run_check_no_files();

sub run_check_no_files
{

    my $message = $outcol_ciber->run_check();
    is($message,
        "WARNING: No files found in $args{phys_dir}!\n",
        "run_check() successful - no files found in directory.");
}
