
=head2 MissingBlock Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl MissingBlock.t MpsLib <path> SqlLib <path> market <M0X> 
                      sql_query <file> from_hrs_ago <hours>
                      to_hrs_ago <hours> 
                      [op_job <job>] [op_sid <db instance>]
                      [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  Tests basic functionality of the MissingBlock class.

=head3 INPUT PARAMETERS

  The input parameters comprise of the following pairs:
  Key:          Value:    Description:
  MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
  SqlLib        <path>    Attribute of monitor.xml <M0X> tab.
  from_hrs_ago  <hours>   Attribute of monitor.xml <params> tab.
  to_hrs_ago    <hours>   Attribute of monitor.xml <params> tab.
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

=head3 Test Monitor::MissingBlock

  Verifies that the RaterStatus module is visible and accessible.

=cut

use_ok('Monitor::MissingBlock');

=head3 Test Inheritance

  Verifies that MissingBlock is a sub class of Monitor.

=cut

my $missing_block = Monitor::MissingBlock->new(%args);

isa_ok($missing_block, 'Monitor::MissingBlock',
       "Object is of type Monitor::MissingBlock");

=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($missing_block->get_market()),
    uc($args{market}), "Object is set up for the correct market");

=head3 Test get_from_hrs_ago

  Test accessor method get_from_hrs_ago().

=cut    

is($missing_block->get_from_hrs_ago(),
    $args{from_hrs_ago}, "Instance variable 'from' is set correctly.");

=head3 Test get_to_hrs_ago

  Test accessor method get_to_hrs_ago().

=cut    

is($missing_block->get_to_hrs_ago(),
    $args{to_hrs_ago}, "Instance variable 'to' is set correctly.");

=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($missing_block->get_MpsLib(), $args{MpsLib}, "MpsLib is set correctly");

=head3 Test get_SqlLib()

  Test accessor method get_SqlLib().

=cut

is($missing_block->get_SqlLib(), $args{SqlLib}, "SqlLib is set correctly");

=head3 Test get_sql_query

    Test that the get_sql_query() method
    returns a populated string.

=cut

my $query = $missing_block->get_sql_query($args{SqlLib} . $args{sql_query});
ok($query, "get_sql_query() returns a valid cares_query value");

=head3 Test run_check_no_problem()

  Clear the database.
  Populate ac_logical_files and ac_physical_files tables 
  with test data.
  Verify that the return value of run_check() is the predicted
  string.

=cut

test_run_check_no_problem();

sub test_run_check_no_problem
{
    my $dbh = set_up_db_for_no_problem();

    my $message = $missing_block->run_check();
    is($message, undef, "run_check() returns undef when no problems.");

    clear_db($dbh);
    $dbh->closeConnection();
}

=head3 Test run_check_50_missing()

  Clear the database.
  Populate ac_logical_files and ac_physical_files tables 
  with test data.
  Verify that the return value of run_check() is the predicted
  string.

=cut

test_run_check_50_missing();

sub test_run_check_50_missing
{
    my $dbh = set_up_db_for_50_missing();

    my $message = $missing_block->run_check();
    is($message, undef,
        "run_check() returns undef when 50 blocks are missing.");

    clear_db($dbh);
    $dbh->closeConnection();
}

=head3 Test run_check_150_missing()

  Clear the database.
  Populate ac_logical_files and ac_physical_files tables 
  with test data.
  Verify that the return value of run_check() is the predicted
  string.

=cut

test_run_check_150_missing();

sub test_run_check_150_missing
{
    my $dbh = set_up_db_for_150_missing();

    my $expected =
      "switch:  ASHE\n" . "missing: 150\n" . "blocks:  60914 -> 61064\n";
    my $message = $missing_block->run_check();
    is($message, $expected,
        "run_check() returns expected message when 150 blocks are missing.");

    clear_db($dbh);
    $dbh->closeConnection();
}

=head3 set_up_db_for_no_problem

    Set up the cares database for testing.

=cut

