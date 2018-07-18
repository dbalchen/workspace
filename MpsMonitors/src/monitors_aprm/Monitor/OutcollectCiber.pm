#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

=head1 PACKAGE  OutcollectCiber

=head2 AUTHOR

  Pete Chudykowski

=head2 SYNOPSIS

  use Monitor::OutcollectCiber; 
     
  my $check  = Monitor::OutcollectCiber->new(@arg_list); 
  my $result = $check->run_check();
  
  use Monitor::OutcollectCiber;
  
  my $check  = Monitor::OutcollectCiber->new(%arg_hash) 
  my $result = $check->run_check();

=head2 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a formatted string, which will be displayed verbatim
    by the Monitor interfaces. 

=head2 DESCRIPTION

    Reports interruptions in recepit of Incollect Ciber files.

=cut

package Monitor::OutcollectCiber;

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

=head1 METHODS

=head2 new()

  Constructor.
  Creates an instance of OutcollectCiber.
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

    # If today is Sunday or Monday, use alternative threshold.
    if (   (localtime(time))[6] == 0
        or (localtime(time))[6] == 1)
    {
        $self->{threshold} = $args{alt_thresh};
    }

    bless $self, $class;
    return $self;
}

=head2 run_check()

    Performs the OutcollectCiber check.
    
    Returns: Multi-line string scalar that contains the names and 
             last modified date of the most recently received 
             Incollect Ciber file.
    Or:      undef if no files are late.

=cut

sub run_check
{
    my $self = shift;

    # loop through the directory, search for the most recently
    # modified file.
    my $message = undef;
    my %max = (file => '', date => 0);
    opendir(DIR, $self->{phys_dir})
      || croak "can't opendir $self->{phys_dir}: $!";
    foreach my $fname (grep /done$/, readdir(DIR))
    {
        my $cur_file = $self->{phys_dir} . $fname;
        my $cur_date = (stat($cur_file))[9];
#        print "CUR_DATE: $cur_date\n";  # debug
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
        my @ltime = localtime($max{date});
        my $month = $ltime[4]+1;
        my $day = $ltime[3];
        my $year = 1900 + $ltime[5];
        my $hour = $ltime[2];
        my $minute = $ltime[1];
        my $second = $ltime[0];
        
        my $max_date = $month . "/" . $day . "/" . $year . " "
                     . $hour . ":" . $minute . ":" . $second;
        $message = "Most recent file sent at: $max_date\n"
                 . "Contact NDC.s\n";
    }
    return $message;
}

=head2 get_threshold()

    Accessor Method.  
    Returns the value of the instance variable 'threshold'

=cut

sub get_threshold
{
    my $self = shift;
    # on Mondays and Sundays return alternative threshold;
    if((localtime)[6] == 0 or (localtime)[6] == 1)
    {
      return $self->{alt_thresh};
    }
    return $self->{threshold};
}

=head2 get_phys_dir()

    Accessor Method.  
    Returns the value of the instance variable 'phys_dir'

=cut

sub get_phys_dir
{
    my $self = shift;
    return $self->{phys_dir};
}

1;
