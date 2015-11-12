#!/opt/perl5/bin/perl

=head2 PACKAGE  InfraTransfer


=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use Monitor::InfraTransfer; 
     
  my $check  = Monitor::InfraTransfer->new(@arg_list); 
  my $result = $check->run_check();
  
  
  use Monitor::InfraTransfer;
  
  my $check  = Monitor::InfraTransfer->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a formatted string, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Reports any files claimed by ac_processing_accounting table to have 
    completed transfer to Infranet but which are not present on the 
    uscc_usage_audit_t table (which implicates transfer faliure).

=cut

package Monitor::InfraTransfer;

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
  Creates an instance of InfraTransfer.
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

    Performs the InfraTransfer check.
    
    Returns: Multi-line string scalar that contains the list of 
             names and processing dates of files which did not
             transfer to Infranet.
    Or:      undef if no files are late.

=cut

sub run_check
{
  my $self = shift;

  my %cares_hash = $self->get_cares_data();
  my %infra_hash = $self->get_infra_data();
        
  # report files, which are present in the cares hash
  # but not in the infranet hash.
  my %found;
  @found{(keys(%cares_hash))} = ();
  delete @found{(keys(%infra_hash))};

  my $message = undef;
  foreach my $late_file (keys(%found))
  {
      $message .= "file: " . $late_file . "\n" .
                  "recs: " . $cares_hash{$late_file} . "\n\n"; 
  }
  return $message;
}



=head3 SUPPORTING SUBROUTINES

    Supporting subroutines for the run_check method.
    Please make sure to write pod documentation for each subroutine.

=cut


=head3 get_cares_data()

    Retrieve Cares data from ac_processing_accounting.
    Return in form of a hash where the key is the file
    name and the value is the file's processing date.

=cut

sub get_cares_data
{
    my $self = shift;
    my $cares_query = $self->get_sql_query($self->{SqlLib} . 
                                           $self->{cares_query});
#    print "cares query: $cares_query, $self->{from}, $self->{to}\n";
    
    my $cares_dbh = $self->get_cares_db();
    my $rc = $cares_dbh->setQuery($cares_query);
    if (!defined $rc)
    {
        croak "\nError in setQuery: \n", 
              $cares_dbh->getErrorStr(), "\n\n";
    }

    # execute query with the appropriate bind variables.
    $rc = $cares_dbh->runQuery($self->{from_hrs_ago},
                               $self->{to_hrs_ago});
    if (!defined $rc)
    {
        croak "\nError in runQuery: \n", 
              $cares_dbh->getErrorStr(), "\n\n";        
    }


    # Create the output hash.
    # Key   : file name
    # Value : Processing date.
    my %cares_hash;
    while (my ($fname, $date) = $cares_dbh->fetchResults())
    {
        $cares_hash{$fname} = $date;
    }
    return %cares_hash;
}


=head3 get_infra_data()

    Retrieve Infranet data from ac_processing_accounting.
    Return in form of a hash where the key is the file
    name and the value is the file's processing date.

=cut

sub get_infra_data
{
    my $self = shift;
    my $infra_query = $self->get_sql_query($self->{SqlLib} . 
                                           $self->{infra_query});
    
    my $infra_dbh = $self->get_infra_db();
    my $rc = $infra_dbh->setQuery($infra_query);
    if (!defined $rc)
    {
        croak "\nError in setQuery: \n", 
              $infra_dbh->getErrorStr(), "\n\n";
    }

    # execute query with the appropriate bind variables.
    my $from = (time() - (60 * 60 * $self->{from_hrs_ago}));
    $rc = $infra_dbh->runQuery($from);
    if (!defined $rc)
    {
        croak "\nError in runQuery: \n", 
              $infra_dbh->getErrorStr(), "\n\n";        
    }

    my %infra_hash;
    while (my ($file, $num_recs) = $infra_dbh->fetchResults())
    {
        $infra_hash{$file} = $num_recs;
    }
    return %infra_hash;
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

1;