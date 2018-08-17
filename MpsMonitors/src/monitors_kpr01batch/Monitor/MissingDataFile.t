#!/usr/local/bin/perl

=head2 MissingDataFile Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl MissingDataFile.t MpsLib <path> SqlLib <path> Log <path>
                         from_hrs_ago <hours> to_hrs_ago <hours>
                         market <market> threshold <number>
                         switch_query <file> sql_query <file> 
                         [op_job <job>] [op_sid <db instance>]
                         [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  Tests basic functionality of the MissingDataFile class.

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

=head3 Test Monitor::MissingDataFile

  Verifies that the RaterStatus module is visible and accessible.

=cut

use_ok('Monitor::MissingDataFile');

=head3 Test Inheritance

  Verifies that MissingDataFile is a sub class of Monitor.

=cut

my $missing_file = Monitor::MissingDataFile->new(%args);

isa_ok($missing_file, 'Monitor::MissingDataFile');

=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($missing_file->get_market()),
    uc($args{market}), "Object is set up for the correct market");

=head3 Test get_from_hrs_ago

  Test accessor method get_from_hrs_ago().

=cut    

is($missing_file->get_from_hrs_ago(),
    $args{from_hrs_ago}, "Instance variable 'from' is set correctly.");

=head3 Test get_to_hrs_ago

  Test accessor method get_to_hrs_ago().

=cut    

is($missing_file->get_to_hrs_ago(),
    $args{to_hrs_ago}, "Instance variable 'to' is set correctly.");

=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($missing_file->get_MpsLib(), $args{MpsLib}, "MpsLib is set correctly");

=head3 Test get_SqlLib()

  Test accessor method get_SqlLib().

=cut

is($missing_file->get_SqlLib(), $args{SqlLib}, "SqlLib is set correctly");

=head3 Test get_sql_query

    Test that the get_sql_query() method
    returns a populated string.

=cut

my $query = $missing_file->get_sql_query($args{SqlLib} . $args{sql_query});
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

    my $message = $missing_file->run_check();
    is($message, undef, "run_check() returns undef when no problems.");

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
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318047806, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE-3)+16/24+05/(24*60)+15/(24*60*60), 
    318047789, 
    'PMSG1', 
    TRUNC(SYSDATE-3)+18/24+31/(24*60)+30/(24*60*60), 
    TRUNC(SYSDATE-3)+20/24+35/(24*60)+40/(24*60*60), 
    9800, 
    9899)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318068903, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE -3)+18/24+04/(24*60)+31/(24*60*60), 
    318068809, 
    'PMSG1', 
    TRUNC(SYSDATE -3)+20/24+36/(24*60)+20/(24*60*60), 
    TRUNC(SYSDATE -3)+22/24+35/(24*60)+43/(24*60*60), 
    9900, 
    9999)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318082635, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE -3)+20/24+03/(24*60)+59/(24*60*60), 
    318082633, 
    'PMSG1', 
    TRUNC(SYSDATE -3)+22/24+34/(24*60)+42/(24*60*60), 
    TRUNC(SYSDATE -2)+35/(24*60)+35/(24*60*60), 
    0, 
    99)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318096600, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE -3)+22/24+04/(24*60)+57/(24*60*60), 
    318096510, 
    'PMSG1', 
    TRUNC(SYSDATE -2)+28/(24*60), 
    TRUNC(SYSDATE -2)+02/24+35/(24*60)+33/(24*60*60), 
    100, 
    199)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318544943, 
    'AMA', 
    'SMS', 
    TRUNC(SYSDATE-1)+08/24+16/(24*60)+25/(24*60*60), 
    318544942, 
    'PTS1', 
    TRUNC(SYSDATE-1)+10/24+44/(24*60)+37/(24*60*60), 
    TRUNC(SYSDATE-1)+11/24+40/(24*60)+42/(24*60*60), 
    9800, 
    9899)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318549935, 
    'AMA', 
    'SMS', 
    TRUNC(SYSDATE-1)+10/24+15/(24*60)+38/(24*60*60), 
    318549918, 
    'PTS1', 
    TRUNC(SYSDATE-1)+13/24+30/(24*60)+11/(24*60*60), 
    TRUNC(SYSDATE-1)+13/24+30/(24*60)+45/(24*60*60), 
    9900, 
    9999)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318549929, 
    'AMA', 
    'SMS', 
    TRUNC(SYSDATE-1)+10/24+15/(24*60)+38/(24*60*60), 
    318549917, 
    'PTS1', 
    TRUNC(SYSDATE-1)+13/24+53/(24*60)+39/(24*60*60), 
    TRUNC(SYSDATE-1)+13/24+39/(24*60)+47/(24*60*60), 
    0, 
    99)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    # insert into ac_physical_files
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318557661, 
    'AMA', 
    'SMS', 
    TRUNC(SYSDATE-1)+12/24+16/(24*60)+37/(24*60*60), 
    318557659, 
    'PTS1', 
    TRUNC(SYSDATE-1)+14/24+41/(24*60)+36/(24*60*60), 
    TRUNC(SYSDATE-1)+15/24+40/(24*60)+10/(24*60*60), 
    100, 
    199)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318047789, 
  'SPMSG1_FPMG_ID009800_T20050218160009.DAT', 
  TRUNC(SYSDATE-3)+16/24+04/(24*60)+09/(24*60*60), 
  '009800')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318068809, 
  'SPMSG1_FPMG_ID009900_T20050218180007.DAT', 
  TRUNC(SYSDATE-3)+18/24+03/(24*60)+51/(24*60*60), 
  '009900')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318082633, 
 'SPMSG1_FPMG_ID000000_T20050218200008.DAT', 
 TRUNC(SYSDATE-3)+20/24+03/(24*60)+15/(24*60*60), 
 '000000')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318096510, 
  'SPMSG1_FPMG_ID000100_T20050218220005.DAT', 
  TRUNC(SYSDATE-3)+22/24+03/(24*60)+51/(24*60*60), 
  '000100')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318544942, 
  'SPTS1_FSMSSPLT_ID009800_T20050220081506.DAT', 
  TRUNC(SYSDATE-1)+08/24+15/(24*60)+28/(24*60*60),
  '009800')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318549918, 
 'SPTS1_FSMSSPLT_ID009900_T20050220101506.DAT', 
 TRUNC(SYSDATE-1)+10/24+15/(24*60)+25/(24*60*60), 
 '009900')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318549917, 
  'SPTS1_FSMSSPLT_ID000000_T20050220101507.DAT', 
  TRUNC(SYSDATE-1)+10/24+15/(24*60)+25/(24*60*60),
  '000000')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318557659, 
  'SPTS1_FSMSSPLT_ID000100_T20050220121507.DAT', 
  TRUNC(SYSDATE-1)+12/24+15/(24*60)+13/(24*60*60), 
  '000100')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    return $dbh;
}



