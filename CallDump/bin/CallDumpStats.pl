#! /usr/bin/perl

use DBI;
use POSIX;
use Time::Local;
use lib "../MIME2";
use MIME::Lite;

$email = $ARGV[0]; chomp($email);

if ($email eq "")
{
 print "Please enter in your email address\n";
 $email = <STDIN>; chomp($email);
}

format REPORT =

CallDump Monthly Statistics from ^|||||||||||||||||| to ^||||||||||||||||||
$fromdate, $todate
==================================================================================================================================================|

 Report     | Report     | Total     | Total      | Max       | Min       | Avg       | Avg       | Max       | Min       | Files     | Avg       |
 Start      | End        | CallDumps | Files      | Files     | Files     | Files     | Time      | Time      | Time      | per Hour  | Timespan  |

 @<<<<<<<<  | @<<<<<<<<  | @<<<<<<<< | @<<<<<<<<< | @<<<<<<<< | @<<<<<<<< | @<<<<<<<< | @<<<<<<<< | @<<<<<<<< | @<<<<<<<< | @<<<<<<<< | @<<<<<<<< |
$fromDate, $lessDate, $ct, $tsum, $max_files, $min_files, $avg, $avg_time, $max_time, $min_time, $files_per_hour,$avgdays 
.



@months = qw(JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC);

@theTime = localtime(time());


$lessDate = padBefore($theTime[3],2)."-".$months[$theTime[4]]."-".padBefore($theTime[5]-100,2);

$todate = strftime( "%B %d, %Y", @theTime);

if ($theTime[4] == 0) {

  $theTime[4] = 11;
  $theTime[5] -= 1;
} else {
  $theTime[4] -= 1;
}

@theTime = localtime(timelocal(@theTime));
$fromdate = strftime( "%B %d, %Y", @theTime);
$fromDate = padBefore($theTime[3],2)."-".$months[$theTime[4]]."-".padBefore($theTime[5]-100,2);

$db="SHAREPRD";
$host="shareprd";
$userid="calldump";
$passwd="calldump";
$connectionInfo="dbi:Oracle:$db";

# make connection to database
$dbh = DBI->connect($connectionInfo,$userid,$passwd);

$dbh->{AutoCommit}    = 0;

$dbh->{RaiseError}    = 1;

$dbh->{ora_check_sql} = 0;

$dbh->{RowCacheSize}  = 16;

$query = "SELECT COUNT(*), SUM(FILES_SEARCHED), MAX(FILES_SEARCHED), MIN(Files_Searched), AVG(FILES_SEARCHED) FROM call_dump_queue WHERE status = 'CO' AND FILES_SEARCHED > 0 AND Submit_DATE >= '".$fromDate."' AND Submit_DATE < '".$lessDate."'";

$sth = $dbh->prepare($query);
$sth->execute();
$sth->bind_columns(\$ct, \$tsum, \$max_files, \$min_files, \$avg);


while ($sth->fetch()) {

#  $output =~ s/TDUMPS/$ct/g;

#  $output =~ s/TFILS/$tsum/g;

#  $output =~ s/MAXFILES/$max_files/g;

#  $output =~ s/MINFILES/$min_files/g;
  $avg = ceil($avg);
#  $output =~ s/AVGFILES/$avg/g;
}


$query = "SELECT FLOOR((AVG((JOB_END - JOB_START ))*24*60*60)/3600) || ':' || FLOOR(((AVG((JOB_END - JOB_START))*24*60*60) - FLOOR((AVG((JOB_END - JOB_START))*24*60*60)/3600)*3600)/60) || ':' || ROUND(((AVG((JOB_END - JOB_START))*24*60*60) - FLOOR((AVG((JOB_END - JOB_START))*24*60*60)/3600)*3600 - (FLOOR(((AVG((JOB_END - JOB_START))*24*60*60) - FLOOR((AVG((JOB_END - JOB_START))*24*60*60)/3600)*3600)/60)*60) ))  time_difference FROM call_dump_queue WHERE status = 'CO' AND FILES_SEARCHED > 0  AND Submit_DATE >= '".$fromDate."' AND Submit_DATE < '".$lessDate."' ORDER BY time_difference DESC";

$sth = $dbh->prepare($query);
$sth->execute();
$sth->bind_columns(\$avg_time);

while ($sth->fetch()) {

  $output =~ s/AVETM/$avg_time/g;
}


