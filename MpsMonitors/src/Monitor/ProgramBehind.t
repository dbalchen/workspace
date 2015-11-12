
=head2 SwitchBehind Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl ProgramBehind.t MpsLib <path> SqlLib <path> Log <path>
                       threshold <int hours> market <market> 
                       sql_query <file>
                       [op_job <job>] [op_sid <db instance>]
                       [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  Tests basic functionality of the SwitchBehind class.

=head3 INPUT PARAMETERS

  The input parameters comprise of the following pairs:
  Key:          Value:    Description:
  MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
  SqlLib        <path>    Attribute of monitor.xml <M0X> tab.
  sql_query     <file>    Attribute of monitor.xml <params> tab.
  threshold     <hours>   Attribute of monitor.xml <params> tab.
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

use_ok('Monitor::ProgramBehind');

=head3 Test Inheritance

  Verifies that SwitchBehind is a sub class of Monitor.

=cut

my $program_behind =
  Monitor::ProgramBehind->new(
                              MpsLib    => $args{MpsLib},
                              SqlLib    => $args{SqlLib},
                              market    => $args{market},
                              threshold => $args{threshold},
                              sql_query => $args{sql_query},
                              op_job    => $args{op_job},
                              op_sid    => $args{op_sid},
                              op_user   => $args{op_user},
                              op_pass   => $args{op_pass}
                             );

ok($program_behind->isa('Monitor::ProgramBehind'),
    "Object is of type Monitor::ProgramBehind");

=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($program_behind->get_market()),
    'M01', "Object is set up for the correct market");

=head3 Test get_threshold

  Test accessor method get_threshold().

=cut    

is($program_behind->get_threshold(),
    $args{threshold}, "Instance variable 'threshold' is set correctly.");

=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($program_behind->get_MpsLib(), $args{MpsLib}, "MpsLib is set correctly");

=head3 Test get_SqlLib()

  Test accessor method get_SqlLib().

=cut

is($program_behind->get_SqlLib(), $args{SqlLib}, "SqlLib is set correctly");

=head3 Test get_sql_query

    Test that the get_program_behind_query() method
    returns a populated string.

=cut

my $query = $program_behind->get_sql_query($args{SqlLib} . $args{sql_query});
ok($query, "get_sql_query() returns a defined value");

=head3 Test get_db()

    Check if get_db() returns a defined database object.

=cut

my $dbh = $program_behind->get_db();
ok($dbh->isa('USCDB'), "get_db() returnes an initialized USCDB object.");

=head3 Test get_data()

    Check if get_data returns a populated hash

=cut

my $uscdb       = set_up_db();
my %programHash = $program_behind->get_data($query);
ok(%programHash, "get_data() returns a defined Hash.");
clear_db($uscdb);
$uscdb->closeConnection();

=head3 Test run_check()

  Clear the database.
  Populate the ac_processing_accounting table with data
  that will make the check return a predictable string.
  Verify that the return value of run_check() is the predicted
  string.

=cut

test_run_check();

sub test_run_check
{
    my $uscdb = set_up_db();

    # get the recording end date
    my $fetch_sql = <<FETCH_SQL;
SELECT decode(fpfc_nxt_pgm_name,'UPS2COLL','Collections', 
         'MAF2COLL','MAF_Collections', 
         'UPS2MDRV','Main_Driver','mpgd_100mn','Guiding',
         'mpup_100mn','Rating', fpfc_nxt_pgm_name), 
       file_status, count(*) cnt, sum(wr_rec_quantity) rec_quan 
FROM ac_processing_accounting 
WHERE fpfc_nxt_pgm_name in ('UPS2COLL','MAF2COLL','UPS2MDRV','mpgd_100mn',
                            'mpup_100mn') 
AND file_status in ('IU','AF','AE','RD','WA') 
HAVING sum(wr_rec_quantity) > ? 
GROUP BY fpfc_nxt_pgm_name, file_status
FETCH_SQL

    my $threshold = $program_behind->get_threshold();
    $fetch_sql =~ s/\?/$threshold/i;
    my ($program, $file_status, $file_count, $record_count) =
      $uscdb->selectFetchRow($fetch_sql);

    is(
        $program_behind->run_check(),
        "Program:      " . $program . "\n"
          . "File Status:  "
          . $file_status . "\n"
          . "File Count:   "
          . $file_count . "\n"
          . "Record Count: "
          . $record_count . "\n\n",
        "run_check() returns expected values."
      );

    clear_db($uscdb);
    $uscdb->closeConnection();
}

