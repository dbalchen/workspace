#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

=head2   MafMonitor.pl

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  perl MafMonitor.pl MpsLib <path> market <M0X> host <host/ip>
                     usr <usr> passwd <password> Log <path>
                     maf_port <file> 
 
     
=head3 DESCRIPTION

  MafMonitor executable.
  Accepts command line argument list of MafMonitor properties.
  Formats the arguments into a hash.
  Initiates a MafMonitor object passing the argument hash to it.
  Calls the run_check method.
  If defined, prints the return string from run_check to STDOUT.
  
=head3 INPUT PARAMETERS

  The input parameters compose of a list of 'key-value' pairs.  The
  order, in which the pairs appear on the command line is arbitrary.  

=head3 REQUIRED PARAMETER PAIRS

  MpsLib - Specifies absolute path to the root Monitor directory.
           This is the directory where Monitor.pm is located.

  SqlLib - Specifies path to the SQL directory relative.
            
  market - Market on which the check is run.  Format: "MXX"  where
           XX is the two-digit market number.
           
  host   - DNS name of IP address of the host on which the Maf Listener
           is expected to be running.
  
  usr    - user name for the account on the remote host.
  
  passwd - password for the account on the remote host.
  
  maf_port - location of the PID file.
  
  Log    - Location of the log directory.
  
=cut

use strict;
use warnings;

# Add the root Monitor path to @INC.
BEGIN
{
    for ($a = 0; $a < @ARGV; $a++) {
	$ARGV[$a] =~ s/^"//g; $ARGV[$a] =~ s/"$//g;
    }

    if (@ARGV % 2 == 1)
    {
        print STDERR "\nUSAGE\n"
          . "perl MafMonitor.pl MpsLib <path>\n"
          . "                   SqlLib <path>\n"
          . "                   market <market>\n"
          . "                   host <host/ip>\n"
          . "                   usr <user>\n"
          . "                   passwd <password>\n"
          . "                   maf_port <file>\n"
          . "                   Log <path>";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::MafMonitor;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log       =
  Logger->new(log_dir  => $args{Log},
              log_name => "MafMonitor_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate MafMonitor object and run_check()
my $maf_monitor = Monitor::MafMonitor->new(%args);

eval {
    my $result = $maf_monitor->run_check();
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("MafMonitor Error: Nothing Found!\n");
        print STDOUT "Nothing Found!\n";
    }
};


=head3 Exception handler

    Catch exceptions, then die with a more personalized message and 
    a system call stack output.

=cut

if ($@)
{
    $log->print_to_log("Error in MafMonitor run_check method.");
    croak "Error in MafMonitor run_check method.";
}

$log->close_log();