sub set_up_db_for_no_problem
{

    my $dbh = db_connect();

    clear_db($dbh);

    # insert one row that is older than 8 hours.
    my $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, RCRDNG_END_DATE, 
    STRT_BLOCK, END_BLOCK)
 Values
   (317277163, 'AMA', 'NTI', TRUNC(SYSDATE-3) + 10/24 + 30/(24*60*60), 317277161, 
    'ASHE', TRUNC(SYSDATE-3) + 5/24, TRUNC(SYSDATE-3) + 5/24,
    56221, 58909)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, RCRDNG_END_DATE, 
    STRT_BLOCK, END_BLOCK)
 Values
   (317307034, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 10/24 + 27/(24*60*60), 317307032, 
    'ASHE', TRUNC(SYSDATE-2) + 7/24, TRUNC(SYSDATE-2) + 7/24,
    58910, 60913)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, RCRDNG_END_DATE, 
    STRT_BLOCK, END_BLOCK)
 Values
   (317307037, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 10/24 + 54/(24*60*60), 317307036, 
    'ASHE', TRUNC(SYSDATE-2) + 8/24, TRUNC(SYSDATE-2) + 8/24,
    60914, 1000611)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, RCRDNG_END_DATE, 
    STRT_BLOCK, END_BLOCK)
 Values
   (317317835, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 12/24 + 44/(24*60*60), 317317833, 
    'ASHE', TRUNC(SYSDATE-2) + 10/24, TRUNC(SYSDATE-2) + 10/24,
    612, 5106)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, RCRDNG_END_DATE, 
    STRT_BLOCK, END_BLOCK)
 Values
   (317074688, 'AMA', 'APLX', TRUNC(SYSDATE-3) + 9/24 + 38/(24*60*60), 317074578, 
    'LMAB', TRUNC(SYSDATE-3) + 6/24 + 54/(24*60*60), TRUNC(SYSDATE-3) + 6/24 + 54/(24*60*60), 
    697140, 701076)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, RCRDNG_END_DATE, 
    STRT_BLOCK, END_BLOCK)
 Values
   (317082710, 'AMA', 'APLX', TRUNC(SYSDATE-2) + 11/24 + 55/(24*60*60), 317082705, 
    'LMAB', TRUNC(SYSDATE-2) + 8/24 + 54/(24*60*60), TRUNC(SYSDATE-2) + 8/24 + 54/(24*60*60), 
    701077, 707085)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, RCRDNG_END_DATE, 
    STRT_BLOCK, END_BLOCK)
 Values
   (317093086, 'AMA', 'APLX', TRUNC(SYSDATE-2) + 13/24 + 1/(24*60) + 3/(24*60*60), 317093069, 
    'LMAB', TRUNC(SYSDATE-2) + 10/24 + 54/(24*60*60), TRUNC(SYSDATE-2) + 10/24 + 54/(24*60*60),
     707086, 714829)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    # insert into ac_physical_files
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE,                          SERIAL_NUMBER)
 Values
   (317277161,  'SASHE_FNTI_12_ID003791_T20050215060012.DAT', 
    TRUNC(SYSDATE-3) + 8/24 + 22/(24*60*60), '003791')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317307032, 'SASHE_FNTI_12_ID003792_T20050215080017.DAT', 
    TRUNC(SYSDATE-2) + 10/24 + 14/(24*60*60), '003792')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
   SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317307036, 'SASHE_FNTI_12_ID003793_T20050215083839.DAT', 
    TRUNC(SYSDATE-2) + 10/24 + 41/(24*60*60), '000001')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317317833, 'SASHE_FNTI_12_ID003794_T20050215100343.DAT', 
    TRUNC(SYSDATE-2) + 12/24 + 29/(24*60*60), '000002')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317074578, 'SLMAB_FAPLX_ID006395_T20050214070100.DAT', 
    TRUNC(SYSDATE-3) + 9/24 + 20/(24*60*60), '006395')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317082705, 'SLMAB_FAPLX_ID006396_T20050214090100.DAT', 
    TRUNC(SYSDATE-2) + 11/24 + 47/(24*60*60), '006396')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317093069, 'SLMAB_FAPLX_ID006397_T20050214110101.DAT', 
    TRUNC(SYSDATE-2) + 13/24 + 43/(24*60*60), '006397')

INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    return $dbh;
}

=head3 set_up_db_for_50_missing

    Set up the cares database for testing.

=cut

sub set_up_db_for_50_missing
{

    my $dbh = db_connect();

    clear_db($dbh);

    # insert one row that is older than 8 hours.
    my $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317277163, 'AMA', 'NTI', TRUNC(SYSDATE-3) + 10/24 + 30/(24*60*60), 317277161, 
    'ASHE', TRUNC(SYSDATE-3) + 5/24, 56221, 58909)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317307034, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 10/24 + 27/(24*60*60), 317307032, 
    'ASHE', TRUNC(SYSDATE-2) + 7/24, 58910, 60913)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317307037, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 10/24 + 54/(24*60*60), 317307036, 
    'ASHE', TRUNC(SYSDATE-2) + 8/24, 60964, 1000611)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317317835, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 12/24 + 44/(24*60*60), 317317833, 
    'ASHE', TRUNC(SYSDATE-2) + 10/24, 612, 5106)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317074688, 'AMA', 'APLX', TRUNC(SYSDATE-3) + 9/24 + 38/(24*60*60), 317074578, 
    'LMAB', TRUNC(SYSDATE-3) + 6/24 + 54/(24*60), 697140, 701076)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317082710, 'AMA', 'APLX', TRUNC(SYSDATE-2) + 11/24 + 55/(24*60*60), 317082705, 
    'LMAB', TRUNC(SYSDATE-2) + 8/24 + 54/(24*60), 701077, 707085)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317093086, 'AMA', 'APLX', TRUNC(SYSDATE-2) + 13/24 + 1/(24*60) + 3/(24*60*60), 317093069, 
    'LMAB', TRUNC(SYSDATE-2) + 10/24 + 54/(24*60), 707086, 714829)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    # insert into ac_physical_files
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE,                          SERIAL_NUMBER)
 Values
   (317277161,  'SASHE_FNTI_12_ID003791_T20050215060012.DAT', 
    TRUNC(SYSDATE-3) + 8/24 + 22/(24*60*60), '003791')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317307032, 'SASHE_FNTI_12_ID003792_T20050215080017.DAT', 
    TRUNC(SYSDATE-2) + 10/24 + 14/(24*60*60), '003792')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
   SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317307036, 'SASHE_FNTI_12_ID003793_T20050215083839.DAT', 
    TRUNC(SYSDATE-2) + 10/24 + 41/(24*60*60), '003793')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317317833, 'SASHE_FNTI_12_ID003794_T20050215100343.DAT', 
    TRUNC(SYSDATE-2) + 12/24 + 29/(24*60*60), '003794')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317074578, 'SLMAB_FAPLX_ID006395_T20050214070100.DAT', 
    TRUNC(SYSDATE-3) + 9/24 + 20/(24*60*60), '006395')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317082705, 'SLMAB_FAPLX_ID006396_T20050214090100.DAT', 
    TRUNC(SYSDATE-2) + 11/24 + 47/(24*60*60), '006396')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317093069, 'SLMAB_FAPLX_ID006397_T20050214110101.DAT', 
    TRUNC(SYSDATE-2) + 13/24 + 43/(24*60*60), '006397')

INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    return $dbh;
}

=head3 set_up_db_for_150_missing

    Set up the cares database for testing.

=cut

