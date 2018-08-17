#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

=head2 OutcollectCiber.pl

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  perl OutcollectCiber.pl MpsLib <path> threshold <int hours>  
                          market <M0X> phys_dir <dir> Log <path>

=head3 DESCRIPTION

  OutcollectCiber executable.
  Accepts command line argument list of OutcollectCiber properties.
  Formats the arguments into a hash.
  Initiates a OutcollectCiber object passing the argument hash to it.
  Calls the run_check method.
  If defined, prints the return string from run_check to STDOUT.

=head3 INPUT PARAMETERS

  The input parameters compose of a list of 'key-value' pairs.  The
  order, in which the pairs appear on the command line yeais arbitrary.  

=head3 REQUIRED PARAMETER PAIRS

  MpsLib    - Specifies absolute path to the root Monitor directory.
              This is the directory where Monitor.pm is located.

  market    - Market on which the check is run.  Format: "MXX"  where
              XX is the two-digit market number.

  threshold - Number of hours permitted for a gap between arriving
              Outcollect Ciber files.

  phys_dir  - Location of the Outcollect Ciber files directory.

  Log       - Location of the log directory.

=cut

use strict;
use warnings;

# Add the root Monitor path to @INC.
BEGIN
{
    for ($a = 0; $a < @ARGV; $a++) {
	$ARGV[$a] =~ s/^"//g; $ARGV[$a] =~ s/"$//g;
#print "$a : $ARGV[$a]\n";
    }

    if (@ARGV % 2 == 1)
    {
        print STDERR "\nUSAGE\n"
          . "perl OutcollectCiber.pl MpsLib <path>\n"
          . "                        market <market>\n"
          . "                        threshold <hours>\n"
          . "                        phys_dir <dir>\n";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::OutcollectCiber;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log       =
  Logger->new(log_dir  => $args{Log},
              log_name => "OutcollectCiber_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate OutcollectCiber object and run_check()
my $outcol_ciber = Monitor::OutcollectCiber->new(%args);

=head3 run_check() call
   
   Placing the call to the run_check() method inside an eval block will 
   catch exceptions if anything goes horribly wrong.

=cut

eval {
    my $result = $outcol_ciber->run_check();
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("OutcollectCiber: Nothing Found!\n");
        print STDOUT "Nothing Found!\n";
    }
};

=head3 Exception handler

    Catch exceptions, then die with a more personalized message and 
    a system call stack output.

=cut

if ($@)
{
    $log->print_to_log("Error in OutcollectCiber run_check method.");
    croak "Error in OutcollectCiber run_check method.";
}

$log->close_log();

exit 0;
