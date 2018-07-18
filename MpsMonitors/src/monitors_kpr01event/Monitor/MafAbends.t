#!/usr/local/bin/perl

=head2 MafAbends Unit Test Suite. 

=head3 AUTHOR

Pete Chudykowski

=head3 SYNOPSIS

  perl MafAbends.t MpsLib <path> 
                   SqlLib <path> 
                   Log <path>
                   sql_query <file>
                   alarm_threshold <int hours>  
                   market <M0X> 
                   title <string>
                   [op_job <job>] 
                   [op_sid <db instance>]
                   [op_user <username>] 
                   [op_pass <password>]

=head3 DESCRIPTION

Tests basic functionality of the MafAbends class.

=head3 INPUT PARAMETERS

The input parameters comprise of the following pairs:

=over 2

 Key:          Value:    Description:
 MpsLib        <path>    Attribute of monitor.xml <M0X> tab.
 SqlLib        <path>    Attribute of monitor.xml <M0X> tab.
 Log           <path>    Attribute of monitor.xml <params> tab.
 alarm_threshold <hours> Attribute of monitor.xml <params> tab.
 sql_query     <file>    Attribute of monitor.xml <params> tab.
 market        <M0X>     Attribute of monitor.xml <params> tab.

=cut

use strict;
use warnings;

BEGIN
{
    my %args = @ARGV;
    push @INC, $args{MpsLib};
}

use Test::More tests => 22;

use USCDB;
use Carp;
use Data::Dumper;

$| = 1;

my %args = @ARGV;


=head3 Test MafAbends

Verifies that MafAbends module exists, is in the path, 
and that it returns a true value.

=cut

use_ok('Monitor::MafAbends');


=head3 Test Monitor

Verifies that the Monitor module is visible and accessible.

=cut

use_ok('Monitor');


=head3 Test Inheritance

Verifies that MafAbends is a subclass of Monitor.
Tests the constructor.

=cut

  my $MafAbends = get_object();

  ok($MafAbends->isa('Monitor::MafAbends'),
      "Object is of type Monitor::MafAbends");


=head3 Test Accessor Methods

=item Create a new MafAbends Object.

=cut

  $MafAbends = get_object();
    

=item MpsLib accessor.

=cut

  my $MpsLib = $MafAbends->MpsLib();
  is($MpsLib, $args{MpsLib},
     'Getting MpsLib works correctly');

  $MpsLib = $MafAbends->MpsLib('/new/path/');
  is($MpsLib,'/new/path/',
     'Setting MpsLib works correctly');


=item SqlLib accessor.

=cut

  my $SqlLib = $MafAbends->SqlLib();
  is($SqlLib, $args{SqlLib},
     'Getting SqlLib works correctly');

  $SqlLib = $MafAbends->SqlLib('/new/path/');
  is($SqlLib,'/new/path/',
     'Setting SqlLib works correctly');


=item market accessor

=cut

  my $market = $MafAbends->market();
  is($market, $args{market},
     'Getting market works correctly');

  $market = $MafAbends->market('M02');
  is($market,'M02',
     'Setting market works correctly');


=item alarm_threshold accessor

=cut

  my $alarm_threshold = $MafAbends->alarm_threshold();
  is($alarm_threshold, $args{alarm_threshold},
     'Getting alarm_threshold works correctly');

  $alarm_threshold = $MafAbends->alarm_threshold('20');
  is($alarm_threshold,'20',
     'Setting alarm_threshold works correctly');


=item title accessor

=cut

  my $title = $MafAbends->title();
  is($title, $args{title},
     'Getting title works correctly');

  $title = $MafAbends->title('new title');
  is($title,'new title',
     'Setting title works correctly');


=item sql_query accessor

=cut

  my $sql_query = $MafAbends->sql_query();
  is($sql_query, $args{sql_query},
     'Getting sql_query works correctly');

  $sql_query = $MafAbends->sql_query('NewSqlFileName');
  is($sql_query,'NewSqlFileName',
     'Setting sql_query works correctly');


=head3 Test Audit methods

=item get_sql_query

=over 2

Tests retrieval of the SQL statement from the sql file using the
method inherited from Monitor get_sql_query().

=back

=cut

  $MafAbends = get_object();
  my $sql_stmt = $MafAbends->get_sql_query(
                                            $MafAbends->{SqlLib} 
                                          . $MafAbends->{sql_query}
                                          );
  
  ok($sql_stmt, '$sql_stmt is defined');
  

=item get_counts

=over 2

Tests the retrieval of abend counts from the database.
Some initial setup of the database is performed. 

=back

=cut

  # set up the database for the get_data test
  db_setup_for_get_counts();
  
  $MafAbends = get_object();
  my %counts = $MafAbends->get_counts();
  
  # compare the counts somehow
  foreach my $pgm_name (values(%counts))
  {
    foreach my $count (values(%$pgm_name))
    {
      is($count,4,'Count is correct');
    }
  }

# DEBUG: For visual verification
#  foreach my $pgm_name (keys(%counts))
#  {
#    foreach my $fstatus ( keys( %{$counts{$pgm_name}} ))
#    {
#      print "$pgm_name\t$fstatus\t" . $counts{$pgm_name}{$fstatus} . "\n";
#    }
#  }
# END DEBUG

  acpa_cleanup(db_connect());



=item run_check_alarm_condition

=over 2

Tests the main Audit method run_check() in an alarm condition.

=back

