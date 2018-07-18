#!/usr/local/bin/perl

=head2 SwitchBehind Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl SwitchBehind.t MpsLib <path> SqlLib <path> threshold <int hours>  
                      market <M0X> sql_query <file>
                      [op_job <job>] [op_sid <db instance>]
                      [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  Tests basic functionality of the SwitchBehind class.

=head3 INPUT PARAMETERS

  The input parameters comprise of the following pairs:
  Key:          Value:    Description:
  MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
  SqlLib        <path>    Attribute of monitor.xml <M0X> tab.
  threshold     <hours>   Attribute of monitor.xml <params> tab.
  sql_query     <file>    Name of the file in SqlLib to be used 
                          for this check.
  market        <M0X>     Attribute of monitor.xml <params> tab.

=cut

use strict;
use warnings;

BEGIN
{
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Test::More 'no_plan';    # you can replace the 'no_plan' with (tests=>n)
                             # where n is the number of tests in the suite.
use USCDB;
use Carp;
use Data::Dumper;

$| = 1;

my %args = @ARGV;

=head3 TESTS 

=head3 Test Monitor

  Verifies that the Monitor module is visible and accessible.

=cut

use_ok('Monitor');

=head3 Test Monitor::SwitchBehind

  Verifies that the RaterStatus module is visible and accessible.

=cut

use_ok('Monitor::SwitchBehind');

=head3 Test Inheritance

  Verifies that SwitchBehind is a sub class of Monitor.

=cut

my $switch_behind = Monitor::SwitchBehind->new(%args);

ok($switch_behind->isa('Monitor::SwitchBehind'),
    "Object is of type Monitor::SwitchBehind");

=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($switch_behind->get_market()),
    'M01', "Object is set up for the correct market");

=head3 Test get_threshold

  Test accessor method get_threshold().

=cut    

is($switch_behind->get_threshold(),
    $args{threshold}, "Instance variable 'threshold' is set correctly.");

=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($switch_behind->get_MpsLib(), $args{MpsLib}, "MpsLib is set correctly");

=head3 Test get_SqlLib()

  Test accessor method get_SqlLib().

=cut

is($switch_behind->get_SqlLib(), $args{SqlLib}, "SqlLib is set correctly");

=head3 Test get_sql_query

    Test that the get_switch_behind_query() method
    returns a populated string.

=cut

my $query = $switch_behind->get_sql_query($args{SqlLib} . $args{sql_query});
ok($query, "get_sql_query() returns a defined value");

=head3 Test get_time_zone

    Check if time_zone gets returned.

=cut

$ENV{TZ} = "CST6CDT" unless defined $ENV{TZ};
my $tz = $switch_behind->get_time_zone();
ok($tz, "get_time_zone() returns a defined value");

=head3 Test get_db()

    Check if get_db() returns a defined database object.

=cut

my $dbh = $switch_behind->get_db();
ok($dbh->isa('USCDB'), "get_db() returnes an initialized USCDB object.");

=head3 Test get_data()

    Check if get_data returns a populated hash

=cut

my $uscdb      = set_up_db();
my %switchHash = $switch_behind->get_data($query);
ok(%switchHash, "get_data() returns a defined Hash.");
clear_db($uscdb);
$uscdb->closeConnection();

=head3 Test run_check()

  Clear the database.
  Populate the ac_logical files table with data
  that will make the check return a predictable string.
  Verify that the return value of run_check() is the predicted
  string.

=cut

test_run_check();

sub test_run_check
{
    my $uscdb = set_up_db();

    # overwrite the ignore_list parameter
    # to pretend that switch AAA1 is supposed to be ignored today.
    $args{ignore_list} =
        "TWIN:0,POCA:0,AAA,AAA1:"
      . (localtime())[6]
      . ",AAA2,AAA3,PMSG1,PMSG2,PMSG3,PTX1,PTX2,PTX3,AAAS,SMSC";

    # create a new SwitchBehind object using the overwritten arguments.
    my $switch_behind = Monitor::SwitchBehind->new(%args);

    # get the recording end date
    my $fetch_sql = <<FETCH_SQL;
    select fsrc_sensor_id,
           to_char(rcrdng_end_date,'DD-MON-YYYY hh:mi:ss AM')
    from ac_logical_files
    where fsrc_src_type     = 'AMA'
    and   fsrc_type_id      = 'NTI'
    and   fsrc_sensor_id    = 'ASHE'
    and   identifier        = 313764549
    and   fphy_orig_file_id = 313764547
    and   strt_block        = 61325
    and   end_block         = 61618
FETCH_SQL

    my ($switch, $rcrdng_end_date) = $uscdb->selectFetchRow($fetch_sql);

    is($switch_behind->run_check(),
        $switch . ": Last File: " . $rcrdng_end_date . "\n",
        "run_check returns expected value.");

    clear_db($uscdb);
    $uscdb->closeConnection();
}

=head3 Test no error condition  

    Verifies behavior when no switches are behind.

=cut

test_nothing_behind();

sub test_nothing_behind
{
    my $uscdb = dbConnect();
    clear_db($uscdb);
    ok(!$switch_behind->run_check(), "run_check() - Nothing Found to report.");

}

=head3 Connect to Oracle

  Supporting subroutine.
  Connects to local or specified in arguments database.
  Returns an instanciated USCDB object.

=cut

sub dbConnect
{
    my $uscdb       = USCDB->new();
    my @connect_str =
      $uscdb->getDBParmsfromOper($args{op_job},  $args{op_sid},
                                 $args{op_user}, $args{op_pass});

    # Get rid of white space in the parameter values.
    foreach my $conn (@connect_str)
    {
        $conn =~ s/\s+//g;
    }

    my $rc = $uscdb->openConnection(@connect_str);
    unless (defined $rc)
    {
        carp "Could not connect to Oracle!", $uscdb->getErrorStr(), "\n\n";
    }
    return $uscdb;
}

=head3 Set and Run query

  Runs a query.
  Takes:    $uscdb  - USCDB object reference
            $sql    - sql query to run
  Returns:  $status - defined on success
                    - carps   on faliure

=cut

sub execute_query
{
    my ($uscdb, $sql) = @_;

    my $status = $uscdb->setQuery($sql);
    unless (defined $status)
    {
        carp "\nError in setQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }

    $status = $uscdb->runQuery();
    unless (defined $status)
    {
        carp "\nError in runQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }
}

=head3 Set up the database

    Set up the database for testing.
    Return a USCDB handle.

=cut

sub set_up_db
{
    my $uscdb = dbConnect();

    clear_db($uscdb);

    # insert one row that is older than 8 hours.
    my $insert_sql = <<INS_SQL;
insert into ac_logical_files (
 FSRC_SRC_TYPE,
 FSRC_TYPE_ID,
 FSRC_SENSOR_ID,
 SYSTEM_RCV_DATE,
 IDENTIFIER,
 RCRDNG_START_DATE,
 RCRDNG_END_DATE,
 TRLR_RECORD_COUNT,
 STRT_BLOCK,
 END_BLOCK,
 PGM_TRACER_IND,
 FPHY_ORIG_FILE_ID,
 LOG_ENTRY_STATUS ,
 DPHY_OLD_AGE_IND)
 values (
 'AMA',
 'NTI',
 'ASHE',
 sysdate-1,
 313764549,
 sysdate-1,
 sysdate-1,
 2448,
 61325,
 61618,
 'N',
 313764547,
 'OK',
 'N')
INS_SQL

    execute_query($uscdb, $insert_sql);
    $uscdb->commit();

    $insert_sql = <<INS_SQL;
insert into ac_logical_files (
 FSRC_SRC_TYPE,
 FSRC_TYPE_ID,
 FSRC_SENSOR_ID,
 SYSTEM_RCV_DATE,
 IDENTIFIER,
 RCRDNG_START_DATE,
 RCRDNG_END_DATE,
 TRLR_RECORD_COUNT,
 STRT_BLOCK,
 END_BLOCK,
 PGM_TRACER_IND,
 FPHY_ORIG_FILE_ID,
 LOG_ENTRY_STATUS ,
 DPHY_OLD_AGE_IND)
 values (
 'AMA',
 'AAA',
 'AAA1',
 sysdate-1,
 313764560,
 sysdate-1,
 sysdate-1,
 2448,
 61325,
 61618,
 'N',
 313764547,
 'OK',
 'N')
INS_SQL

    execute_query($uscdb, $insert_sql);
    $uscdb->commit();

    return $uscdb;

}

=head3  Clear the database.

    Clear the pertinent tables in the test database.

=cut


sub clear_db
{
    my $uscdb = shift;

    # clear ac_logical_files
    my $delete_sql = "delete from ac_logical_files";
    execute_query($uscdb, $delete_sql);
    $uscdb->commit();
}
