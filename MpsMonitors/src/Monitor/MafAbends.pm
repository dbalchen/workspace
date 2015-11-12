#!/opt/perl5/bin/perl

=head2 PACKAGE MafAbends

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  use Monitor::MafAbends; 
     
  my $check  = Monitor::MafAbends->new(@arg_list); 
  my $result = $check->run_check();
  
  use Monitor::MafAbends;
  
  my $check  = Monitor::MafAbends->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

- Inherits the Monitor package and its instance variables.
- Check is performed by a main method called run_check, which returns a 
scalar containing a B<formatted string>, which will be displayed verbatim
by the Monitor interfaces. 

=head3 DESCRIPTION

Reports the counts of Collections and Main Driver files in AE or AF status
if the total counts exeeds 10.

=cut

package Monitor::MafAbends;

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

=head3 new (Constructor)

Creates an instance of a MafAbends object.
Sets the class variables from argument pairs.
Inherits superclass variables.
  
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


=head3 Audit Methods

=item get_counts

=over 2

Runs the MafAbends Monitor Audit.
Returns undef if there are less than or equal $self->{alarm_threshold} abends.
Returns a string breakdown of the abends if there are more than
$self->{alarm_threshold} abends.

=back

=cut

sub run_check
{
  my $self = shift;

  my %abend_counts = $self->get_counts();
  
  my $message = '';
  my $total_num_of_abends = 0;
  foreach my $pgm_name (keys(%abend_counts))
  {
    foreach my $fstatus ( keys( %{$abend_counts{$pgm_name}} ))
    {
      $message .= "$pgm_name\t$fstatus\t" 
               . $abend_counts{$pgm_name}{$fstatus} . "\n";
      $total_num_of_abends += $abend_counts{$pgm_name}{$fstatus};
    }
  }
  
  if($total_num_of_abends > $self->alarm_threshold())
  {
    return $message;
  }
  else
  {
    return undef;
  }
}



=item get_counts

=over 2

Gets Collections and Main Driver AF and AE counts from the database.
Organizes the results into a hash of hashes.

=back

=cut

sub get_counts
{
  my $self = shift;
  my $sql = $self->get_sql_query($self->SqlLib . $self->sql_query);
  my $uscdb = $self->get_cares_db();
  
  my $rc = $uscdb->setQuery($sql);
  if (!defined $rc)
  {
      carp "\nError in setQuery: \n", $uscdb->getErrorStr(), "\n\n";
  }

  $rc = $uscdb->runQuery();
  if (!defined $rc)
  {
      carp "\nError in runQuery: \n", $uscdb->getErrorStr(), "\n\n";
  }

  # Create the output hash.
  my %Abends;
  while (my ($program, $file_status, $count) = $uscdb->fetchResults())
  {
      $Abends{$program}{$file_status} = $count;
  }
  return %Abends;
}

=head3 Accessors

=item MpsLib

=over 2

When called without parameters, returns the value of the MpsLib
member variable.
When called with a parameter, sets the value of the MpsLib member
variable to the value of the argument, and then returns the new
value.

=back

=cut

sub MpsLib
{
  my $self = shift;
  my $new_val = shift;
  
  if(defined $new_val)
  {
    $self->{MpsLib} = $new_val;
  }
  
  return $self->{MpsLib};
}


=head3 Accessors

=item SqlLib

=over 2

When called without parameters, returns the value of the SqlLib
member variable.
When called with a parameter, sets the value of the SqlLib member
variable to the value of the argument, and then returns the new
value.

=back

=cut

sub SqlLib
{
  my $self = shift;
  my $new_val = shift;
  
  if(defined $new_val)
  {
    $self->{SqlLib} = $new_val;
  }
  
  return $self->{SqlLib};
}


=item market

=over 2

When called without parameters, returns the value of the market
member variable.
When called with a parameter, sets the value of the market member
variable to the value of the argument, and then returns the new
value.

=back

=cut

sub market
{
  my $self = shift;
  my $new_val = shift;
  
  if(defined $new_val)
  {
    $self->{market} = $new_val;
  }
  
  return $self->{market};
}


=item alarm_threshold

=over 2

When called without parameters, returns the value of the alarm_threshold
member variable.
When called with a parameter, sets the value of the alarm_threshold
member variable to the value of the argument, and then returns the new
value.

=back

=cut

sub alarm_threshold
{
  my $self = shift;
  my $new_val = shift;
  
  if(defined $new_val)
  {
    $self->{alarm_threshold} = $new_val;
  }
  
  return $self->{alarm_threshold};
}


=item title

=over 2

When called without parameters, returns the value of the title
member variable.
When called with a parameter, sets the value of the title member
variable to the value of the argument, and then returns the new
value.

=back

=cut

sub title
{
  my $self = shift;
  my $new_val = shift;
  
  if(defined $new_val)
  {
    $self->{title} = $new_val;
  }
  
  return $self->{title};
}


=item sql_query

=over 2

When called without parameters, returns the value of the sql_query
member variable.
When called with a parameter, sets the value of the sql_query member
variable to the value of the argument, and then returns the new
value.

=back

=cut

sub sql_query
{
  my $self = shift;
  my $new_val = shift;
  
  if(defined $new_val)
  {
    $self->{sql_query} = $new_val;
  }
  
  return $self->{sql_query};
}


1;