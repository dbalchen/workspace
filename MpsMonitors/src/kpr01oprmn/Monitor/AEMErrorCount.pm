#!/usr/bin/perl

=head2 PACKAGE  AEMErrorCount 

=head3 AUTHOR

  Steven Roehl

=head3 SYNOPSIS

  use Monitor::AEMErrorCount; 
     
  my $errors = Monitor::AEMErrorCount->new(@arg_list); 
  my $result = $errors->run_check();
  
  use Monitor::AEMErrorCount;
  
  my $errors  = Monitor::AEMErrorCount->new(%arg_hash) 
  my $result = $errors->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Count is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Gets the errors that are generated on a daily basis

=cut

package Monitor::AEMErrorCount;

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
  Creates an instance of AEMErrorCount.
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

    Performs the error run_check
        
    Returns: Multi-line string scalar that contains the error
		count by date
    Or:      undef.
=cut

sub run_check
{
    my $self = shift;

#    my $query     = $self->get_sql_query($self->{SqlLib}.$self->{sql_query});
#   
 my $query = "select trunc(sys_creation_date),error_id,count(*) from ape1_rejected_event where processing_status not in ('CO','FI') and sys_creation_date > sysdate-60 group by trunc(sys_creation_date),error_id order by error_id asc, trunc(sys_creation_date) desc";
    my %errorHash = $self->get_data($query);

    my $message = undef;
    #$message = "<div style=\"display:none\"<table id=\"data\"><tr><th>Date</th><th>Error</th><th>Count</th></tr>";
    $message ="{\n\"aaData\":[\n";
    my $first = 1;
    foreach my $date (keys(%errorHash))
    {
      foreach my $error (keys %{$errorHash{$date}}){
        if($first){
          $message .= "[\"".$error."\",\"$date\",\"".$errorHash{$date}{$error}."\"]";
          $first=0;
        }else{
          $message .= ",\n[\"".$error."\",\"$date\",\"".$errorHash{$date}{$error}."\"]";
        }
        #$message .= "<tr><td>$date</td><td>" . $errorHash{$date}[0] . "</td><td>" . $errorHash{$date}[1] . "</td></tr>";
      }
    }
    $message .="\n]\n}";
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
    my ($self,$job,$sid,$dbuser,$dbpass) = @_;
    my $uscdb       = USCDB->new();
    my @connect_str =
      $uscdb->getDBParmsfromOper($job,  $sid,
                                 $dbuser, $dbpass);

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
    my $dbPwd = "BODS_SVC_BILLINGOPS";
    my $uscdb = (DBI->connect("DBI:Oracle:$dbPwd",,));
    unless (defined $uscdb) {sendErr();}
    
    # Create the output hash.
    my %errorHash;
   
    my $sth = $uscdb->prepare($sql);
       $sth->execute() or die $DBI::errstr;

    # execute query with the appropriate bind variables.
      $sth->execute() or die $DBI::errstr;

      while (my ($date,$error,$count) = $sth->fetchrow_array())
      {
          if(defined($errorHash{$date}{$error})){
            $errorHash{$date}{$error} += $count;
          }else{
	    $errorHash{$date}{$error} = $count;
          }
      }
 
   return %errorHash; 
}

1;    