=cut

  db_setup_for_run_check_alarm_condition();
  $MafAbends = get_object();
  my $run_check_result = $MafAbends->run_check();
  
  my $run_check_expected = "Main_Driver\tAE\t4\nMain_Driver\tAF\t4\n"
                         . "Collections\tAE\t4\nCollections\tAF\t4\n";
  is($run_check_result,$run_check_expected,
     'run_check() produces expected result in the alarm condition');

  acpa_cleanup(db_connect());



=item run_check_nothing_found

=over 2

Tests the main Audit method run_check() without an alarm condition.

=back

=cut

  db_setup_for_run_check_nothing_found();
  $MafAbends = get_object();
  $run_check_result = $MafAbends->run_check();
  
  is($run_check_result,undef,
     'run_check() produces expected result without the alarm condition');

  acpa_cleanup(db_connect());


=head3 Supporting Subroutines

=item getObject

=over 2  

Instanciates a MafAbends object useing input argument hash.
Returns a reference to this object.

=back

=cut


sub get_object
{
  return Monitor::MafAbends->new(
                            MpsLib    => $args{MpsLib},
                            SqlLib    => $args{SqlLib},
                            market    => $args{market},
                            alarm_threshold => $args{alarm_threshold},         
                            title     => $args{title},
                            sql_query => $args{sql_query},
                            op_job    => $args{op_job},
                            op_sid    => $args{op_sid},
                            op_user   => $args{op_user},
                            op_pass   => $args{op_pass}
                            );
}


=item db_setup_for_get_counts

=over 2

Sets up the ac_processing accounting for the get_counts test.
Cleans up ac_processing_accounting in case something got left over.
Inserts some rows of Collections and Main Driver AF's an AE's. 

=back  

=cut

sub db_setup_for_get_counts
{
  my $uscdb = db_connect();
  acpa_cleanup($uscdb);
  
  my $file = $args{MpsLib} . '/test_data/get_counts_inserts.sql';
  my @insert_stmt = get_insert_statements($file);
  
  # insert into ac_processing_accounting
  foreach my $insert_sql (@insert_stmt)
  {
    my $rc = $uscdb->setQuery($insert_sql);
    unless(defined $rc)
    {
      $uscdb->closeConnection();
      croak "Error setting Query\n" . $uscdb->displayError() . "$!\n";
    }

    $rc = $uscdb->runQuery();
    unless(defined $rc)
    {
      $uscdb->closeConnection();
      croak "Error running Query\n" . $uscdb->displayError() . "$!\n";
    }
  }
  $uscdb->commit;
  $uscdb->closeConnection;
}


=item db_setup_for_run_check_nothing_found

=over 2

The setup generated by this subroutine is sufficient for this test.

=back  

=cut

sub db_setup_for_run_check_alarm_condition
{
  db_setup_for_get_counts();
}



=item db_setup_for_run_check_nothing found

=over 2

Sets up the database for the run_check_nothing_found test.

=back  

=cut

sub db_setup_for_run_check_nothing_found
{
  my $uscdb = db_connect();
  acpa_cleanup($uscdb);
  
  my $file = $args{MpsLib} 
           . '/test_data/get_counts_inserts_nothing_found.sql';
  my @insert_stmt = get_insert_statements($file);
  
  # insert into ac_processing_accounting
  foreach my $insert_sql (@insert_stmt)
  {
    my $rc = $uscdb->setQuery($insert_sql);
    unless(defined $rc)
    {
      $uscdb->closeConnection();
      croak "Error setting Query\n" . $uscdb->displayError() . "$!\n";
    }

    $rc = $uscdb->runQuery();
    unless(defined $rc)
    {
      $uscdb->closeConnection();
      croak "Error running Query\n" . $uscdb->displayError() . "$!\n";
    }
  }
  $uscdb->commit;
  $uscdb->closeConnection;
}



=item db_connect

=over 2

Connects to local or specified in arguments database.
Returns an instanciated USCDB object.

=back

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


=item acpa_cleanup

=over 2

Deletes everything from ac_processing_accounting.
If a database handle object is passed in, the module will use this object,
otherwise it will establish a new connection.

=cut

sub acpa_cleanup
{
  my $uscdb = $_[0];
  
  unless(defined $uscdb)
  {
    $uscdb = db_connect();
  }
  
  my $cleanup_sql = 'DELETE FROM AC_PROCESSING_ACCOUNTING';
  my $rc = $uscdb->setQuery($cleanup_sql);
  unless(defined $rc)
  {
    $uscdb->closeConnection();
    croak $uscdb->displayError(), "$!\n";
  }
  
  $uscdb->runQuery();
  unless(defined $rc)
  {
    $uscdb->closeConnection();
    croak $uscdb->displayError(), "$!\n";
  }
  $uscdb->commit();
  
  # disconnect if using your own handle.
  unless(defined $_[0])
  {
    $uscdb->closeConnection();
  }
}


=item get_insert_statements

=over 2

Slurps insert statements into an array.  Returns the array.

=cut

sub get_insert_statements
{
  my $file = shift;
  
  open(FH,$file) or croak "Unable to open $file\n"
                        . 'Make sure you checked it out from PVCS'
                        . 'subproject /ora/vmdb/mps/Monitor/test_data/'
                        . "$!";
  
  # this slurps insert statements into array
  my @insert_stmt = do { local( $/ = ';' ) ; <FH> } ;
  pop @insert_stmt; # remove empty element after the last ';'
  foreach (@insert_stmt)
  {
    chop; # remove the ';' char
    s/(\n\n|\n$)//; # remove blank lines
  }
  
  return @insert_stmt;
}