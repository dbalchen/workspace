#!/usr/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : Steven M Roehl
# Date          : Wed Jan 15 1:30:00 CDT 2014
#-------------------------------------------------------------------------------

=head2   AEMErrorCount.pl

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  perl AEMErrorCount.pl MpsLib <path> SqlLib <path> threshold <hours>  
                    market <M0X> sql_query <file> Log <path>
                    title <title>
                    [op_job <job>] [op_sid <db instance>]
                    [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  AEMErrorCount executable.
  Accepts command line argument list of AEMErrorCount properties.
  Formats the arguments into a hash.
  Initiates a AEMErrorCount object passing the argument hash to it.
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
           
  threshold - integer value number of hours before a file is 
              considered stuck.
  
  sql_query - Name of the file in SqlLib to be used for this check.
  
  Log       - Location of the log directory.
 
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
          . "perl AEMErrorCount.pl MpsLib <path>\n"
          . "                   SqlLib <path>\n"
          . "                   market <market>\n"
          . "                   host <host/ip>\n"
          . "                   usr <user>\n"
          . "                   passwd <password>\n\n";
        print @ARGV;
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::AEMErrorCount;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log       =
  Logger->new(log_dir  => $args{Log},
              log_name => "AEMErrorCount_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate AEMErrorCount object and run_check()
my $errors= Monitor::AEMErrorCount->new(%args);

eval {
    my $result = $errors->run_check();
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("AEMErrorCount: Nothing Found!\n");
        print STDOUT "Nothing Found!\n";
    }
};

=head3 Exception handler

    Catch exceptions, then die with a more personalized message and 
    a system call stack output.

=cut

if ($@)
{
    $log->print_to_log("Error in AEMErrorCount run_check method.");
    carp "Error in AEMErrorCount get countmethod.\n $@";
}

$log->close_log();
