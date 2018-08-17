#!/usr/local/bin/perl

=head2 InfraTransfer Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl InfraTransfer.pl MpsLib <path> SqlLib <path> market <M0X>
                        from_hrs_ago <hours> to_hrs_ago <hours> 
                        cares_query <file> infra_query <file> Log <path>
                        [op_job <job>] [op_sid <db instance>]
                        [op_user <username>] [op_pass <password>]

=head3 DESCRIPTION

  Tests basic functionality of the InfraTransfer class.

=head3 INPUT PARAMETERS

  The input parameters comprise of the following pairs:
  Key:          Value:    Description:
  market        <M0X>     Attribute of monitor.xml <params> tab.
  MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
  SqlLib        <path>    Attribute of monitor.xml <M0X> tab.
  from_hrs_ago  <hours>   Attribute of monitor.xml <params> tab.
  to_hrs_ago    <hours>   Attribute of monitor.xml <params> tab.
  cares_query   <file>    Name of the file in SqlLib to be used 
                          for the ac_processing_accounting check.
  infra_query   <file>    Name of the file in SqlLib to be used 
                          for the uscc_usage_audit_t check.                        

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
use Test::Pod;   
use Test::Pod::Coverage;                        
use USCDB;
use Carp;

$| = 1;

my %args = @ARGV;

=head3 TESTS 

=head3 Test Monitor

  Verifies that the Monitor module is visible and accessible.

=cut

use_ok('Monitor');

=head3 Test Monitor::InfraTransfer

  Verifies that the RaterStatus module is visible and accessible.

=cut

use_ok('Monitor::InfraTransfer');

=head3 Test Inheritance

  Verifies that InfraTransfer is a sub class of Monitor.

=cut

my $infra_tr = Monitor::InfraTransfer->new(%args);
                                               
ok($infra_tr->isa('Monitor::InfraTransfer'),
    "Object is of type Monitor::InfraTransfer");

=head3 Test get_market()

  Test accessor method get_market().

=cut

is(uc($infra_tr->get_market()), uc($args{market}),
   "Object is set up for the correct market");


=head3 Test get_from_hrs_ago

  Test accessor method get_from_hrs_ago().

=cut    

is($infra_tr->get_from_hrs_ago(), $args{from_hrs_ago}, 
   "Instance variable 'from' is set correctly.");
   

=head3 Test get_to_hrs_ago

  Test accessor method get_to_hrs_ago().

=cut    

is($infra_tr->get_to_hrs_ago(), $args{to_hrs_ago}, 
   "Instance variable 'to' is set correctly.");
   

=head3 Test get_MpsLib()

  Test accessor method get_MpsLib().

=cut

is($infra_tr->get_MpsLib(), $args{MpsLib},
    "MpsLib is set correctly");
    

=head3 Test get_SqlLib()

  Test accessor method get_SqlLib().

=cut

is($infra_tr->get_SqlLib(), $args{SqlLib},
    "SqlLib is set correctly");
    
    
=head3 Test get_sql_query

    Test that the get_sql_query() method
    returns a populated string.

=cut

my $query = $infra_tr->get_sql_query($args{SqlLib} . $args{cares_query});
ok($query, "get_sql_query() returns a valid cares_query value");

$query = $infra_tr->get_sql_query($args{SqlLib} . $args{infra_query});
ok($query, "get_sql_query() returns a valid infra_query value");


=head3 Test run_check()

  Clear the database.
  Populate ac_processing_accounting and uscc_usage_audit_t
  tables with test data.
  Verify that the return value of run_check() is the predicted
  string.

=cut

test_run_check();

