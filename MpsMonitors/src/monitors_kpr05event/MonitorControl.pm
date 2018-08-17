#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for APRM 
# Author        : David A Smith
# Date          : Fri Apr 19 11:47:18 CDT 2013
#-------------------------------------------------------------------------------

=head2 PACKAGE  MissingDataFile

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use MonitorControl; 
  
  my $mon = MonitorControl->new(server=>"somehost.uscc.com",
                                port=>"8999",
                                usr=>"mylogin",
                                location=>"/path/to/start/script/");
  
  # Start the monitor
  $mon->start();
  
  # Stop the monitor
  $mon->stop();
  
  # Bounce the monitor
  $mon->bounce();


=head3 DESCRIPTION

  MonitorControl provides utility methods for remotely controling the state 
  of the monitors on a given machine.
  MonitorControl has three basic functions:
  - start
  - stop
  - bounce
  As names suggest, the functions are used to start, stop or bounce the 
  monitor on a given system remotely. 

=cut

package MonitorControl;

use strict;
use warnings;

use Carp;
use IO::Socket;

$| = 1;


=head3 CONSTRUCTOR new()

    Instanciates a MonitorControl object.
    
    Accepts the following parameters in a hash form:
    server   - Address of the monitor host machine.
    port     - TCP/IP port on which the monitor is listening.
    usr      - Login name of an account with execute privileges on the
               StartMonitors script in 'location'.
    location - Complete path to the StartMonitors script location.
    
    The input hash is blessed into the object as instance variables.

=cut

sub new()
{
    my($class,%args) = @_;
    my $self = \%args;
    bless $self, $class;
    return $self;
}


=head3 connect()

    Initiates a socket connection to the monitors on a given remote host.
    Accepts: Integer number of connection attempts before giving up.
    
    The method uses instance variables 'server' and 'port' in attempt
    to open a socket connection to the monitors running on a remote host.
    
    Returns the socket handle if the connection is successful.
    Returns undef if the connection fails.

=cut

sub connect
{
    my $self = shift;
    my $allowed_attempts = shift;
    $allowed_attempts = 10 unless(defined $allowed_attempts);
    my $socket = undef;
    my $attempted = 0;
    
    # connect to the monitor.
    # croak if the monitor is down.
    print "Attempting to open a socket connection " , 
          "to $self->{server} on port $self->{port}.\n";
    while( (!defined $socket) && ($attempted < $allowed_attempts) )
    {
        $socket =
          IO::Socket::INET->new(
                                PeerAddr => $self->{server},
                                PeerPort => $self->{port},
                                Proto    => "tcp",
                                Type     => SOCK_STREAM
                               );
        $attempted++;
        print "\nattempt $attempted ... ";
        sleep 10 unless (defined $socket);
        print "successful!\n" if (defined $socket);
    }
    unless(defined $socket)
    {
      carp "Unable to establish Socket Connection.\n" , 
            "Looks like the Monitor is down.\n";
    }
    return $socket;
}


=head3 stop()

    Stops the monitor.
    Connects to the monitor via socket and issues a stop command.
    The method does not verify if the monitor complies and shuts 
    itself down.  This is considered responsibility of the calling
    script.

=cut

sub stop
{
    my $self = shift;
    my $socket = $self->connect(3);
    if(defined $socket)
    {
      print "Issuing stop command\n";
      print $socket "stop\n";
    }
}


=head3 start()

    Starts the monitor.
    Connects to the remote machine via remote shell,
    changes directory to the StartMonitors script location
    (as provided via constructor), and runs the StartMonitors script;
    The monitor takes approximately 2.5 minutes to boot up and run 
    diagnostics.  The method waits 150 seconds before verifying that the 
    monitors came up by attempting to establish a socket connection.

=cut

sub start
{
    my $self=shift;
    
    my $cmd = "remsh $self->{server} -l $self->{usr} sh <<EOF\n"
            . ". .profile > /dev/null\n"
            . "ls\n"
            . "cd $self->{location}\n"
            . "pwd\n"
            . "StartMonitors\n"
            . "EOF\n";
    my $back = `$cmd`;
    print $back;
    
    # Then, check if the monitors came up.
    if(defined $self->connect(20))
    {
      print "\nThe monitors appear to be up.\n"
    }
}


=head3 bounce()

    Reboots the monitor by calling stop() followed by start().

=cut

sub bounce
{
  my $self = shift;
  $self->stop();
  $self->start();
}

1;