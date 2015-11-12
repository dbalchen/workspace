#!/opt/perl5/bin/perl

=head2 PACKAGE  MissingDataFile

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use Monitor::MissingDataFile; 
  
  my $check  = Monitor::MissingDataFile->new(@arg_list); 
  my $result = $check->run_check();
  
  use Monitor::MissingDataFile;
  
  my $check  = Monitor::MissingDataFile->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Reports missing data files.

=cut

package Monitor::MissingDataFile;

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
use Time::Local;
use Data::Dumper;

=head2 METHODS

=head3 new()

  Constructor.
  Creates an instance of MissingDataFile.
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

    Performs the MissingDataFile check.
        
    Returns: Multi-line string scalar that contains the list of 
             switches and their missing blocks.
    Or:      undef if no files are late.

=cut

sub run_check
{
    my $self    = shift;
    my $message = undef;

    my $dbh      = $self->get_cares_db();
    my @switches = $self->get_switches($dbh);

    my $mdf_query = $self->get_sql_query($self->{SqlLib} . $self->{sql_query});
    my $rc        = $dbh->setQuery($mdf_query);
    if (!defined $rc)
    {
        croak "\nError in setQuery: \n", $dbh->getErrorStr(), "\n\n";
    }

    # Loop through the applicable switches.
    # Check for gaps one switch at a time.
    foreach my $switch (@switches)
    {

        # execute query with the appropriate bind variables.
        $rc =
          $dbh->runQuery($self->{from_hrs_ago}, $self->{to_hrs_ago}, $switch);
        if (!defined $rc)
        {
            croak "\nError in runQuery: \n", $dbh->getErrorStr(), "\n\n";
        }

        
        my $prev_end_block = $self->skip_first_day($dbh);
        # store query returns in a 2D array.
        my @rows = ();
        while (
               my (
                   $identifier,  $orig_id,     $sensor_id,
                   $record_date, $start_block, $end_block
                  )
               = $dbh->fetchResults()
              )
        {
           push(@rows,[$identifier,
                       $orig_id,
                       $sensor_id,
                       $record_date, 
                       $start_block, 
                       $end_block]); 
        }
        
        foreach my $row (@rows)
        {
            my $expr = ($prev_end_block+1);
            # Block numbers roll over every $self->{max_blocks}
            my $gap =
              $row->[4] - (($prev_end_block + 1) % $self->{max_blocks});
            if ($gap > 0)
            {
                # Check if by chance this block did not come in out of order.
                my $found = 0;
                foreach my $blk (@rows)
                {
                  if ($blk->[4] == ($prev_end_block+1)%$self->{max_blocks})
                  {
                    $found = 1;
                  }
                }
                unless($found)
                {
                  $message .=
                      "switch:  $switch\n"
                    . "missing: "
                    . $gap . "\n"
                    . "blocks:  "
                    . ($prev_end_block + 1)
                    . " -> " . $row->[4] . "\n";
                }
            }
            $prev_end_block = $row->[5];
        }    # end while
    }    # end foreach

    $dbh->closeConnection();
    return $message;
}

=head3 get_from_hrs_ago()

    Accessor method.
    Returns the value of the instance variable 'from_hrs_ago'.

=cut

sub get_from_hrs_ago
{
    my $self = shift;
    return $self->{from_hrs_ago};
}

=head3 get_to_hrs_ago()

    Accessor method.
    Returns the value of the instance variable 'to_hrs_ago'.

=cut

sub get_to_hrs_ago
{
    my $self = shift;
    return $self->{to_hrs_ago};
}

=head3 get_switches()

    Retrieve valid market switches from the CARES database.

=cut

sub get_switches
{
    my $self         = shift;
    my $dbh          = shift;
    my $switch_query =
      $self->get_sql_query($self->{SqlLib} . $self->{switch_query});

    my $rc = $dbh->setQuery($switch_query);
    if (!defined $rc)
    {
        croak "\nError in setQuery: \n", $dbh->getErrorStr(), "\n\n";
    }

    # execute query with the appropriate bind variables.
    $rc = $dbh->runQuery($self->{from_hrs_ago}, $self->{to_hrs_ago});
    if (!defined $rc)
    {
        croak "\nError in runQuery: \n", $dbh->getErrorStr(), "\n\n";
    }

    my @switches = ();
    while (my ($switch) = $dbh->fetchResults())
    {

        # do not add switches in the ignore list.
        unless (grep $_ eq $switch, split(/,/, $self->{ignore_list}))
        {
            push(@switches, $switch);
        }
    }
    return @switches;
}

=head3 skip_first_day()

    A file that came in late in the past can cause issues when it
    is young enough to transcend the check threshold boundry while
    the next logical block is older and no longer returned by the 
    check query thus creating an artificial block gap.
    This issue can be avoided by reading in an extra day of records.  
    The records are then ordered correctly, and the additional day
    of usage can be ignored. 

=cut

sub skip_first_day
{
    my ($self, $dbh) = @_;
    while (
           my (
               $identifier, $orig_id, $switch, $record_date, $start_block,
               $end_block
              )
           = $dbh->fetchResults()
          )
    {
        my ($yyyy, $mm, $dd, $hh24, $mi, $ss) = split(/[-:\s+]/, $record_date);
        # If the record_date is older than the paging timeframe, skip to the next record.
        # Once you encounter a record within the paging timeframe, exit the loop.
        if ((time() - timelocal($ss, $mi, $hh24, $dd, $mm - 1, $yyyy)) >
            (60 * 60 * $self->{from_hrs_ago}))
        {
            next;
        } else
        {

            # the current row is witin the check time frame.
            # return the end block so it can be used as previous end block
            # in the first comparison.
            return $end_block;
        }
    }    #end while
}

1;