=head3 Test no error condition  

    Verifies behavior when no programs are behind.

=cut

test_nothing_behind();

sub test_nothing_behind
{
    my $uscdb = dbConnect();
    clear_db($uscdb);
    ok(!$program_behind->run_check(), "run_check() - Nothing Found to report.");

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
Insert into ac_processing_accounting
  ( IDENTIFIER, 
    FILE_NAME, 
    HOST_NAME, 
    FILE_PATH, 
    DATA_GROUP, 
    FILE_CREATE_DATE, 
    CUR_JOB_NUMBER, 
    CUR_PGM_STR_DATE, 
    FILE_STATUS, 
    ORIGIN_FILE_IDENT, 
    FPFC_CUR_PGM_NAME, 
    FPFC_CUR_FILE_ALIAS, 
    FPFC_NXT_PGM_NAME, 
    FPFC_NXT_FILE_ALIAS, 
    FPFC_FILE_FORMAT, 
    FPFC_FILE_GROUP, 
    FPFC_FILE_TYPE, 
    VOL_SER_ID, 
    MEDIA_TYPE, 
    REPRO_IND, 
    FILE_PROCESS_DATE, 
    NXT_JOB_NUMBER, 
    NXT_PGM_STR_DATE, 
    WR_REC_QUANTITY, 
    WR_TIME_QUANTITY, 
    WR_MONEY_QUANTITY, 
    IN_REC_QUANTITY, 
    IN_TIME_QUANTITY, 
    IN_MONEY_QUANTITY, 
    GN_REC_QUANTITY, 
    GN_TIME_QUANTITY, 
    GN_MONEY_QUANTITY, 
    DR_REC_QUANTITY, 
    DR_TIME_QUANTITY, 
    DR_MONEY_QUANTITY, 
    BALANCE_DATE, 
    PROCESSED_REC_NO, 
    HOST_OF_PROCESS, 
    PATH_OF_PROCESS, 
    FILE_DELETED, 
    SYSTEM_ID, 
    TLG_VAR, 
    WR_VOL_REC_QUANTITY, 
    WR_VOLUME_QUANTITY, 
    IN_VOL_REC_QUANTITY, 
    IN_VOLUME_QUANTITY, 
    GN_VOL_REC_QUANTITY, 
    GN_VOLUME_QUANTITY, 
    DR_VOL_REC_QUANTITY, 
    DR_VOLUME_QUANTITY
    )
 Values
  ( 315207037, 
    'ugd_M01_B11.dat', 
    'm01usg1', 
    '/TLG_VAR1/m01/projs/up/data/SMS/SSMS_FSMS_ID008300_T20050206220202/G1/', 
    'M01-B1',
    TO_DATE('02/06/2005 23:03:05', 'MM/DD/YYYY HH24:MI:SS'), 
    9079, 
    TO_DATE('02/06/2005 22:58:49', 'MM/DD/YYYY HH24:MI:SS'), 
    'AF', 
    315206147, 
    'mpgd_100mn', 
    'rater', 
    'mpup_100mn', 
    'rater', 
    'USAGE',
    'I', 
    'S ', 
    NULL, 
    NULL, 
    'N',
    TO_DATE('02/06/2005 23:03:07', 'MM/DD/YYYY HH24:MI:SS'), 
    4697, 
    TO_DATE('02/06/2005 23:03:07', 'MM/DD/YYYY HH24:MI:SS'), 
    1000288, 
    NULL,
    NULL, 
    31, 
    NULL, 
    NULL, 
    NULL,
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL,
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL,
    'MPS  ', 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL
    )
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
    my $delete_sql = "delete from ac_processing_accounting";
    execute_query($uscdb, $delete_sql);
    $uscdb->commit();
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

