#!/opt/perl5/bin/perl

=head2 Logger Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl Logger

=head3 DESCRIPTION

  Tests basic functionality of the Logger class.

=cut

use strict;
use warnings;

BEGIN
{
  push @INC, '.';
}

use Carp;
use Logger;
use Test::More 'no_plan';


=head2 test get_timestamp()

Tests basic functionality of the B<get_timestamp()> method.

The test attempts to retrieve the timestamp in two different formats 
and checks if a defined value is returned.

=cut

my $timestamp = Logger::get_timestamp("%Y%m%d");
ok($timestamp, "\$timestamp is defined: $timestamp.");
my $timestamp2 = Logger::get_timestamp("%Y\%m\%d %H:%M:%S");
ok($timestamp2, "\$timestamp2 is defined: $timestamp2.");


=head2 test new() - object initialization.

Verifies that the constructor B<new()> initializes an object of type Logger.

=cut

my $logger = Logger->new(log_dir=>"log/",
                         log_name=>"Test_$timestamp.log",
                         timestamp=>$timestamp);
ok($logger->isa("Logger"), "\$logger is of type Logger.");


=head2 test new() - log file creation.

Verifies that a correctly named log file is created.

=cut

ok(-e "log/Test_$timestamp.log", "Log file exists.");


=head2 test print_to_log()

Verifies that messages are written correctly and with the timestamp.

=cut

my $msg = "Test One\nTwo\nThree.\n";
$logger->print_to_log($msg);
$logger->close_log();
my $log_msg;
open(LOG, $logger->get_log_file()) or carp "Can't open log file for reading.";
while(<LOG>)
{
  $log_msg .= (split(/ : /,$_))[1]; 
#  print $_;
}
close(LOG);
is($log_msg,$msg,"Log with a timestamp is populated correctly.");


=head2 test destroy_log()

Verify that the log file is permanently removed.

=cut

$logger->destroy_log();
ok(!(-e "log/Test_$timestamp.log"), "Log file deleted.");


=head2 test print_to_log() without timestamp

Verifies that messages are logged correctly without the timestamp.

=cut


my $logger2 = Logger->new(log_dir=>"log/",
                         log_name=>"Test_$timestamp.log");
my $msg2 = "Test One\nTwo\nThree.\n";
$logger2->print_to_log($msg2);
$logger2->close_log();
my $log_msg2;
open(LOG, $logger2->get_log_file()) or carp "Can't open log file for reading.";
while(<LOG>)
{
  $log_msg2 .= (split(/ : /,$_))[1]; 
#  print $_;  # Debug
}
close(LOG);
is($log_msg2,$msg2,"Log with no timestamp is populated correctly.");

$logger2->destroy_log();