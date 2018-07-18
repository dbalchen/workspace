#!/opt/perl5/bin/perl

=head1 Monitor Check Unit Test Suite template. 

Template for creating Unit a Test Suite for a Monitor Check.

=head2 AUTHOR

Pete Chudykowski

=head2 SYNOPSIS

  perl CheckTemplate.t argKey <argValue> argKey <argValue>
                        [argKey <argValue>] [argKey <argValue>]

=head2 DESCRIPTION

  Tests basic functionality of the CheckTemplate class.

=head2 GENERAL GUIDELINES

  At minimum there should be at least one test for each method of the 
  class tested.  These tests verify basic functionality of each method.
  
  Composite test verifying overall behavior for a specific condition
  should be written and added on as the class evolves.
  
  Each time the class is modified for an enhancement or bug fix, a new 
  test should be written for the specific condition(s) addressed by the
  code change.  
  
  Each test should be documented using POD.  The POD should include an 
  explanation of what condition is tested and how behavior is verified.
         
=cut

use strict;
use warnings;

BEGIN
{
    my %args = @ARGV;
    push @INC, $args{root_path};
}

use Test::More 'no_plan';    # you can replace the 'no_plan' with (tests=>n)
                             # where n is the number of tests in the suite.

$| = 1;

=head2 TESTS 

=head2 Test <name>
  
  Verifies that the Monitor module is visible and accessible.

=cut

use_ok('Monitor');

#TODO More tests here.

=head2 SUPPORTING SUBROUTINES

  Supporting subroutines for more complex tests.

=cut

#TODO Supporting subroutines.
