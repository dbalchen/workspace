#!/opt/perl5/bin/perl

=head2 InfEventLoad.pl

=head3 AUTHOR

  Jacob Ray

=head3 SYNOPSIS

  perl InfEventLoad.pl MpsLib <path> market <M0X> Log <path>

=head3 DESCRIPTION

  InfEventLoad executable.
  Accepts command line argument list of InfEventLoad properties.
  Formats the arguments into a hash.
  Initiates a InfEventLoad object passing the argument hash to it.
  Calls the run_check method.
  If defined, prints the return string from run_check to STDOUT.

=head3 INPUT PARAMETERS

  The input parameters compose of a list of 'key-value' pairs.  The
  order, in which the pairs appear on the command line is arbitrary.  

=head3 REQUIRED PARAMETER PAIRS

  MpsLib    - Specifies absolute path to the root Monitor directory.
              This is the directory where Monitor.pm is located.

  market    - Market on which the check is run.  Format: "MXX"  where
              XX is the two-digit market number.

  Log       - Location of the log directory.

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
         . "perl InfEventLoad.pl MpsLib <path>\n"
         . "                     market <market>\n"
         . "                     Log    <file name>\n";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::InfEventLoad;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log = Logger->new(log_dir  => $args{Log},
                      log_name => "InfEventLoad_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate InfEventLoad object and run_check()
my $inf_event_load = Monitor::InfEventLoad->new(%args);

=head3 run_check() call
   Placing the call to the run_check() method inside an eval block will 
   catch exceptions if anything goes horribly wrong.
=cut

eval
{
    my $result = $inf_event_load->run_check();
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("Infranet Event Load Status: Running!\n");
        print STDOUT "Nothing Found\n";
    }
};

=head3 Exception handler
    Catch exceptions, then die with a more personalized message and
    a system call stack output.
=cut

if($@)
{
    $log->print_to_log("Error in InfEventLoad run_check method.");
    croak "Error in InfEventLoad run_check method.";
}

$log->close_log();

exit 0;
