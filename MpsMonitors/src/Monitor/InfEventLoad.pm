#!/opt/perl5/bin/perl

=head2 PACKAGE InfEventLoad

=head3 AUTHOR

  Jacob Ray

=head3 SYNOPSIS

  use Monitor::InfEventLoad;

  my $check  = Monitor::InfEventLoad->new(@arg_list);
  my $result = $check->run_check();

  use Monitor::InfEventLoad;

  my $check  = Monitor::InfEventLoad->new(%arg_hash)
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION
    Reports on the IEL (Infranet Event Loader) processing state (up or down).
=cut

package Monitor::InfEventLoad;

use strict;
use warnings;

BEGIN
{
    my %args = @_;
    push @INC, $args{MpsLib};
}

use base qw(Monitor);    # Monitor is the base (parent) class.

use Carp;
use Data::Dumper;

=head3 METHODS

=head3 new()

  Constructor.
  Creates an instance of InfEventLoad.
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
    Performs the InfEventLoad check that depends on the time frame. 
    Returns: Scalar that contains a message indicating an IEL process does exist.
    Or:      undef if an IEL process does not exist.
=cut

sub run_check
{
    my $self    = shift;
	my $log = shift;

   # Use the ps command to search for the IEL process.

   my $grepString = "ps -efx | grep com.uscc.process.EventLoadListener | grep $self->{market} |  grep -v grep |";

    my $return_str = undef;
    open(PS_IEL, $grepString);
    my @res = <PS_IEL>;
    close(PS_IEL);
	
    # Keep this type of logic to provide IEL status to the web monitor??????
    if (@res) {
      if (@res > 1) {
	$return_str .= "$self->{title} There is more the 1 IELEventLoader Running.. Please Contact OPS\n";
      } else {
	$return_str .= "Nothing Found.\n";
      }
    } else {
      $return_str .= "$self->{title}  IEL is down.\n";
    }
    return $return_str;
  }

1;