$query = "SELECT FLOOR((MAX((JOB_END - JOB_START ))*24*60*60)/3600) || ':' || FLOOR(((MAX((JOB_END - JOB_START))*24*60*60) - FLOOR((MAX((JOB_END - JOB_START))*24*60*60)/3600)*3600)/60) || ':' || ROUND(((MAX((JOB_END - JOB_START))*24*60*60) - FLOOR((MAX((JOB_END - JOB_START))*24*60*60)/3600)*3600 - (FLOOR(((MAX((JOB_END - JOB_START))*24*60*60) - FLOOR((MAX((JOB_END - JOB_START))*24*60*60)/3600)*3600)/60)*60) )) time_difference FROM call_dump_queue WHERE status = 'CO' AND FILES_SEARCHED > 0 AND Submit_DATE >= '".$fromDate."' AND Submit_DATE < '".$lessDate."' ORDER BY time_difference DESC";

$sth = $dbh->prepare($query);
$sth->execute();
$sth->bind_columns(\$max_time);

while ($sth->fetch()) {

#  $output =~ s/MAXT/$max_time/g;
}


$query = "SELECT FLOOR((MIN((JOB_END - JOB_START ))*24*60*60)/3600) || ':' || FLOOR(((MIN((JOB_END - JOB_START))*24*60*60) - FLOOR((MIN((JOB_END - JOB_START))*24*60*60)/3600)*3600)/60) || ':' || ROUND(((MIN((JOB_END - JOB_START))*24*60*60) - FLOOR((MIN((JOB_END - JOB_START))*24*60*60)/3600)*3600 - (FLOOR(((MIN((JOB_END - JOB_START))*24*60*60) - FLOOR((MIN((JOB_END - JOB_START))*24*60*60)/3600)*3600)/60)*60) )) time_difference FROM call_dump_queue WHERE status = 'CO' AND FILES_SEARCHED > 0 AND Submit_DATE >= '".$fromDate."' AND Submit_DATE < '".$lessDate."' ORDER BY time_difference DESC";

$sth = $dbh->prepare($query);
$sth->execute();
$sth->bind_columns(\$min_time);

while ($sth->fetch()) {

#  $output =~ s/MINT/$min_time/g;
}

$query = "SELECT sum(((JOB_END - JOB_START )*24*60*60)/3600)  FROM call_dump_queue WHERE status = 'CO' AND FILES_SEARCHED > 0 AND Submit_DATE >= '".$fromDate."' AND Submit_DATE < '".$lessDate."'";

$sth = $dbh->prepare($query);
$sth->execute();
$sth->bind_columns(\$SysHours);

while ($sth->fetch()) {
  $files_per_hour = ceil($tsum/$SysHours);
#  $output =~ s/FPH/$files_per_hour/g;
}


$query = "SELECT avg(END_DATE - START_DATE)  FROM call_dump_queue WHERE status = 'CO' AND FILES_SEARCHED > 0 AND Submit_DATE >= '".$fromDate."' AND Submit_DATE < '".$lessDate."'";

$sth = $dbh->prepare($query);
$sth->execute();
$sth->bind_columns(\$avgdays);

while ($sth->fetch()) {
  $avgdays = ceil($avgdays);
# print "days_per_query = $days_per_query\n";
}

chdir("../log");
my $dateStamp = strftime("%m%d%Y%H%M%S",localtime);
my $report = "Monthly_CallDump_Statistics".$dateStamp.".txt";

open( REPORT, "> $report" )
  || errorExit("Could not open Report file.... CallDump Statistcs job Failed!!!!");


select(REPORT);

$~ = REPORT;
write;

close(REPORT);

print STDOUT "Nothing Found\n";

emailReport($report,$email);

exit(0);

sub padBefore {

  my ($stringToPad, $pad_size ) = @_;

  while (length($stringToPad) < $pad_size) {
    $stringToPad = "0".$stringToPad;
  }

  return $stringToPad;

}

sub emailReport{
  my($Report,$email) = @_;

  # Email basics.
  my $shortX = (split(/\//,$logFile))[-1];
  my $subject = "$shortX";
  my $mime_type = 'multipart/mixed';
  my $message = "Attached is the CallDump Statistics for the last Month..\n";
  my $subject   = "CallDump Statistics";
  # Initialize the email object.
  my $mime_msg = MIME::Lite->new(To=>$email,
                                 Subject=>$subject,
                                 Type=>$mime_type) or die "Error creating " . 
                                                          "MIME body: $!\n";
  # Add a text message to the email body.
  $mime_msg->attach(Type=>'TEXT',
                    Data=>$message) or die "Error adding text message: $!\n";

  # Attach the test file.
  $mime_msg->attach(Type=>'application/octet-stream',
                    Encoding=>'base64',
                    Path=>$Report,
                    Filename=>$Report) or die "Error attaching file: $!\n";

  # Send the email.
  $mime_msg->send();
}
