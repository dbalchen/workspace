#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

=head2 PACKAGE IncollectCiber


=head3 AUTHOR

  Pete Chudykowski


=head3 SYNOPSIS

  use Monitor::IncollectCiber; 
     
  my $check  = Monitor::IncollectCiber->new(@arg_list); 
  my $result = $check->run_check();
  
  
  use Monitor::IncollectCiber;
  
  my $check  = Monitor::IncollectCiber->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Reports interruptions in recepit of Incollect Ciber files.

=cut

package Monitor::IncollectCiber;
use strict;
use warnings;

BEGIN
{
    my %args = @_;
    push @INC, $args{MpsLib};
}
use base qw(Monitor);    # Monitor is the base (parent) class.
use Carp;
use USCDB;
use Data::Dumper;

=head3 METHODS

=head3 new()

  Constructor.
  Creates an instance of IncollectCiber.
  Sets the class variables from argument pairs.
  
  Returns: a reference to the instanciated object.

=cut

sub new()
{
    my ($class, %args) = @_;
    my $self = Monitor->new();    # inherit Monitor's instance variables.

    # Add properties passed in to the hash of instance variables.
    foreach my $key (keys(%args))
    {
        $self->{$key} = $args{$key};
    }
    bless $self, $class;
    return $self;
}

=head3 run_check()

    Performs the IncollectCiber check.
        
    Returns: Multi-line string scalar that contains the names and 
             last modified date of the most recently received 
             Incollect Ciber file.
    Or:      undef if no files are late.

=cut

sub run_check
{
    my $self    = shift;
    my $message = undef;    

    # Loop through the directory, search for the most recently
    # modified file.
    my %max = (file => '', date => 0);
    opendir(DIR, $self->{phys_dir})
      || croak "can't opendir $self->{phys_dir}: $!";
#    foreach my $fname (grep /FTP$/, readdir(DIR))  
    foreach my $fname (grep /DAT$/, readdir(DIR))
    {
        my $cur_file = $self->{phys_dir} . $fname;
        my $cur_date = (stat($cur_file))[9];
        if ($cur_date > $max{date})
        {
            $max{file} = $cur_file;
            $max{date} = $cur_date;
        }
    }
    closedir DIR;
    
    if ($max{date} == 0)
    {
        return "WARNING: No files found in $self->{phys_dir}!\n";
    }
    if ($max{date} < (time() - (60 * 60 * $self->{threshold})))
    {
        my $timestamp = localtime($max{date});
        $message = "Most recent file received at $timestamp\n"
                 . "Contact NDC.\n";
    }
    return $message;
}

=head3 get_threshold()

    Accessor Method.  
    Returns the value of the instance variable 'threshold'

=cut

sub get_threshold
{
    my $self = shift;
    return $self->{threshold};
}

=head3 get_phys_dir()

    Accessor Method.  
    Returns the value of the instance variable 'phys_dir'

=cut

sub get_phys_dir
{
    my $self = shift;
    return $self->{phys_dir};
}
1;
