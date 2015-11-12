#!/opt/perl5/bin/perl

=head2  IntraMarketTransfer.pl

=head3 AUTHOR

  Amy Schnelle

=head3 SYNOPSIS

  perl IntraMarketTransfer.pl MpsLib <path> SqlLib <path> market <M0X>
                        from_hrs_ago <hours> to_hrs_ago <hours> 
                        local_query <file> remote_query <file> Log <path>
                        [op_job <job>] [op_sid <db instance>]
                        [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  IntraMarketTransfer executable.
  Accepts command line argument list of IntraMarketTransfer properties.
  Formats the arguments into a hash.
  Initiates a MansTransfer object passing the argument hash to it.
  Calls the run_check method.
  If defined, prints the return string from run_check to STDOUT.

=head3 INPUT PARAMETERS

  The input parameters compose of a list of 'key-value' pairs.  The
  order, in which the pairs appear on the command line is arbitrary.  

=head3 REQUIRED PARAMETER PAIRS

  MpsLib    - Specifies absolute path to the root Monitor directory.
              This is the directory where Monitor.pm is located.

  SqlLib    - Specifies path to the SQL directory relative.

  market    - Market on which the check is run.  Format: "MXX"  where
              XX is the two-digit market number.

  remote_market  - The market where a file is transfered to. Format: "MXX"  where
              XX is the two-digit market number.
  
local_query - File which holds the SQL query used on the local machine.

  remote_query - File which holds the SQL query used on the remote machine.

  Log       - Location of the log directory.


=head3 OPTIONAL PARAMETER PAIRS

 [op_job] - Specifies the job name that is the key to the operational
            tables query used for secure retrieval of the application 
            schema connection string.  E.g. "MPSBOOT";  
            Required when the environment variable $OP_JOB_NAME is 
            undefined or set to an incorrect value. 

 [op_sid] - Specifies the database schema name of the operational
            database used for secure retrieval of the application
            schema connection string.

 [op_user] - Specifies the user name of the operational
             database used for secure retrieval of the application
             schema connection string.

 [op_pass] - Specifies the password for the operational database used 
             for secure retrieval of the application schema connection
             string.  

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
         . "perl IntraMarketTransfer.pl MpsLib <path>\n"
         . "                      SqlLib <path>\n"
         . "                      market <market>\n"
         . "                      remote_market <market>\n"
         . "                      from_hrs_ago <hours>\n"
         . "                      to_hrs_ago <hours>\n"
         . "                      local_query <file>\n"
         . "                      remote_query <file>\n"
         . "                      host <host/ip>\n"
         . "                      usr <user>\n"
         . "                      passwd <password>\n\n";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::IntraMarketTransfer;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log = Logger->new(log_dir  => $args{Log},
                      log_name => "IntraMarketTransfer_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

eval
{
# instantiate MansTransfer object and run_check()
    my $intraMarket_tr = Monitor::IntraMarketTransfer->new(%args) or croak "Error instantiating object.";
    my $result = $intraMarket_tr->run_check();        
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("IntraMarketTransfer: Nothing Found!\n");
        print STDOUT "Nothing Found!\n";
    }
};

=head3 Exception handler

    Catch exceptions, then die with a more personalized message and 
    a system call stack output.

=cut

if($@)
{
    $log->print_to_log("Error in IntraMarketTransfer run_check method.");
    croak "Error in IntraMarketTransfer run_check method.";
}

$log->close_log();