sub test_run_check
{
    my $cares_dbh = set_up_cares_db();
    my $infra_dbh = set_up_infra_db();
    
    # get the recording end date
    my $fetch_sql =<<FETCH_SQL;
SELECT FILE_NAME, 
       WR_REC_QUANTITY 
FROM AC_PROCESSING_ACCOUNTING 
WHERE FPFC_CUR_FILE_ALIAS IN ('AAA','QIS','PMG') 
AND   FPFC_CUR_PGM_NAME = 'MAF2COLL' 
AND   FPFC_NXT_PGM_NAME = 'MAF2COLL' 
AND   FPFC_NXT_FILE_ALIAS = 'TRNSFER'
AND   FILE_STATUS = 'CO' 
AND   DATA_GROUP != 'MARS' 
AND   FILE_PROCESS_DATE BETWEEN SYSDATE-?/24 AND SYSDATE-?/24
FETCH_SQL
    
    
    my $fetch_infra =<<FETCH_INFRA;
SELECT FILE_NAME, NUM_RECORDS 
FROM USCC_USAGE_AUDIT_T 
WHERE ( 
        ( 
            NEXT_PROGRAM_NAME = 'EventLoad' 
            AND FILE_STATUS = 'CO'
        ) 
        OR 
        ( 
             NEXT_PROGRAM_NAME = 'EventRecycle'
             AND FILE_STATUS in('CO','RD')
        )
      ) 
AND FILE_STATUS_DATE > ?
FETCH_INFRA

    
    my $expected_message = "file: AAA1_FAAA_ID315655345_T20050209210516.DAT\n" .
                           "recs: 1024\n\n";
    my $message = $infra_tr->run_check();
    is($message, $expected_message, "run_check() successful!");
    clear_cares_db($cares_dbh);
    $cares_dbh->closeConnection();
    
    clear_infra_db($infra_dbh);
    $infra_dbh->closeConnection();
}   
   
   

=head3 run_check() nothing found.

    Test run_check behavior when no missing files are found.   
    Populate ac_processing_accounting and uscc_usage_audit_t
    with one record for the same file.

=cut
    
    my $cares_dbh = db_cares_connect();
    clear_cares_db($cares_dbh);
    $cares_dbh->closeConnection();
    
    my $infra_dbh = db_infra_connect();
    clear_infra_db($infra_dbh);
    $infra_dbh->closeConnection();
    
    $cares_dbh = set_up_cares_db2();
    $infra_dbh = set_up_infra_db2();
    
    my $message = $infra_tr->run_check();
    ok((!defined $message), "run_check() returns undef!");
    print "message: $message\n\n" if defined $message;
   

=head3 POD test

  Test if POD parses correctly.

=cut 

my $pod_file = $args{MpsLib} . "/Monitor/InfraTransfer.pm";
carp "no pod file!" unless (-e $pod_file);
pod_file_ok( $pod_file, "Valid POD file" );

pod_coverage_ok( "Monitor::InfraTransfer", "Monitor::InfraTransfer is covered" ); 



=head3 set_up_cares_db

    Set up the cares database for testing.

=cut

