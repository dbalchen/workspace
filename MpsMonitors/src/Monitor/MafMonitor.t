#!/opt/perl5/bin/perl

=head2 MafMonitor Unit Test Suite. 
  
=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl MafMonitor.t MpsLib <path> market <M0X> host <host/ip>
                    usr <usr> passwd <password> remote_port_file <file>

=head3 DESCRIPTION

  Tests basic functionality of the MafMonitor class.

=head3 INPUT PARAMETERS

  The input parameters comprise of the following pairs:
  Key:          Value:    Description:
  MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
  market        <M0X>     Attribute of monitor.xml <params> tab.
  host          <host/ip> Domain name or IP of the test environment host.
  usr           <user>    User name of the test environment account.
  passwd        <passwd>  Password to the test environment account.
  remote_port_file
                <file>    Path and name of the port file in the test
                          environment.

=cut

use strict;
use warnings;

BEGIN
{
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Test::More 'no_plan';    # you can replace the 'no_plan' with (tests=>n)
                             # where n is the number of tests in the suite.
use Net::Telnet;
use Carp;

$| = 1;

my %args = @ARGV;

env_update($args{host}, $args{usr}, $args{passwd}, $args{remote_maf_port});

=head3 TESTS 

=head3 Test Monitor

  Verifies that the Monitor module is visible and accessible.

=cut

use_ok('Monitor');

=head3 Test Monitor::MafMonitor

  Verifies that the MafMonitor module is visible and accessible.

=cut

use_ok('Monitor::MafMonitor');

=head3 Test Inheritance

  Verifies that MafMonitor is a sub class of Monitor.

=cut

my $maf_monitor = Monitor::MafMonitor->new(%args);

ok($maf_monitor->isa('Monitor::MafMonitor'),
    "Object is of type Monitor::MafMonitor");

=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($maf_monitor->get_market()),
    'M01', "Object is set up for the correct market");

=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($maf_monitor->get_MpsLib(), $args{MpsLib}, "MpsLib is set correctly");

=head3 Test get_maf_port()

  Test method get_maf_port().

=cut   

ok($maf_monitor->get_maf_port(), "get_maf_port() returns a defined value");

=head3 Test run_check()

  Verify that run_check() returns the expected string
  when the Monitor is up..

=cut

env_update($args{host}, $args{usr}, $args{passwd}, $args{remote_maf_port});

# get a new instance of $MafMonitor
$maf_monitor = Monitor::MafMonitor->new(%args);
my $return_str = $maf_monitor->run_check();
is($return_str,
    "Maf monitor is UP.",
    'run_check() returns expected value when monitor is up');

=head3 Test error condition

  Verify that run_check reports correctly when Maf Listener is down.

=cut

my $t = env_login($args{host}, $args{usr}, $args{passwd});
stop_maf($t);
update_port($t, $args{remote_maf_port});

# get a new instance of MafMonitor
$maf_monitor = Monitor::MafMonitor->new(%args);
$return_str  = $maf_monitor->run_check();
is($return_str,
    "Maf monitor is DOWN!",
    'run_check() returns expected value when monitor is down');
disconnect($t);

=head3 env_update

    Telnet into the testing environment.
    Stop Maf.
    Start Maf.
    Update MafPort.txt with the new port.

=cut

sub env_update
{
    my ($host, $usr, $passwd, $port_file) = @_;
    print "Setting up test environment $usr on $host.\n";
    my $t = env_login($host, $usr, $passwd);
    stop_maf($t);
    start_maf($t);
    update_port($t, $port_file);
    disconnect($t);
}

=head3 env_login()

    Telnet into the testing environment.
    Takes:  host
            username
            password 
    Return telnet handle.

=cut

sub env_login
{
    my ($host, $usr, $passwd) = @_;
    my $t = Net::Telnet->new(Timeout => 120);
    print "connecting   ... ";
    $t->open($host);
    print "done.\nlogging in   ... ";
    $t->login($usr, $passwd) or croak "Unable to log in to $host\n";
    print "done.\n";
    return $t;
}

=head3 stop_maf()

    Stop Maf.
    Takes: telnet handle.

=cut

sub stop_maf
{
    my $t = shift;
    print "stopping maf ... ";
    my @lines = $t->cmd("mps_lsn_stop_sh");

    #    print @lines, "\n\n";
    sleep 30;
    print "done.\n";

}

=head3 start_maf()

    Start Maf.
    Takes: telnet handle.

=cut

sub start_maf
{
    my $t = shift;
    print "starting maf ... ";
    my @lines = $t->cmd("mps_lsn_sh");
    print "done.\n";
}

=head3 update_port()

    Update MafPort.txt with the new port.
    Takes: telnet handle.

=cut

sub update_port    
{
    my ($t, $remote_port_file) = @_;
    my @port = $t->cmd("cat $remote_port_file");
    for (@port)
    {
        chomp;
        if (/PORT/)
        {
            open(PORT_FILE, ">$args{maf_port}")
              or croak "unable to open $args{maf_port} for writing!\n";
            print PORT_FILE $_;
            close(PORT_FILE);
            last;
        } else
        {
            unlink $args{maf_port};
        }
    }
}

=head3 disconnect()

    Disconnect from the telnet session.

=cut

sub disconnect
{
    my $t = shift;
    print "disconnecting ... ";
    $t->close();
    print "done.\n";
}

