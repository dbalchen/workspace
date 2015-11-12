#!/opt/perl5/bin/perl

=head2   MissingBlock.pl

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  perl MissingBlock.pl MpsLib <path> SqlLib <path> Log <path>
                       from_hrs_ago <hours> to_hrs_ago <hours>
                       market <market> threshold <number>
                       switch_query <file> sql_query <file> 
                       title <title>
                       [op_job <job>] [op_sid <db instance>]
                       [op_user <username>] [op_pass <password>] 

=head3 DESCRIPTION

  MissingBlock executable.
  Accepts command line argument list of MissingBlock properties.
  Formats the arguments into a hash.
  Initiates a MissingBlock object passing the argument hash to it.
  Calls the run_check method.
  If defined, prints the return string from run_check to STDOUT.
  Otherwise prints 'Nothing Found.'

=head3 INPUT PARAMETERS

  The input parameters compose of a list of 'key-value' pairs.  The
  order, in which the pairs appear on the command line is arbitrary.  

=head3 REQUIRED PARAMETER PAIRS

  MpsLib    - Specifies absolute path to the root Monitor directory.
              This is the directory where Monitor.pm is located.
           
  SqlLib    - Specifies path to the SQL directory.
  
  Log       - Location of the log directory.
  
  threshold - Don't report if less than this number of blocks is missing.
  
  sql_query - File under SqlLib that contains the MissingBlock SQL query.
  
  switch_query - File under SqlLib that contains the query for distinct
                 switches active in current market.
            
  market    - Market on which the check is run.  Format: "MXX"  where
              XX is the two-digit market number.
  
  from_hrs_ago - Integer that directs how many hours back to query the 
                 database.
  
  to_hrs_ago   - Integer that directs how many hours prior to current time
                 should be left out of the query.        
              
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
 
 [op_pass <password>] - Specifies the password for the operational
                        database used for secure retrieval of the 
                        application schema connection string.

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
          . "perl MissingBlock.pl MpsLib <path>\n"
          . "                     SqlLib <path>\n"
          . "                     Log <path>\n"
          . "                     threshold <int hours>\n"
          . "                     market <market>\n"
          . "                     sql_query <file>\n"
          . "                     switch_query <file>\n"
          . "                     from_hours_ago <hours>\n"
          . "                     to_hours_ago <hours>\n"
          . "                     [op_job <job>]\n"
          . "                     [op_sid <db instance>]\n"
          . "                     [op_user <username>]\n"
          . "                     [op_pass <password>]\n\n";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::MissingBlock;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log       =
  Logger->new(log_dir  => $args{Log},
              log_name => "MissingBlock_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate MissingBlock object and run_check()
my $missing_block = Monitor::MissingBlock->new(%args);

eval {
    my $result = $missing_block->run_check();
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("Nothing Found.\n");
        print STDOUT "Nothing Found.\n";
    }
};

=head3 Exception handler

    Catch exceptions, then die with a more personalized message and 
    a system call stack output.

=cut

if ($@)
{
    $log->print_to_log("Error in MissingBlock run_check method.");
    carp "Error in MissingBlock run_check method.";
}

$log->close_log();
