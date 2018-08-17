#!/usr/local/bin/perl

=head2   InfraTransfer.pl

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  perl InfraTransfer.pl MpsLib <path> SqlLib <path> market <M0X>
                        from_hrs_ago <hours> to_hrs_ago <hours> 
                        cares_query <file> infra_query <file> Log <path>
                        [op_job <job>] [op_sid <db instance>]
                        [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  InfraTransfer executable.
  Accepts command line argument list of InfraTransfer properties.
  Formats the arguments into a hash.
  Initiates a InfraTransfer object passing the argument hash to it.
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

  from_hrs_ago - Used by cares.sql and infra.sql.  Defines the number 
                 of hours of data the query should retrieve.

  to_hrs_ago - Used by cares.sql.  Defines the number of hours that 
               should be allowed for a file to transfer and process
               through the Event Loader.

  cares_query - File which holds the SQL query used by the cares check.

  infra_query - File which holds the SQL query used by the infra check.

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
         . "perl InfraTransfer.pl MpsLib <path>\n"
         . "                      SqlLib <path>\n"
         . "                      market <market>\n"
         . "                      from_hrs_ago <hours>\n"
         . "                      to_hrs_ago <hours>\n"
         . "                      cares_query <file>\n"
         . "                      infra_query <file>\n"
         . "                      host <host/ip>\n"
         . "                      usr <user>\n"
         . "                      passwd <password>\n\n";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::InfraTransfer;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log = Logger->new(log_dir  => $args{Log},
                      log_name => "InfraTransfer_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate InfraTransfer object and run_check()
my $infra_tr = Monitor::InfraTransfer->new(%args);

eval
{
    my $result = $infra_tr->run_check();        
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("InfraTransfer: Nothing Found!\n");
        print STDOUT "Nothing Found!\n";
    }
};

=head3 Exception handler

    Catch exceptions, then die with a more personalized message and 
    a system call stack output.

=cut

if($@)
{
    $log->print_to_log("Error in InfraTransfer run_check method.");
    croak "Error in InfraTransfer run_check method.";
}

$log->close_log();
