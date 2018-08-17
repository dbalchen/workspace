#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

=head2 PACKAGE  MafMonitor

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use Monitor::MafMonitor; 
     
  my $check  = Monitor::MafMonitor->new(@arg_list); 
  my $result = $check->run_check();
  
  use Monitor::MafMonitor;
  
  my $check  = Monitor::MafMonitor->new(%arg_hash) 
  my $result = $check->run_check();

=head3 REQIREMENTS

  - Inherits the Monitor package and its instance variables.
  - Check is performed by a main method called run_check, which returns a 
    scalar containing a B<formatted string>, which will be displayed verbatim
    by the Monitor interfaces. 

=head3 DESCRIPTION

    Reports on the processing state (up or down) of each rater expected
    to be processing.

=cut

package Monitor::MafMonitor;

use strict;
use warnings;

BEGIN
{
    my %args = @_;
    push @INC, $args{MpsLib};
}

use base qw(Monitor);    # Monitor is the base (parent) class.

use IO::Socket;
use Carp;
use Data::Dumper;

=head2 METHODS

=head3 new()

  Constructor.
  Creates an instance of MafMonitor.
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

    Performs the MafMonitor check.
    Checks if Maf is up by opening a socket connection to the 
    Maf Listener.  
    
    Returns: String scalar declaring that Maf Listener is running
             and indicates the port.
    Or:      Error message.

=cut

sub run_check
{
    my $self   = shift;
    my $port   = undef;
    my $socket = undef;

    # get the port number from file;
    eval { $port = $self->get_maf_port(); };
    if ($@)
    {
        $port = -1;
    }
    print "Opening socket on port $port ... ";

    # Attempt up to 10 times to connect to the monitor.
    my $attempts = 0;
    while ((!defined $socket) && $attempts < 10)
    {
        $socket =
          IO::Socket::INET->new(
                                PeerAddr => $self->{host},
                                PeerPort => $port,
                                Proto    => "tcp",
                                Type     => SOCK_STREAM
                               );
        $attempts++;
        sleep 10 unless (defined $socket);
        print "successful!\n" if (defined $socket);
    }
    print "\n";
    unless (defined $socket)
    {
        return "Maf is DOWN!\n";
    }

    $attempts = 0;
    while (my $buff = <$socket> || $attempts < 20)
    {
        chomp $buff;
        sleep 1;

        # Once MafMonitor has been received, send request to the Maf monitor
        # asking it for a status.
        if ($buff eq "MafMonitor")
        {
            print $socket "status\n";
        }

        # Monitor has responded that it is up and running.
        if ($buff eq "Running")
        {

            # Disconnect from Monitor
            print $socket "disc\n";
            $buff = <$socket>;
            return undef;
        }
        $attempts++;
    }

    # if you made it this far, then Maf is down.
    return "Maf is DOWN!\n";

    shutdown($socket, 2);    # Stopped using socket
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

=head3 get_MpsLib()

    Accessor method.
    Returns the value of the instance variable 'MpsLib'.

=cut    

sub get_MpsLib
{
    my $self = shift;
    return $self->{MpsLib};
}

=head3 get_maf_port()

    Reads the port file and returns the port on which
    Maf is expected to be running.

=cut

sub get_maf_port
{
    my $self = shift;
    my $port = undef;
    open(PORT, $self->{maf_port})
      or croak "ERROR: unable to open port file : $self->{maf_port}\!\n";  

    while (<PORT>)
    {
        if (/PORT=(\d+)/)
        {
            $port = $1;
        }
    }

    close(PORT)
      or carp "WARNING: unable to close port file $self->{maf_port}.\n";

    unless (defined $port)
    {
        croak "ERROR: unable to retrieve Maf Port number\!\n";
    }
    return $port;
}

1;
