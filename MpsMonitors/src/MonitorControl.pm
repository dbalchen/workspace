#!/opt/perl5/bin/perl

=head2 PACKAGE  MonitorControl

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  use MonitorControl; 
  
  my $mon = MonitorControl->new(server=>"somehost.uscc.com",
                                port=>"8999",
                                Cargs=>"M0X",
                                login=>$username,
                                passwd=>$password,
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
use Net::Telnet;


$| = 1;


=head3 CONSTRUCTOR new()

    Instanciates a MonitorControl object.
    
    Accepts the following parameters in a hash form:
    server   - Address of the monitor host machine.
    port     - TCP/IP port on which the monitor is listening.
    usr      - Login name of an account with execute privileges on the
               StartMonitors script in 'location'.
    passwd   - Password for the account.  
               WARNING: no security is implemented at this level.
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
#    print "Connecting to the monitor ... ";   #DEBUG
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
        sleep 10 unless (defined $socket);
        print "Done.\n" if (defined $socket);
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
      print $socket "stop\n";
      return 1;
    }
    else
    {
      return undef;
    }
}


=head3 start()

    Starts the monitor.
    Connects to the remote machine via the Net::Telnet module,
    changes directory to the StartMonitors script location
    (as provided in constructor), and runs the StartMonitors script;
    The monitor takes approximately 2.5 minutes to boot up and run 
    diagnostics.  The method waits 150 seconds before verifying that the 
    monitors came up by attempting to establish a socket connection.

=cut

sub start
{
    my $self=shift;
   
    my $t = Net::Telnet->new(Timeout => 30,
                             Prompt  => '/>/');
    print "connecting to $self->{server}  ... ";   #DEBUG
    $t->open($self->{server});
    print 'done',"\n";   #DEBUG
    print "logging in user $self->{login} ... ";   #DEBUG
    $t->login($self->{login}, 
              $self->{passwd}) 
       or croak "Unable to log in to $self->{server}\n";
    print 'done',"\n";   #DEBUG
    $t->cmd("cd $self->{location}");
    my @lines = $t->cmd('pwd');
    print @lines , "\n\n";   #DEBUG
    my $hh = 'StartMonitors '.$self->{Cargs};
    print "Here we go!!!! $hh \n";
    @lines = $t->cmd("$hh");
    print @lines, "\n\n";   #DEBUG
    $t->close();
      
    # Then, check if the monitors came up.
    if(defined $self->connect(30))
    {
      return 1;
    }
    else
    {
      return undef;
    }
}


=head3 bounce()

    Reboots the monitor by calling stop() followed by start().

=cut

sub bounce
{
  my $self = shift;
  print "Stopping the Monitors.\n";
  print "Monitors stopped\n" if($self->stop());
  print "Starting the Monitors.\n";
  print "Monitors started\n" if($self->start());
}

1;
