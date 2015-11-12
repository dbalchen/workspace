#!/opt/perl5/bin/perl

=head2 PACKAGE  SwitchBehind

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use Monitor::SwitchBehind; 
     
  my $check  = Monitor::SwitchBehind->new(@arg_list); 
  my $result = $check->run_check();
    
  use Monitor::SwitchBehind;
  
  my $check  = Monitor::SwitchBehind->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Reports any switches that have been are behind processing for a specified 
    period of time.

=cut

package Monitor::SwitchBehind;

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
  Creates an instance of SwitchBehind.
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

    Performs the SwitchBehind check.
        
    Returns: Multi-line string scalar that contains the list of 
             switches which are at least $self::$threshold hours 
             behind processing.
    Or:      "Nothing Found" if no switches are behind processing.

=cut

sub run_check
{
    my $self = shift;

    my $query      = $self->get_sql_query($self->{SqlLib} . $self->{sql_query});
    my %switchHash = $self->get_data($query);

    my $message = undef;
    foreach my $switch (keys(%switchHash))
    {
        $message .= $switch . ": Last File: " . $switchHash{$switch} . "\n";
    }

    return $message;
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

=head3 get_threshold()

    Accessor method.
    Returns the value of the instance variable 'hours behind'.

=cut

sub get_threshold
{
    my $self = shift;
    return $self->{threshold};
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

=head3 get_SqlLib()

    Accessor method.
    Returns the value of the instance variable 'SqlLib'.

=cut    

sub get_SqlLib
{
    my $self = shift;
    return $self->{SqlLib};
}

=head3 get_data

  Retrieves switch_behind data from the default database.

=cut

sub get_data
{
    my ($self, $sql) = @_;
    my $tz = $self->get_time_zone();

    my $uscdb = $self->get_db();

    my $rc = $uscdb->setQuery($sql);
    if (!defined $rc)
    {
        croak "\nError in setQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }

    # execute query with the appropriate bind variables.
    $rc = $uscdb->runQuery($self->{threshold}, $tz, $self->{threshold});
    if (!defined $rc)
    {
        croak "\nError in runQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }

    # Construct the ignore_switch Hash
    my %ign_sw;
    foreach my $ign (split(/,+/, $self->{ignore_list}))
    {
        my ($sw, $ign_days) = split(/:/, $ign);
        unless (defined $ign_days)
        {
            $ign_days =
              "Not null to prevent an undef in concatination warning.";
        }
        $ign_sw{$sw} = $ign_days;
    }
    my $dow = (localtime())[6];

    # Create the output hash.
    # Key   : switch name
    # Value : Date of the most recently received file.
    my %switchHash;
    while (my ($switch, $date) = $uscdb->fetchResults())
    {

        # do not add switches in the ignore list.
        unless (defined $ign_sw{$switch} or $ign_sw{$switch} =~ m/$dow/)
        {
            $switchHash{$switch} = $date;
        }
    }
    return %switchHash;

}

=head3 get_time_zone()

  Retrieve the local time zone from %ENV

=cut

sub get_time_zone
{
    my $self = shift;
    my $tz;

    if ((gmtime())[8] == 0)
    {
        $tz = substr($ENV{TZ}, 0, 3);
    } else
    {
        $tz = substr($ENV{TZ}, 4, 3);
    }
    return $tz;
}

=head3 get_db

  Instanciates a USCDB object.
  Initializes database connection.
  Returns reference to the instanciated USCDB object.

=cut

sub get_db
{
    my $self        = shift;
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
        print "Could not connect to Oracle!"; 
       carp "Could not connect to Oracle!", $uscdb->getErrorStr(), "\n\n";
    }

    return $uscdb;
}


1;
