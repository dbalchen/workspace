#!/opt/perl5/bin/perl

=head2 monitors.pl

=head3 AUTHOR

  Pete Chudykowski

=head3 DESCRIPTION

  monitors.pl is a script utility which allows to remotely start, stop,
  or bounce the MPS Monitors.
  Monitors are started by executing a StartMonitors command on the remote
  production machine(s).  This is done via the Net::Telnet module, which
  requires login information.  User is required to provide User ID and
  Password for production interactively on the command line.


=head3 USAGE:

  monitors.pl -action [target]
  monitors.pl [-start|-stop|-bounce] [m0X,m0Y|all]

  -h --help       Display this help message.

  ACTION:
  -start          Start the monitors on the specified markets.
  -stop           Stop the monitors on the specified markets.
  -bounce         Bounce the monitors on the specified markets.

  TARGET:
  m0X,m0X         List of markets on which to perform the Action.  X = market number
  all (default)   Performs the Action on all markets defined in config.xml


=head3 SYNOPSIS

  monitors.pl -start              #start the monitors on all markets
  monitors.pl -start all          #start the monitors on all markets
  monitors.pl -stop m01           #stop m01 monitor only
  monitors.pl -bounce m02,m03,m06 #bounce monitors on markets 2, 3, and 6

=cut


use strict;

BEGIN
{
  unshift @INC,"/users/md1pchu1/lib/perl5/site_perl/5.8.0/";
}

use Carp;
use MonitorControl;
use XML::Simple;
use Term::ReadKey;

=head3 monitors main

  Determine what action the user requested (start, stop, bounce).
  Perform the action on the specified target markets.
  Display usage if command is malformatted or help was requested.

=cut

if(grep /-start/, @ARGV)
{
  # check if the target is defined
  # if not set to all
  my $markets = "all";
  for(my $i=0; $i<@ARGV; $i++)
  {
    if($ARGV[$i] eq "-start")
    {
      $markets = $ARGV[$i+1];
      last; 
    }
  }
  start(parse($markets));     
}
elsif(grep /-stop/,@ARGV)
{
  # check if the target is defined
  # if not set to all
  my $markets = "all";
  for(my $i=0; $i<@ARGV; $i++)
  {
    if($ARGV[$i] eq "-stop")
    {
      $markets = $ARGV[$i+1];
      last; 
    }
  }
  stop(parse($markets));     
}
elsif(grep /-bounce/,@ARGV)
{
  # check if the target is defined
  # if not set to all
  my $markets = "all";
  for(my $i=0; $i<@ARGV; $i++)
  {
    if($ARGV[$i] eq "-bounce")
    {
      $markets = $ARGV[$i+1];
      last; 
    }
  }
  bounce(parse($markets));
}
elsif(grep /-h/, @ARGV or 
      grep /--help/, @ARGV or
      @ARGV == 0)
{
  print usage();
  exit -1;
}
else
{
  croak "ERROR: Unknown or undifined action!\n\n" , usage();
}


=head3 parse()

  Parses the action target argument.
  Returns a list of markets targeted for action.

=cut
sub parse
{
  my $markets = shift;
  my $config = get_config();
  
  my @markets = ();
  if($markets eq "all")
  {
    return sort(keys(%$config));
  }
  else
  {
    foreach my $mkt (split(/,/,$markets))
    {
      #simple validity check
      if(grep $mkt,(keys(%$config)))
      {
        push(@markets, $mkt);
      }
      else
      {
        croak "\nWARNING: $mkt is not a valid market.\n";
      }
    }# end foreach
  }# end if-else
  return @markets;
}


=head3 start()

  Start the moniotrs on requested markets.
  Unless already defined, asks user for connect info.

=cut

sub start
{
  my @markets = @_;
  my $config = get_config();
  
  unless(defined $config->{login})
  {
    print "\nEnter production user ID: ";
    $config->{login} = <STDIN>;
    chomp $config->{login};
  }
    
  unless(defined $config->{passwd})
  { 
    print "\nEnter production password for $config->{login}: ";
    ReadMode('noecho');
    $config->{passwd} = <STDIN>;  #ReadLine(0);
    chomp $config->{passwd};
    ReadMode('normal');
    print "\n";
  }
    
  foreach my $mkt (@markets)
  {
    print "\nStarting " . uc($mkt) . " monitors ... \n";
    print "server: ", $config->{$mkt}->{server} , "\n";
    my $mon = MonitorControl->new(server=>$config->{$mkt}->{server},
                                  port=>$config->{$mkt}->{port},
                                  login=>$config->{login},
                                  passwd=>$config->{passwd},
                                  location=>$config->{$mkt}->{location});
    $mon->start();
    print "done.\n\n";
  }
}


=head3 stop()

  Stop the moniotrs on requested markets.

=cut

sub stop
{
  my @markets = @_;
  my $config = get_config();
  
  foreach my $mkt (@markets)
  {
    print "Stopping $mkt monitors ... \n";
    my $mon = MonitorControl->new(server=>$config->{$mkt}->{server},
                                  port=>$config->{$mkt}->{port},
                                  usr=>$config->{$mkt}->{login},
                                  location=>$config->{$mkt}->{location});
    $mon->stop();
    print "done.\n\n";
  }
}


=head3 bounce()

  Bounce the moniotrs on requested markets.

=cut

sub bounce
{
  my @markets = @_;
  my $config = get_config();
  
  unless(defined $config->{login})
  {
    print "\nEnter production user ID: ";
    $config->{login} = <STDIN>;
    chomp $config->{login};
  }
    
  unless(defined $config->{passwd})
  { 
    print "\nEnter production password for $config->{login}: ";
    ReadMode('noecho');
    $config->{passwd} = <STDIN>;  #ReadLine(0);
    chomp $config->{passwd};
    ReadMode('normal');
    print "\n";
  }
  
  foreach my $mkt (@markets)
  {
    print "Bouncing $mkt monitors ... \n";
    my $mon = MonitorControl->new(server=>$config->{$mkt}->{server},
                                  port=>$config->{$mkt}->{port},
                                  login=>$config->{login},
                                  passwd=>$config->{passwd},
                                  location=>$config->{$mkt}->{location});
    $mon->bounce();
    print "done.\n\n";
  }
}


=head3 get_config()

  Parse the XML configuration file.
  Return the config hash.

=cut

sub get_config
{
  return XML::Simple->new()->XMLin("config.xml");
}


=head3 usage()

  Return help/usage.

=cut

sub usage
{
  return "\nUSAGE:\n"
       . "monitors.pl [-start|-stop|-bounce] [m0X,m0Y|all]\n\n"
       . "-h --help \tDisplay this help message.\n\n"
       . "ACTION:\n"
       . "-start \t\tStart the monitors on the specified markets.\n"
       . "-stop \t\tStop the monitors on the specified markets.\n"
       . "-bounce \tBounce the monitors on the specified markets.\n\n"
       . "VALUE:\n"
       . "m0X,m0X \tList of markets on which to perform the Action.  "
       . "X = market number\n"
       . "all (default)\tPerforms the Action on all markets defined in "
       . "config.xml\n\n"
       . "EXAMPLES:\n"
       . "monitors.pl -start\t\t#start the monitors on all markets\n"
       . "monitors.pl -start all\t\t#start the monitors on all markets\n"
       . "monitors.pl -stop m01\t\t#stop m01 monitor only\n"
       . "monitors.pl -bounce m02,m03,m06\t#bounce monitors on markets "
       . "2, 3, and 6\n\n";
}
  
=head3 TODO

  Thread the start method instead of looping to speed up the process of
  bringing up the monitors.

=cut