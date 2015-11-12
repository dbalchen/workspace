#!/opt/perl5/bin/perl

=head2   RaterStatus.pl

=head3 AUTHOR

  Pete Chudykowski

=head3 SYNOPSIS

  perl RaterStatus.pl MpsLib <path> night_start <hour> night_end <hour> 
                      SqlLib <path> sql_night <file> sql_day <file>
                      market <market> Log <path>
                      [op_job <job>] [op_sid <db instance>]
                      [op_user <username>] [op_pass <password>] 

=head3 DESCRIPTION

  RaterStatus executable.
  Accepts command line argument list of RaterStatus properties.
  Formats the arguments into a hash.
  Initiates a RaterStatus object passing the argument hash to it.
  Calls the run_check method.
  If defined, prints the return string from run_check to STDOUT.

=head3 INPUT PARAMETERS

  The input parameters compose of a list of 'key-value' pairs.  The
  order, in which the pairs appear on the command line is arbitrary.  

=head3 REQUIRED PARAMETER PAIRS

  MpsLib - Specifies absolute path to the root Monitor directory.
           This is the directory where Monitor.pm is located.
           
  night_start - The RaterStatus check behaves differently depending
                on whether it is executed during daytime or during
                nighttime.  This parameter specifies the hour in GMT
                that is considered the beginning of nighttime.
                
  night_end - The RaterStatus check behaves differently depending
              on whether it is executed during daytime or during
              nighttime.  This parameter specifies the hour in GMT
              that is considered the end of nighttime.

  SqlLib - Specifies path to the SQL directory relative to MpsLib.
  
  sql_night - Name of the file in SqlLib containing the query 
              used by a nighttime check.
  
  sql_day - Name of the file in SqlLib containing the query used
            by a daytime check.
            
  market - Market on which the check is run.  Format: "MXX"  where
           XX is the two-digit market number.
        
  Log       - Location of the log directory.


=head3 OPTIONAL PARAMETER PAIRS

 [op_job] - Sspecifies the job name that is the key to the operational
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
          . "perl RaterStatus.pl MpsLib <path>\n"
          . "                    night_start <hour>\n"
          . "                    night_end <hour>\n"
          . "                    SqlLib <path>\n"
          . "                    sql_night <file>\n"
          . "                    sql_day <file>\n"
          . "                    market <market>\n"
          . "                    [op_job <job>]\n"
          . "                    [op_sid <db instance>]\n"
          . "                    [op_user <username>]\n"
          . "                    [op_pass <password>]\n\n";
        exit -1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::RaterStatus;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log       =
  Logger->new(log_dir  => $args{Log},
              log_name => "RaterStatus_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";

# instantiate RaterStatus object and run_check()
my $rater_status = Monitor::RaterStatus->new(%args);

eval {
    my $result = $rater_status->run_check($log);
    if (defined $result)
    {
        $log->print_to_log($result);
        print STDOUT $result;
    } else
    {
        $log->print_to_log("RaterStatus: Nothing Found!\n");
        print STDOUT "Nothing Found!\n";
    }
};

=head3 Exception handler

    Catch exceptions, then die with a more personalized message and 
    a system call stack output.

=cut

if ($@)
{
    $log->print_to_log("Error in RaterStatus run_check method.");
    carp "Error in RaterStatus run_check method.";
}

$log->close_log();
