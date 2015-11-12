#!/opt/perl5/bin/perl

=head1 PACKAGE  CheckTemplate

  Template for developing Monitor Check classes.

=head2 AUTHOR

  Pete Chudykowski

=head2 SYNOPSIS

  use Monitor::CheckTemplate; 
     
  my $check  = Monitor::CheckTemplate->new(@arg_list); 
  my $result = $check->run_check();
  
Z<>
  
  use Monitor::CheckTemplate;
  
  my $check  = Monitor::CheckTemplate->new(%arg_hash) 
  my $result = $check->run_check();

=head2 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head2 DESCRIPTION

  Provide a template and a framework for developing new Checks for the MPS
  System Monitor.

=cut

package Monitor::CheckTemplate;

use strict;
use warnings;

BEGIN
{
    my %args = @_;
    push @INC, $args{MpsLib};
}

use base qw(Monitor);    # Monitor is the base (parent) class.

=head2 SUBROUTINES

=head2 new()

  Constructor.
  Creates an instance of CheckName.
  Sets the class variables from argument list or defaults.
  
  Returns: a reference to the instanciated object.

=cut

sub new()
{
    my $class  = shift;
    my %params = @_;
    my $self   = Monitor->new();    # inherit Monitor's instance variables.

    # Add properties passed in to the hash of instance variables.
    foreach my $key (keys(%params))
    {
        $self->{$key} = $params{$key};
    }

    #TODO Perform initial setup and create instance variables here.

    bless $self, $class;
    return $self;
}

=pod

=head2 run_check()

  Performs the <check_name> check.
  <brief description of processing>
    
  Returns: scalar     containing error message string 
           or
           undef      if no errors found.

=cut

sub run_check
{
    my $self = shift;

    #TODO Perform the check using instance variables and supporting subroutines.

    #TODO Format and return a string upon an error condition, or undef if no errors.

    return undef;
}

#TODO compose supporting subroutines.

=head2 SUPPORTING SUBROUTINES

    Supporting subroutines for the run_check method.
    Please make sure to write pod documentation for each subroutine.

=cut

1;
