#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Revision      : PR270997
# Description   : Modified for TOPS 
# Author        : David A Smith
# Date          : Fri Aug  3 09:29:41 CDT 2012
#-------------------------------------------------------------------------------

=head2   TP_Summary.pl

=head3 AUTHOR

  Glenn Lockwood 4/7/2010

=head3 SYNOPSIS

  perl TP_Summary.pl  Log <relative path>
                      market <market>
                      sum_dbuser <orauser>  (on calldump server)
                      sum_dbpass <password>
                      sum_dbsid  <system id>
                      seconds  <time in seconds from now to look back>
                      title <string>
                      market <M0X>
                      sql_query <file>
                      SqlLib <relative path>

 

=head3 DESCRIPTION

  TP_Summary.pl queries ac_processing accounting to get number of records processed
  and the number of seconds it took over the interval from <seconds> until now 
  for the voice and sms call processing daemons. It collaborates with its perl module
  to accomplish the storage of summarized throughput data from each market into a central
  repository. The .pl is the entry point for this "audit" it collects the arguments and
  dispatches its perl module (.pm) which does the heavy listing. It sends diagnostics
  to standard output when there are problems, but otherwise prints "Nothing Found".
  The diagnostic messages will be sent to oncall by convention. 

=head3 INPUT PARAMETERS

  The input parameters compose of a list of 'key-value' pairs.  The
  order, in which the pairs appear on the command line is arbitrary.
  The parameter names will appear separated by spaces, and the values are
  enclosed in quotes. An even number of parameters are expected.

=head3 REQUIRED PARAMETER PAIRS

  
  Log       - Location of the log directory.
  
           
  market    - Market on which the check is run.  Format: "MXX"  where
              XX is the two-digit market number.
              
  title     -  subject in email/page.


 sum_dbuser - schema owner on calldump server)
       
 sum_dbpass - calldump password 
 
 sum_dbsid  - calldump oracle sid

  seconds   - time in seconds from now to look back

sql_query   - file holding the query text

SqlLib      - relative path to sql query text

=cut

use strict;
use warnings;

# Add the root Monitor path to @INC.
BEGIN
{
    for ($a = 0; $a < @ARGV; $a++) {
	$ARGV[$a] =~ s/^"//g; $ARGV[$a] =~ s/"$//g;
    }
    print "@ARGV\n";
    if (@ARGV < 18 )
    {
        print STDERR "\nUSAGE\n"
          . "perl TP_Summary.pl <arguments> as name-value pairs with values in quotes\n" ;
        print STDERR "e.g. seconds_span \"3600\" sum_dbpass \"calldumptest\" sum_dbsid \"sharedev\" ".
                     "sum_dbuser \"calldumptest\" title \"TP_Summary\" market \"M01\" ".
                     "sql_query \"throughput.sql\" SqlLib \"sql/\" Log \"log/\" \n";
        print STDERR "these should appear in xml file as a params tag with name and value separated by =\n";
        print STDERR "and if not run such that perl modules are in expected places supply it in MpsLib\n"; 
        exit 1;
    }
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Carp;
use Monitor::TP_Summary;
use Logger;

# Flush output after every line.
$| = 1;

# Convert input arguments into a hash
my %args = @ARGV;

# Create Log file.
my $timestamp = Logger::get_timestamp("%Y%m%d");
my $log       =
  Logger->new(log_dir  => $args{Log},
              log_name => "TP_Summary_$timestamp.log");
$log->print_to_log($args{title}) or carp "Could not write to log.";
# pass the open log to Monitor subclass perl module
$args{LoggerRef}=$log;

# instantiate TP_Summary object and run_check()
my $sumobj = Monitor::TP_Summary->new(%args);

eval {
    my $result = $sumobj->run_check();
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
    $log->print_to_log("Error in TP_Summary run_check method."."($@)");
    carp "Error in TP_Summary run_check method."."($@)";
}

$log->close_log();
