#!/usr/local/bin/perl

=head2 PACKAGE  RaterStatus

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use Monitor::RaterStatus; 
  
  my $check  = Monitor::RaterStatus->new(@arg_list); 
  my $result = $check->run_check();
  
  use Monitor::RaterStatus;
  
  my $check  = Monitor::RaterStatus->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Reports on the processing state (up or down) of each rater expected
    to be processing.

=cut

package Monitor::RaterStatus;

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

=head2 METHODS

=head3 new()

  Constructor.
  Creates an instance of RaterStatus.
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

    Performs the RaterStatus check.
    The list of raters to check is obtained from the Database and depends 
    on the time frame.  
    There are two time frames: Nighttime and Daytime.  The time frames are
    defined via input variables.
    During the Daytime, all Raters are checked.
    During the Nighttime, only current cycle Raters are checked.
    
    Returns: Multi-line string scalar that contains the list of applicable
             Raters and their current processing status.
    Or:      undef if unable to retrieve Rater list.

=cut

sub run_check
{
    my $self = shift;
    my $log = shift;

    my $query;
    if (night_paging_timeframe($self))
    {
        $query = $self->get_sql_query($self->{SqlLib} . $self->{sql_night});
    } else
    {
        $query = $self->get_sql_query($self->{SqlLib} . $self->{sql_day});
    }
    my @raters = $self->get_raters($query);

    # Not all markets bill all cycles.  Therefore a condition is
    # possible where no raters are expected to run at night.
    unless (@raters)
    {
         $log->print_to_log("No raters are scheduled to run at this time.\n");
         return undef;
    }

    my $return_str = undef;
    foreach my $rater (@raters)
    {
        open(PS_RATER, "ps -ef | grep MpsRate | grep $rater | grep -v grep |");
        my $res = <PS_RATER>;
        close(PS_RATER);

        if (defined $res)
        {
            if(lc($self->{web}) eq "yes")
            { 
                $return_str .= "Rater $rater is up.\n";
            }
        } else
        {
            $return_str .= "Rater $rater is down.\n";
        }
    }
    return $return_str;
}

=head3 SUPPORTING SUBROUTINES

    Supporting subroutines for the run_check method.
    Please make sure to write pod documentation for each subroutine.

=cut

=head3 get_market()

    Accessor method.
    Returns the value of the instance variable 'market'.

=cut

sub get_market
{
    my $self = shift;
    return $self->{market};
}

=head3 get_night_start()

    Accessor method.
    Returns the value of the instance variable 'night_start'.

=cut    

sub get_night_start
{
    my $self = shift;
    return $self->{night_start};
}

=head3 get_night_end()

    Accessor method.
    Returns the value of the instance variable 'night_end'.

=cut    

sub get_night_end
{
    my $self = shift;
    return $self->{night_end};
}

=head3 get_MpsLib()

    Accessor method.
    Returns the value of the instance variable 'MpsLib'.

=cut    

sub get_MpsLib
{
    my $self = shift;
    return $self->{MpsLib};
}

=head3 get_raters()

    Connect to Oracle and retrieve the list of Raters expected
    to be running in current environment.

    Input  : SQL statement to use.
    Return : Array of raters for a given machine.

=cut

sub get_raters
{
    my $self = shift;
    my $sql  = shift;

    my $uscdb       = USCDB->new();
    my @connect_str =
      $uscdb->getDBParmsfromOper($self->{op_job},  $self->{op_sid},
                                 $self->{op_user}, $self->{op_pass});

    # Get rid of white space in the parameter values.
    foreach my $conn (@connect_str)
    {
        $conn =~ s/\s+//g;
    }

    my $rc = $uscdb->openConnection(@connect_str);
    if (!defined $rc)
    {
        carp "Could not connect to Oracle!", $uscdb->getErrorStr(), "\n\n";
    }

    $rc = $uscdb->setQuery($sql);
    if (!defined $rc)
    {
        carp "\nError in setQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }

    $rc = $uscdb->runQuery();
    if (!defined $rc)
    {
        carp "\nError in runQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }

    # Create the output array.
    # Each row contains a rater group and number of raters in the group.
    # Create one array entry for each rater in the group.
    my @raterArr;
    while (my ($rater, $numRaters) = $uscdb->fetchResults())
    {
        for (my $i = 1 ; $i <= $numRaters ; $i++)
        {
            my $raterName = $rater . $i;
            push(@raterArr, $raterName);
        }
    }
    return (@raterArr);
}

=head3 night_paging_timeframe()

  Returns true if current time is within night-time paging timeframe.
  Returns undef if current time is not within the night-time paging timeframe.

=cut

sub night_paging_timeframe()
{
    my $self     = shift;
    my $cur_hour = (gmtime)[2];
    my $isdst    = (localtime)[8];
    if ($isdst)
    {
        $self->{night_start}--;
        $self->{night_end}--;
    }
    return (   $cur_hour >= $self->{night_start}
            && $cur_hour <= $self->{night_end});
}

1;
