#!/opt/perl5/bin/perl

=head2 Monitor

  Provides an Interface for Monitor Check classes.

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use base qw(Monitor); 
  
  sub new
  {
      my $class = shift;   
      my $self = Monitor->new();
      bless $self, $class; 
  }    

=cut

package Monitor;

use strict;
use warnings;

use Carp;

=head2 METHODS

=head3 new()

    Desc  : Create New Instance of Monitor Object

    Params: None

   Returns: Instance of Monitor Object

=cut

sub new()
{
    my $class = shift;
    return bless {}, $class;
}

=head3 run_check()

    Fake annonymous subroutine by using Inheritence Polymophism.
    Since Perl does not seem to provide an Interface construct 
    that would require subclasses to contain a specified method,
    we will create a run_check method in the superclass which will 
    always throw an exception.

=cut

sub run_check
{
    my $self = shift;
    croak ref($self), " does not provide required run_check() method\n", $!;
}

=head3 get_remote_db

  Instanciates a USCDB object.
  Initializes database connection.
  Returns reference to the instanciated USCDB object.

=cut

sub get_remote_db
{
    my $self        = shift;
    my $uscdb       = USCDB->new();
    my @connect_str = ("PU2" . $self->{remote_market},"read_all","read_all");
#      $uscdb->getDBParmsfromOper($self->{op_job},  $self->{op_sid},
#                                 $self->{op_user}, $self->{op_pass});

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

=head3 get_cares_db

  Instanciates a USCDB object.
  Initializes database connection.
  Returns reference to the instanciated USCDB object.

=cut

sub get_cares_db
{
    my $self        = shift;
    my $uscdb       = USCDB->new();
    my @connect_str = ("PU2" . $self->{market},"read_all","read_all");
#      $uscdb->getDBParmsfromOper($self->{op_job},  $self->{op_sid},
#                                 $self->{op_user}, $self->{op_pass});

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

=head3 get_infra_db

  Instanciates a USCDB object.
  Initializes database connection.
  Returns reference to the instanciated USCDB object.

=cut

sub get_infra_db
{
    my $self        = shift;
    my $uscdb       = USCDB->new();
    my @connect_str = ("infra" . $self->{market},"invuser","portal16");
#      $uscdb->getInfranetDBParmsfromOper($self->{op_job}, $self->{op_sid},
#                                         $self->{op_user}, $self->{op_pass});

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

=head3 get_sql_query()

    Read a SQL query from a file, format and return as 
    a string scalar.
    Takes   : sql file
    Returns : sql string
    
=cut

sub get_sql_query
{
    my $self     = shift;
    my $sql_file = shift;
    my $query;

    open(QUERY, $sql_file);
    $query .= $_ for (<QUERY>);
    close(QUERY);
    return $query;
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

=head3 get_market()

    Accessor method.
    Returns the value of the instance variable 'market'.
    
=cut

sub get_market
{
    my $self = shift;
    return $self->{market};
}

1;