=head3 Test run_check_out_of_sequence()

  Clear the database.
  Populate ac_logical_files and ac_physical_files tables 
  with test data.
  Verify that the return value of run_check() is the predicted
  string.

=cut

test_run_check_out_of_sequence();

sub test_run_check_out_of_sequence
{
    my $dbh = set_up_db_for_out_of_sequence();

    my $message = $missing_file->run_check();
    is($message, undef, "run_check() returns undef when "
                      . "file comes in out of sequence.");

    clear_db($dbh);
    $dbh->closeConnection();
}



=head3 set_up_db_for_out_of_sequence

    Set up the cares database for testing.

=cut

sub set_up_db_for_out_of_sequence
{

    my $dbh = db_connect();

#    clear_db($dbh);

    # insert one row that is older than 8 hours.
    my $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318047805, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE-2)+16/24+05/(24*60)+15/(24*60*60), 
    318047788, 
    'PTS2', 
    TRUNC(SYSDATE-1)+00/24+43/(24*60)+39/(24*60*60), 
    TRUNC(SYSDATE-1)+01/24+40/(24*60)+37/(24*60*60), 
    1100, 
    1199)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();
    
    # insert one row that is older than 8 hours.
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318047806, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE-2)+16/24+05/(24*60)+15/(24*60*60), 
    318047789, 
    'PTS2', 
    TRUNC(SYSDATE-1)+01/24+41/(24*60)+52/(24*60*60), 
    TRUNC(SYSDATE-1)+02/24+41/(24*60)+04/(24*60*60), 
    1800, 
    1899)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318068903, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE -2)+18/24+04/(24*60)+31/(24*60*60), 
    318068809, 
    'PTS2', 
    TRUNC(SYSDATE -1)+02/24+42/(24*60)+10/(24*60*60), 
    TRUNC(SYSDATE -1)+04/24+38/(24*60)+28/(24*60*60), 
    1200, 
    1299)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318082635, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE -2)+20/24+03/(24*60)+59/(24*60*60), 
    318082633, 
    'PTS2', 
    TRUNC(SYSDATE -1)+04/24+43/(24*60)+28/(24*60*60), 
    TRUNC(SYSDATE -1)+06/24+10/(24*60)+31/(24*60*60), 
    1300, 
    1399)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318096600, 
    'AMA', 
    'PMG', 
    TRUNC(SYSDATE -2)+22/24+04/(24*60)+57/(24*60*60), 
    318096510, 
    'PTS2', 
    TRUNC(SYSDATE -1)+06/24+53/(24*60)+40/(24*60*60), 
    TRUNC(SYSDATE -1)+08/24+12/(24*60)+19/(24*60*60), 
    1400, 
    1499)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318544943, 
    'AMA', 
    'SMS', 
    TRUNC(SYSDATE-2)+08/24+16/(24*60)+25/(24*60*60), 
    318544942, 
    'PTS2', 
    TRUNC(SYSDATE-1)+08/24+53/(24*60)+33/(24*60*60), 
    TRUNC(SYSDATE-1)+10/24+39/(24*60)+45/(24*60*60), 
    1500, 
    1599)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318549935, 
    'AMA', 
    'SMS', 
    TRUNC(SYSDATE-2)+10/24+15/(24*60)+38/(24*60*60), 
    318549918, 
    'PTS2', 
    TRUNC(SYSDATE-1)+10/24+41/(24*60)+48/(24*60*60), 
    TRUNC(SYSDATE-1)+12/24+33/(24*60)+49/(24*60*60), 
    1600, 
    1699)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318549929, 
    'AMA', 
    'SMS', 
    TRUNC(SYSDATE-2)+10/24+15/(24*60)+38/(24*60*60), 
    318549917, 
    'PTS2', 
    TRUNC(SYSDATE-1)+12/24+46/(24*60)+04/(24*60*60), 
    TRUNC(SYSDATE-1)+14/24+41/(24*60)+07/(24*60*60), 
    1700, 
    1799)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    # insert into ac_physical_files
    $insert_sql = <<INS_SQL;
