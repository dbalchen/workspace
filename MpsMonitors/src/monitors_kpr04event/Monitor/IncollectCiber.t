#!/usr/local/bin/perl

=head2 IncollectCiber Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl IncollectCiber.t MpsLib <path> threshold <int hours>  
                        market <M0X> phys_dir <path>

=head3 DESCRIPTION

  Tests basic functionality of the IncollectCiber class.

=head3 INPUT PARAMETERS

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


=head3 TESTS 

=head3 Test Monitor
  
  Verifies that the Monitor module is available.

=cut

use_ok('Monitor');

=head3 Test Monitor::IncollectCiber

  Verifies that the IncollectCiber module is available.

=cut

use_ok('Monitor::IncollectCiber');

=head3 Test Inheritance

  Verifies that IncollectCiber is a subclass of Monitor.

=cut

my $incol_ciber = Monitor::IncollectCiber->new(%args);
                                               
ok($incol_ciber->isa('Monitor::IncollectCiber'),
    "Object is of type Monitor::IncollectCiber");


=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($incol_ciber->get_MpsLib(), $args{MpsLib},
    "MpsLib is set correctly");


=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($incol_ciber->get_market()), uc($args{market}),
   "Object is set up for the correct market");

=head3 Test get_threshold

  Test accessor method get_threshold().

=cut    

ok($incol_ciber->get_threshold(), 
   "Instance variable 'threshold' is defined.");
   
is($incol_ciber->get_threshold(), $args{threshold}, 
   "Instance variable 'threshold' is set correctly.");
   

=head3 Test get_phys_dir

  Test accessor method get_phys_dir()

=cut    

ok($incol_ciber->get_phys_dir(), 
   "Instance variable 'phys_dir' is defined.");
   
is($incol_ciber->get_phys_dir(), $args{phys_dir}, 
   "Instance variable 'phys_dir' is set correctly.");


=head3 Test run_check_problem()

    Test the behavior when there is an interruption in 
    Incollect Ciber file receipt.

=cut

run_check_problem();

sub run_check_problem
{
    #place a file with a modified time stamp in 'phys_dir'.
    my $dummy_file = $args{phys_dir} . "CIBER_DUMMY_t" . time() . ".FTP";
    my $ctime = time() - (60*60*35);
    open(FILE, ">$dummy_file" ) 
      or croak "Unable to open file for writing!\n file: $dummy_file\n";
     
    utime($ctime, $ctime, $dummy_file);
    
    close(FILE);
    
    my $expected_message = "most recent file: $dummy_file\n" .
                           "date: $ctime\n\n";
    my $message = $incol_ciber->run_check();
    is($message, $expected_message, 
       "run_check() successful - detected problem!");
    
    unlink $dummy_file;
}


=head3 Test run_check_no_problem()

    Test the behavior when there is no interruption in 
    Incollect Ciber file receipt.

=cut

run_check_no_problem();

sub run_check_no_problem
{
    #place a file with a modified time stamp in 'phys_dir'.
    my $dummy_file = $args{phys_dir} . "CIBER_DUMMY_t" . time() . ".FTP";
    my $ctime = time() - (60*60*20);
    open(FILE, ">$dummy_file" ) 
      or croak "Unable to open file for writing!\n file: $dummy_file\n";
     
    utime($ctime, $ctime, $dummy_file);
    
    close(FILE);
    
    ok(!($incol_ciber->run_check()), 
       "run_check() successful - no problem.");
    
    unlink $dummy_file;
}


=head3 Test run_check_no_files()

    Test the behavior when there are no
    Incollect Ciber files found in the directory.

=cut

run_check_no_files();

sub run_check_no_files
{
    
    my $message = $incol_ciber->run_check();
    is($message, "WARNING: No files found in $args{phys_dir}!\n",
       "run_check() successful - no files found in directory.");  
}   