sub set_up_db_for_150_missing
{

    my $dbh = db_connect();

    clear_db($dbh);

    # insert one row that is older than 8 hours.
    my $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317277163, 'AMA', 'NTI', TRUNC(SYSDATE-3) + 10/24 + 30/(24*60*60), 317277161, 
    'ASHE', TRUNC(SYSDATE-3) + 5/24, 56221, 58909)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317307034, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 10/24 + 27/(24*60*60), 317307032, 
    'ASHE', TRUNC(SYSDATE-2) + 7/24, 58910, 60913)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317307037, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 10/24 + 54/(24*60*60), 317307036, 
    'ASHE', TRUNC(SYSDATE-2) + 8/24, 61064, 1000611)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317317835, 'AMA', 'NTI', TRUNC(SYSDATE-2) + 12/24 + 44/(24*60*60), 317317833, 
    'ASHE', TRUNC(SYSDATE-2) + 10/24, 612, 5106)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317074688, 'AMA', 'APLX', TRUNC(SYSDATE-3) + 9/24 + 38/(24*60*60), 317074578, 
    'LMAB', TRUNC(SYSDATE-3) + 6/24 + 54/(24*60), 697140, 701076)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317082710, 'AMA', 'APLX', TRUNC(SYSDATE-2) + 11/24 + 55/(24*60*60), 317082705, 
    'LMAB', TRUNC(SYSDATE-2) + 8/24 + 54/(24*60), 701077, 707085)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, FSRC_SRC_TYPE, FSRC_TYPE_ID, SYSTEM_RCV_DATE, FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, RCRDNG_START_DATE, STRT_BLOCK, END_BLOCK)
 Values
   (317093086, 'AMA', 'APLX', TRUNC(SYSDATE-2) + 13/24 + 1/(24*60) + 3/(24*60*60), 317093069, 
    'LMAB', TRUNC(SYSDATE-2) + 10/24 + 54/(24*60), 707086, 714829)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    # insert into ac_physical_files
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE,                          SERIAL_NUMBER)
 Values
   (317277161,  'SASHE_FNTI_12_ID003791_T20050215060012.DAT', 
    TRUNC(SYSDATE-3) + 8/24 + 22/(24*60*60), '003791')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317307032, 'SASHE_FNTI_12_ID003792_T20050215080017.DAT', 
    TRUNC(SYSDATE-2) + 10/24 + 14/(24*60*60), '003792')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
   SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317307036, 'SASHE_FNTI_12_ID003793_T20050215083839.DAT', 
    TRUNC(SYSDATE-2) + 10/24 + 41/(24*60*60), '003793')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317317833, 'SASHE_FNTI_12_ID003794_T20050215100343.DAT', 
    TRUNC(SYSDATE-2) + 12/24 + 29/(24*60*60), '003794')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317074578, 'SLMAB_FAPLX_ID006395_T20050214070100.DAT', 
    TRUNC(SYSDATE-3) + 9/24 + 20/(24*60*60), '006395')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317082705, 'SLMAB_FAPLX_ID006396_T20050214090100.DAT', 
    TRUNC(SYSDATE-2) + 11/24 + 47/(24*60*60), '006396')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
   (IDENTIFIER, FILE_NAME, 
    SYSTEM_RCV_DATE, SERIAL_NUMBER)
 Values
   (317093069, 'SLMAB_FAPLX_ID006397_T20050214110101.DAT', 
    TRUNC(SYSDATE-2) + 13/24 + 43/(24*60*60), '006397')

INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    return $dbh;
}

=head3 Connect to Oracle

  Supporting subroutine.
  Connects to local or specified in arguments database.
  Returns an instanciated USCDB object.

=cut

sub db_connect
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
    my ($uscdb, $sql, @bind_vars) = @_;

    my $status = $uscdb->setQuery($sql);
    unless (defined $status)
    {
        carp "\nError in setQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }

    $status = $uscdb->runQuery(@bind_vars);
    unless (defined $status)
    {
        carp "\nError in runQuery: \n", $uscdb->getErrorStr(), "\n\n";
    }
}

=head3  Clear the Cares databases.

    Clear the pertinent tables in the test databases.

=cut


sub clear_db
{
    my $uscdb = shift;

    # clear ac_logical_files
    my $delete_sql = "delete from ac_logical_files";
    execute_query($uscdb, $delete_sql);
    $uscdb->commit();

    $delete_sql = "delete from ac_physical_files";
    execute_query($uscdb, $delete_sql);
    $uscdb->commit();
}
