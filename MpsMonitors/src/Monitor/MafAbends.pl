#!/opt/perl5/bin/perl

=head2 MafAbends.pl

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl MafAbends.pl MpsLib <path> 
                    SqlLib <path> 
                    Log <path>
                    sql_query <file>
                    alarm_threshold <int>  
                    market <M0X>  
                    title <string>
                    [op_job <job>] 
                    [op_sid <db instance>]
                    [op_user <username>] 
                    [op_pass <password>]


=head3 DESCRIPTION

MafAbends executable.
Accepts command line argument list of MafAbend properties.
Formats the arguments into a hash.
Initiates a MafAbends object passing the argument hash to it.
Calls the run_check method.
If defined, prints the return string from run_check to STDOUT.
Otherwise prints the string "Nothing Found!\n" to STDOUT.


=head3 INPUT PARAMETERS

The input parameters compose of a list of 'key-value' pairs.  The
order, in which the pairs appear on the command line is arbitrary.
  

=head3 REQUIRED PARAMETER PAIRS


 MpsLib    - Specifies absolute path to the root Monitor directory.
             This is the directory where Monitor.pm is located.
 
 SqlLib    - Specifies path to the SQL directory relative.
 
 Log       - Location of the log directory.
 
 sql_query - Name of the file in SqlLib to be used for this check.
 
 alarm_threshold - integer value number of abended files in Collections
                   and Main Driver considered an alarm condition.
            
 market    - Market on which the check is run.  Format: "MXX"  where
             XX is the two-digit market number.
           
 title - page title or subject.


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
    }

    if (@ARGV % 2 == 1)
    {
        print STDERR "\nUSAGE\n"
          . "perl StuckFile.pl MpsLib          <path>\n"
          . "                  SqlLib          <path>\n"
          . "                  Log             <path>\n"
          . "                  sql_query       <file>\n"
          . "                  alarm_threshold <int>\n"
          . "                  market          <market>\n"
          . "                  title           <string>\n"
          . "                  [op_job]        <job>\n"
          . "                  [op_sid]        <schema>\n"
          . "                  [op_user]       <user>\n"
          . "                  [op_pass]       <password>\n\n";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::MafAbends;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log       =
  Logger->new(log_dir  => $args{Log},
              log_name => "MafAbends_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate MafAbends object and run_check()
my $maf_abends = Monitor::MafAbends->new(%args);

eval {
    my $result = $maf_abends->run_check();
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("MafAbends: Nothing Found!\n");
        print STDOUT "Nothing Found!\n";
    }
};

=head3 Exception handler

Catch exceptions, then die with a more personalized message and 
a system call stack output.

=cut

if ($@)
{
    $log->print_to_log("Error in StuckFile run_check method.");
    carp "Error in StuckFile run_check method.\n $@";
}

$log->close_log();