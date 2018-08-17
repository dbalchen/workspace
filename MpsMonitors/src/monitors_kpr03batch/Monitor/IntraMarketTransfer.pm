#!/opt/perl5/bin/perl

=head2 PACKAGE  IntraMarketTransfer


=head3 AUTHOR

  Amy Schnelle

=head3 SYNOPSIS

  use Monitor::IntraMarketTransfer; 
     
  my $check  = Monitor::IntraMarketTransfer->new(@arg_list); 
  my $result = $check->run_check();
  
  
  use Monitor::IntraMarketTransfer;
  
  my $check  = Monitor::IntraMarketTransfer->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a formatted string, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Reports any files claimed by MPS_USAGE_MOVE_AUDIT table to have 
    completed transfer to the remote machine but
    which are not present on the MPS_USAGE_MOVE_AUDIT table on the
    remote machine.  This indicates a failure in the Transfer. 

=cut

package Monitor::IntraMarketTransfer;

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
  Creates an instance of IntraMarketTransfer.
  Sets the class variables from argument pairs.
  
  Returns: a reference to the instanciated object.

=cut

sub new()
{
    my ($class, %args) = @_;
    my $self = $class->SUPER::new();    # inherit Monitor's instance variables.

    # Add properties passed in to the hash of instance variables.
    foreach my $key (keys(%args))
    {
        $self->{$key} = $args{$key};
    }

    bless $self, $class;
    return $self;
}


=head3 run_check()

    Performs the IntraMarketTransfer check.
    
    Returns: Multi-line string scalar that contains the list of 
             names and processing dates of files which did not
             transfer to Infranet.
    Or:      undef if no files are late.

=cut

sub run_check
{
  my $self = shift;
  
  my %local_hash = $self->get_local_data();
  my %remote_hash = $self->get_remote_data();
  # report files, which are present in the cares hash
  # but not in the remotenet hash.
  my %found;
  @found{(keys(%local_hash))} = ();
  delete @found{(keys(%remote_hash))};

  my $message = undef;
  foreach my $late_file (keys(%found))
  {
      $message .= "file: " . $late_file . "\n\n" ;
          #        "recs: " . $local_hash{$late_file} . "\n\n"; 
  }
 return $message;
}



=head3 SUPPORTING SUBROUTINES

    Supporting subroutines for the run_check method.
    Please make sure to write pod documentation for each subroutine.

=cut


=head3 get_local_data()

    Retrieve local data from MPS_USAGE_MOVE_AUDIT.
    Return in form of a hash where the key is the file
    name and the value is the file's processing date.

=cut

sub get_local_data
{
    my $self = shift;
    my $local_query = $self->get_sql_query($self->{SqlLib} . 
                                           $self->{local_query});
    my $local_dbh = $self->get_cares_db();
    my $rc = $local_dbh->setQuery($local_query);
    if (!defined $rc)
    {
        croak "\nError in setQuery: \n", 
              $local_dbh->getErrorStr(), "\n\n";
        print "undefined rc";
    }

    # execute query with the appropriate bind variables.
    $rc = $local_dbh->runQuery($self->{from_hrs_ago},
                               $self->{to_hrs_ago});
    if (!defined $rc)
    {
        croak "\nError in runQuery: \n", 
              $local_dbh->getErrorStr(), "\n\n";        
    }

    # Create the output hash.
    # Key   : file name
    # Value : Processing date.
    my %local_hash;
    while (my ($fname, $date) = $local_dbh->fetchResults())
    {
        $local_hash{$fname} = $date;
    }
    return %local_hash;
}


=head3 get_remote_data()

    Retrieve remote data from MPS_USAGE_MOVE_AUDIT
    Return in form of a hash where the key is the file
    name and the value is the file's processing date.

=cut

sub get_remote_data
{
    my $self = shift;
    my $remote_query = $self->get_sql_query($self->{SqlLib} . 
                                           $self->{remote_query});
    
    my $remote_dbh = $self->get_remote_db();
    my $rc = $remote_dbh->setQuery($remote_query);
    if (!defined $rc)
    {
        croak "\nError in setQuery: \n", 
              $remote_dbh->getErrorStr(), "\n\n";
    }

    # execute query with the appropriate bind variables.
    $rc = $remote_dbh->runQuery($self->{from_hrs_ago});
    if (!defined $rc)
    {
        croak "\nError in runQuery: \n", 
              $remote_dbh->getErrorStr(), "\n\n";        
    }

    my %remote_hash;
    while (my ($file, $num_recs) = $remote_dbh->fetchResults())
    {
        $remote_hash{$file} = $num_recs;
    }
    return %remote_hash;
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