Insert into ac_logical_files
   (IDENTIFIER, 
    FSRC_SRC_TYPE, 
    FSRC_TYPE_ID, 
    SYSTEM_RCV_DATE, 
    FPHY_ORIG_FILE_ID, 
    FSRC_SENSOR_ID, 
    RCRDNG_START_DATE, 
    RCRDNG_END_DATE, 
    STRT_BLOCK, 
    END_BLOCK)
 Values
   (318557661, 
    'AMA', 
    'SMS', 
    TRUNC(SYSDATE-2)+12/24+16/(24*60)+37/(24*60*60), 
    318557659, 
    'PTS2', 
    TRUNC(SYSDATE-1)+14/24+47/(24*60)+44/(24*60*60), 
    TRUNC(SYSDATE-1)+16/24+37/(24*60)+56/(24*60*60), 
    1900, 
    1999)
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318047788, 
  'SPMSG1_FPMG_ID009800_T20050218160004.DAT', 
  TRUNC(SYSDATE-3)+16/24+04/(24*60)+09/(24*60*60), 
  '001100')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();
    
    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318047789, 
  'SPMSG1_FPMG_ID009800_T20050218160009.DAT', 
  TRUNC(SYSDATE-3)+16/24+04/(24*60)+09/(24*60*60), 
  '001800')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318068809, 
  'SPMSG1_FPMG_ID009900_T20050218180007.DAT', 
  TRUNC(SYSDATE-3)+18/24+03/(24*60)+51/(24*60*60), 
  '001200')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318082633, 
 'SPMSG1_FPMG_ID000000_T20050218200008.DAT', 
 TRUNC(SYSDATE-3)+20/24+03/(24*60)+15/(24*60*60), 
 '001300')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318096510, 
  'SPMSG1_FPMG_ID000100_T20050218220005.DAT', 
  TRUNC(SYSDATE-3)+22/24+03/(24*60)+51/(24*60*60), 
  '001400')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318544942, 
  'SPTS1_FSMSSPLT_ID009800_T20050220081506.DAT', 
  TRUNC(SYSDATE-1)+08/24+15/(24*60)+28/(24*60*60),
  '001500')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318549918, 
 'SPTS1_FSMSSPLT_ID009900_T20050220101506.DAT', 
 TRUNC(SYSDATE-1)+10/24+15/(24*60)+25/(24*60*60), 
 '001600')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318549917, 
  'SPTS1_FSMSSPLT_ID000000_T20050220101507.DAT', 
  TRUNC(SYSDATE-1)+10/24+15/(24*60)+25/(24*60*60),
  '001700')
INS_SQL

    execute_query($dbh, $insert_sql);
    $dbh->commit();

    #add another row
    $insert_sql = <<INS_SQL;
Insert into ac_physical_files
  (IDENTIFIER, 
   FILE_NAME, 
   SYSTEM_RCV_DATE,
   SERIAL_NUMBER)
 Values
 (318557659, 
  'SPTS1_FSMSSPLT_ID000100_T20050220121507.DAT', 
  TRUNC(SYSDATE-1)+12/24+15/(24*60)+13/(24*60*60), 
  '001900')
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
