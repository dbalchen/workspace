#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

=head2 PACKAGE  ProgramBehind

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use Monitor::ProgramBehind; 
  
  my $check  = Monitor::ProgramBehind->new(@arg_list); 
  my $result = $check->run_check();
  
  use Monitor::ProgramBehind;
  
  my $check  = Monitor::ProgramBehind->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Reports programs that have been are processing a number of rows that is
    above the specified threshold.

=cut

package Monitor::ProgramBehind;

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
  Creates an instance of ProgramBehind.
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

    Performs the ProgramBehind check.
    
    Returns: Multi-line string scalar that contains the list of 
             programs which are at least $self::$threshold  
             records behind processing.
    Or:      "Nothing Found" if no switches are behind processing.

=cut

sub run_check
{
    my $self = shift;

    my $query = $self->get_sql_query($self->{SqlLib} . $self->{sql_query});
    my %programHash = $self->get_data($query);

    my $message = undef;
    foreach my $program (keys(%programHash))
    {
        $message .=
            "Program:      " . $program . "\n"
          . "File Status:  "
          . $programHash{$program}[0] . "\n"
          . "File Count:   "
          . $programHash{$program}[1] . "\n"
          . "Record Count: "
          . $programHash{$program}[2] . "\n\n";
    }
    return $message;
}

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
        carp "Could not connect to Oracle!", $uscdb->getErrorStr(), "\n\n";
    }

    return $uscdb;
}

=head3 get_data

  Retrieves switch_behind data from the default database.

=cut

sub get_data
{
    my ($self, $sql) = @_;
    my $uscdb = $self->get_db();

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
    # Key   : switch name
    # Value : Date of the most recently received file.
    my %programHash;
    while (my ($program, $file_status, $file_count, $record_count) =
           $uscdb->fetchResults())
    {
        $programHash{$program} = [$file_status, $file_count, $record_count];
    }
    return %programHash;

}


1;