sub set_up_cares_db
{

my $cares_dbh = db_cares_connect(); 
   
    clear_cares_db($cares_dbh);
    
    # insert one row that is older than 8 hours.
    my $insert_sql =<<INS_SQL;
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
  ( 315655354, 
    'AAA2_FAAA_ID315655343_T20050208210516.DAT', 
    'm01usg1', 
    '/TLG_VAR1/m01/projs/up/data/AAA2/SAAA2_FAAA_ID003800_T20050208200202/', 
    'I01', 
    TO_DATE('02/08/2005 21:05:15', 'MM/DD/YYYY HH24:MI:SS'), 
    26493, TO_DATE('02/08/2005 21:05:13', 'MM/DD/YYYY HH24:MI:SS'), 
    'CO', 
    315655350, 
    'MAF2COLL', 
    'AAA', 
    'MAF2COLL', 
    'TRNSFER', 
    'AAA', 
    'P', 
    'S ', 
    NULL, 
    'D', 
    'N',
    SYSDATE - 1, --TO_DATE('02/08/2005 21:06:51', 'MM/DD/YYYY HH24:MI:SS'), 
    0, 
    TO_DATE('02/08/2005 21:06:47', 'MM/DD/YYYY HH24:MI:SS'), 
    1274, 
    NULL,
    NULL, 
    0, 
    NULL, 
    NULL, 
    0, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    TO_DATE('02/09/2005 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    NULL, 
    'm01usg1', 
    '/TLG_VAR1/m01/projs/up/data/AAA2/SAAA2_FAAA_ID003800_T20050208200202/', 
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
    
    execute_query($cares_dbh, $insert_sql);
    $cares_dbh->commit();
    
    #add another row
    $insert_sql =<<INS_SQL;
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
  ( 315655360, 
    'AAA1_FAAA_ID315655345_T20050209210516.DAT', 
    'm01usg1', 
    '/TLG_VAR1/m01/projs/up/data/AAA2/SAAA2_FAAA_ID003800_T20050208200202/', 
    'I01', 
    TO_DATE('02/08/2005 21:05:15', 'MM/DD/YYYY HH24:MI:SS'), 
    26493, TO_DATE('02/08/2005 21:05:13', 'MM/DD/YYYY HH24:MI:SS'), 
    'CO', 
    315655350, 
    'MAF2COLL', 
    'AAA', 
    'MAF2COLL', 
    'TRNSFER', 
    'AAA', 
    'P', 
    'S ', 
    NULL, 
    'D', 
    'N',
    SYSDATE - 1, --TO_DATE('02/08/2005 21:06:51', 'MM/DD/YYYY HH24:MI:SS'), 
    0, 
    TO_DATE('02/08/2005 21:06:47', 'MM/DD/YYYY HH24:MI:SS'), 
    1024, 
    NULL,
    NULL, 
    0, 
    NULL, 
    NULL, 
    0, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    TO_DATE('02/09/2005 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    NULL, 
    'm01usg1', 
    '/TLG_VAR1/m01/projs/up/data/AAA2/SAAA2_FAAA_ID003800_T20050208200202/', 
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
    
    execute_query($cares_dbh, $insert_sql);
    $cares_dbh->commit();
    return $cares_dbh;

}


=head3 set_up_infra_db

    Set up the Infranet database for testing.

=cut

sub set_up_infra_db
{

my $infra_dbh = db_infra_connect(); 
   
    clear_infra_db($infra_dbh);
    
    # insert one row that is older than 8 hours.
    my $insert_sql =<<INS_SQL;
Insert into uscc_usage_audit_t
  ( POID_DB, 
    POID_ID0, 
    POID_TYPE, 
    POID_REV, 
    CREATED_T, 
    MOD_T, 
    READ_ACCESS, 
    WRITE_ACCESS, 
    ACCOUNT_OBJ_DB, 
    ACCOUNT_OBJ_ID0, 
    ACCOUNT_OBJ_TYPE, 
    ACCOUNT_OBJ_REV, 
    ACPA_ID, 
    CUR_FILE_ALIAS, 
    CUR_PROGRAM_NAME, 
    FILE_FORMAT, 
    FILE_NAME, 
    FILE_PATH, 
    FILE_RECEIVE_DATE, 
    FILE_STATUS, 
    FILE_STATUS_DATE, 
    NEXT_FILE_ALIAS, 
    NEXT_PROGRAM_NAME, 
    NUM_RECORDS
  )
 Values
   ( 1, 
     283512606, 
     '/uscc_usage_audit', 
     4, 
     1107914861,
     1107992167, 
     'S', 
     'S', 
     1, 
     -1,
     '/account', 
     0, 
     '315655343', 
     'AAA', 
     'EventLoad',
     'AAA', 
     'AAA2_FAAA_ID315655343_T20050208210516.DAT', 
     '/opt/portal/6.5/pinm01/mps/physical/switch/aaa2/', 
     1107914861, 
     'RD',
     ?, 
     'AAA', 
     'EventRecycle', 
     1274
   )
INS_SQL
    
    my $file_status_date = (time() - (60 * 60 * 24));
    execute_query($infra_dbh, $insert_sql, $file_status_date);
    $infra_dbh->commit();
    
    return $infra_dbh;

}



=head3 set_up_cares_db2

    Set up the cares database for testing.

=cut

sub set_up_cares_db2
{

my $cares_dbh = db_cares_connect(); 
   
    clear_cares_db($cares_dbh);
    
    # insert one row that is older than 8 hours.
    my $insert_sql =<<INS_SQL;
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
  ( 315655354, 
    'AAA2_FAAA_ID315655343_T20050208210516.DAT', 
    'm01usg1', 
    '/TLG_VAR1/m01/projs/up/data/AAA2/SAAA2_FAAA_ID003800_T20050208200202/', 
    'I01', 
    TO_DATE('02/08/2005 21:05:15', 'MM/DD/YYYY HH24:MI:SS'), 
    26493, TO_DATE('02/08/2005 21:05:13', 'MM/DD/YYYY HH24:MI:SS'), 
    'CO', 
    315655350, 
    'MAF2COLL', 
    'AAA', 
    'MAF2COLL', 
    'TRNSFER', 
    'AAA', 
    'P', 
    'S ', 
    NULL, 
    'D', 
    'N',
    SYSDATE - 1, --TO_DATE('02/08/2005 21:06:51', 'MM/DD/YYYY HH24:MI:SS'), 
    0, 
    TO_DATE('02/08/2005 21:06:47', 'MM/DD/YYYY HH24:MI:SS'), 
    1274, 
    NULL,
    NULL, 
    0, 
    NULL, 
    NULL, 
    0, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    NULL, 
    TO_DATE('02/09/2005 00:00:00', 'MM/DD/YYYY HH24:MI:SS'), 
    NULL, 
    'm01usg1', 
    '/TLG_VAR1/m01/projs/up/data/AAA2/SAAA2_FAAA_ID003800_T20050208200202/', 
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
    
    execute_query($cares_dbh, $insert_sql);
    $cares_dbh->commit();
    
    return $cares_dbh;

}


=head3 set_up_infra_db2

    Set up the Infranet database for testing.

=cut

sub set_up_infra_db2
{

my $infra_dbh = db_infra_connect(); 
   
    clear_infra_db($infra_dbh);
    
    # insert one row that is older than 8 hours.
    my $insert_sql =<<INS_SQL;
Insert into uscc_usage_audit_t
  ( POID_DB, 
    POID_ID0, 
    POID_TYPE, 
    POID_REV, 
    CREATED_T, 
    MOD_T, 
    READ_ACCESS, 
    WRITE_ACCESS, 
    ACCOUNT_OBJ_DB, 
    ACCOUNT_OBJ_ID0, 
    ACCOUNT_OBJ_TYPE, 
    ACCOUNT_OBJ_REV, 
    ACPA_ID, 
    CUR_FILE_ALIAS, 
    CUR_PROGRAM_NAME, 
    FILE_FORMAT, 
    FILE_NAME, 
    FILE_PATH, 
    FILE_RECEIVE_DATE, 
    FILE_STATUS, 
    FILE_STATUS_DATE, 
    NEXT_FILE_ALIAS, 
    NEXT_PROGRAM_NAME, 
    NUM_RECORDS
  )
 Values
   ( 1, 
     283512606, 
     '/uscc_usage_audit', 
     4, 
     1107914861,
     1107992167, 
     'S', 
     'S', 
     1, 
     -1,
     '/account', 
     0, 
     '315655343', 
     'AAA', 
     'EventLoad',
     'AAA', 
     'AAA2_FAAA_ID315655343_T20050208210516.DAT', 
     '/opt/portal/6.5/pinm01/mps/physical/switch/aaa2/', 
     1107914861, 
     'RD',
     ?, 
     'AAA', 
     'EventRecycle', 
     1274
   )
INS_SQL
    
    my $file_status_date = (time() - (60 * 60 * 24));
    execute_query($infra_dbh, $insert_sql, $file_status_date);
    $infra_dbh->commit();
    
    return $infra_dbh;

}








=head3  Clear the Cares databases.

    Clear the pertinent tables in the test databases.

=cut

sub clear_cares_db
{
    my $uscdb = shift;
    # clear ac_logical_files
    my $delete_sql = "delete from ac_processing_accounting";
    execute_query($uscdb, $delete_sql);
    $uscdb->commit();
}


=head3  Clear the Infranet databases.

    Clear the pertinent tables in the test databases.

=cut

sub clear_infra_db
{
    my $uscdb = shift;
    # clear ac_logical_files
    my $delete_sql = "delete from uscc_usage_audit_t";
    execute_query($uscdb, $delete_sql);
    $uscdb->commit();
}


=head3 Connect to cares Oracle

  Supporting subroutine.
  Connects to local or specified in arguments database.
  Returns an instanciated USCDB object.

=cut

sub db_cares_connect
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
    unless(defined $rc)
    {
        carp "Could not connect to Oracle!" , $uscdb->getErrorStr() , "\n\n";
    }
    return $uscdb;
}



=head3 Connect to Infranet Oracle

  Supporting subroutine.
  Connects to local or specified in arguments database.
  Returns an instanciated USCDB object.

=cut

sub db_infra_connect
{
    my $uscdb       = USCDB->new();
    my @connect_str = ('infrad','pin11','portal11');
    
    # Get rid of white space in the parameter values.
    foreach my $conn (@connect_str)
    {
        $conn =~ s/\s+//g;
    }

    my $rc = $uscdb->openConnection(@connect_str);
    unless(defined $rc)
    {
        carp "Could not connect to Oracle!" , $uscdb->getErrorStr() , "\n\n";
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
  my ($uscdb,$sql,@bind_vars) = @_;

  my $status = $uscdb->setQuery($sql);
  unless(defined $status)
  {
      carp "\nError in setQuery: \n", $uscdb->getErrorStr(), "\n\n";
  }

  $status = $uscdb->runQuery(@bind_vars);
  unless(defined $status)  
  {
    carp "\nError in runQuery: \n", $uscdb->getErrorStr(), "\n\n";
  }
}