#!/opt/perl5/bin/perl

=head1   CheckTemplate.pl

Z<>

=head2 AUTHOR

  Pete Chudykowski

=head2 SYNOPSIS

   perl CheckTemplate.pl argKey <argValue> argKey <argValue>
                         [argKey <argValue>] [argKey <argValue>]
     
=head2 DESCRIPTION

  Provide a template and a framework for developing calling scripts 
  for new Checks of the MPS System Monitor.

=cut

use strict;
use warnings;

# Add the root monitor path to @INC.
BEGIN
{
    if (@ARGV % 2 == 1)
    {
        print STDERR "\nHELP\n"
          . "At the command line, please type:\n"
          . "perldoc RaterStatus.pl <ENTER>\n"
          . "for usage and other details.\n\n";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::CheckTemplate;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d%H%M%S");
my $log       =
  Logger->new(log_dir  => $args{MpsLib} . $args{Log},
              log_name => "RaterStatus_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate appropriate check object and run_check()
my $check_template = Monitor::CheckTemplate->new(%args);  

eval{  
    my $result         = $check_template->run_check();

    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result, "\n";
    } else
    {
        $log->print_to_log("Nothing found.\n");
        carp "Nothing found.\n";
    }
};

# exception handler
if($@)
{
    $log->print_to_log("Error in run_check method.");
    carp "Error in run_check method.";
}