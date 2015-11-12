#!/opt/perl5/bin/perl

=head2 PACKAGE  StuckFile

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use Monitor::StuckFile; 
     
  my $check  = Monitor::StuckFile->new(@arg_list); 
  my $result = $check->run_check();
  
  use Monitor::StuckFile;
  
  my $check  = Monitor::StuckFile->new(%arg_hash) 
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

package Monitor::StuckFile;

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
  Creates an instance of StuckFile.
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

    Performs the StuckFile check.
        
    Returns: Multi-line string scalar that contains the list of 
             files which has been in an 'IU' status for at least 
             $self::$threshold hours.
    Or:      undef.

=cut

sub run_check
{
    my $self = shift;

    my $query     = $self->get_sql_query($self->{SqlLib} . $self->{sql_query});
    my %stuckHash = $self->get_data($query);

    my $message = undef;
    foreach my $stuck (keys(%stuckHash))
    {
        $message .=
            "File Stuck  : " . $stuck . "\n"
          . "Stuck in    : "
          . $stuckHash{$stuck}[0] . "\n"
          . "Stuck since : "
          . $stuckHash{$stuck}[1] . "\n\n";
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
    my $uscdb = $self->get_cares_db();

    my $rc = $uscdb->setQuery($sql);
    if (!defined $rc)
    {
        carp "\nError in setQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }

    # execute query with the appropriate bind variables.
    $rc = $uscdb->runQuery($self->{threshold});
    if (!defined $rc)
    {
        carp "\nError in runQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }

    # Create the output hash.
    my %stuckHash;
    while (my ($program, $date, $id) = $uscdb->fetchResults())
    {
        $stuckHash{$id} = [$program, $date];
    }
    return %stuckHash;

}

1;    
