#!/opt/perl5/bin/perl

=head2 USCDB

USCC Wrapper for DBI

=head3 AUTHOR

Craig Stalsberg

Pete Chudykowski

=head3 SYNOPSIS

  use USCDB; 
  
  my $uscdb = USCDB->new();
                                  # parameters optional if testing
                                  # in production-like environment
  my ($sid,$user,$pass) = $uscdb->getDBParmsfromOper($op_job, 
                                                     $op_sid,
                                                     $op_user, 
                                                     $op_pass); 
  unless ($uscdb->openConnection($sid,$user,$pass))
  {
      carp "Could not connect to Oracle!", 
                    $uscdb->getErrorStr(), "\n\n";
  }   

=cut

require 5.004;
require Exporter;

use DBI;
use vars qw(@EXPORT);

package USCDB;


=head2 METHODS

=head3 new()

Constructor.

Creates an instance of USCDB.  Sets the default class variables.

Returns: a reference to the instanciated object.

=cut

sub new
{

    my $obj  = shift;
    my $self = {};
    my $dbh;

    $self->{'_dbh'}     = $dbh;
    $self->{'_errCode'} = 0;
    $self->{'_errStr'}  = "";
    bless($self, $obj);
    return $self;

}

=head3 openConnection()

Creates an Oracle connection handle.

Stores the handle in the _dbh instance variable.

Takes:   

=over 4

=item * sid  -  Instance of DB to open

=item * user - User for connection.

=item * pass - Password for connection.

=back

Returns: 

=over 4

=item * defined - on success

=item * undef   - on faliure

=back

=cut

sub openConnection
{

    my ($self, $sid, $user, $pass) = @_;

    $self->{'_dbh'} =
      DBI->connect("dbi:Oracle:$sid", $user, $pass,
                   {PrintError => 0, AutoCommit => 0});
    if (!$self->{'_dbh'})
    {
        $self->{'_errCode'} = $DBI::err;
        $self->{'_errStr'}  = $DBI::errstr;
        return undef;
    }
    return defined;
}

=head3 setQuery()

Parses the SQL query to run.

Takes:   

=over

=item * sql  - SQL query string

=back

Returns: 

=over 4

=item * defined - on success

=item * undef   - on faliure

=back

=cut

sub setQuery
{

    my ($self, $sql) = @_;

    my $dbh = $self->{'_dbh'};
    if (!defined $dbh)
    {
        $self->{'_errCode'} = $DBI::err;
        $self->{'_errStr'}  = $DBI::errstr;
        return undef;
    }

    my $sth = $dbh->prepare($sql);
    if (!defined $sth)
    {
        $self->{'_errCode'} = $DBI::err;
        $self->{'_errStr'}  = $DBI::errstr;
        return undef;
    }
    $self->{'_sth'} = $sth;

    return defined;
}

=head3 runQuery()

Executes set SQL query.

Takes:   

=over

=item * bind_vars - optional array of bind variables

=back

Returns: 

=over 4

=item * defined - on success

=item * undef   - on faliure

=back

=cut

sub runQuery
{

    my ($self, @bind_vars) = @_;

    my $sth = $self->{'_sth'};
    $rc = $sth->execute(@bind_vars);
    if (!defined $rc)
    {
        $self->{'_errCode'} = $DBI::errcode;
        $self->{'_errStr'}  = $DBI::errstr;
        return undef;
    }
    return defined;
}


=head3 fetchResults()

Fetches next row of an executed query.

Returns: 

=over 4

=item * defined - on success

=item * undef   - on faliure

=back

=cut

sub fetchResults
{

    $self = shift;
    my $sth = $self->{'_sth'};
    if (!defined $sth)
    {
        $self->{'_errCode'} = $DBI::err;
        $self->{'_errStr'}  = $DBI::errstr;
        return undef;
    }
    (@arr) = $sth->fetchrow_array();
    return @arr;
}


=head3 selectFetchRow()

Parses, Executes and fetches a single row of 
a query to run.

Takes:   

=over

=item * sql  - SQL query string

=back

Returns: 

=over 4

=item * @arr - returned row array

=item * undef   - on faliure

=back

=cut

sub selectFetchRow
{
    my ($self, $sql) = @_;

    my $dbh = $self->{'_dbh'};
    if (!defined $dbh)
    {
        $self->{'_errCode'} = $DBI::err;
        $self->{'_errStr'}  = $DBI::errstr;
        return undef;
    }

    (@arr) = $dbh->selectrow_array($sql);
    if (@arr == 0)
    {
        $self->{'_errCode'} = $DBI::err;
        $self->{'_errStr'}  = $DBI::errstr;
        return undef;
    }
    return @arr;
}


=head3 fetchHash()

Fetches next row of an executed query.

Returns: 

=over 4

=item * HashRef - reference to a row hash.  

The keys are column names, the values are returned values.

=item * undef   - on faliure

=back

=cut

sub fetchHash
{

    $self = shift;
    my $sth = $self->{'_sth'};
    if (!defined $sth)
    {
        $self->{'_errCode'} = $DBI::err;
        $self->{'_errStr'}  = $DBI::errstr;
    }
    $HashRef = $sth->fetchrow_hashref();
    return $HashRef;
}


=head3 getErrorCode()

Retrieves a numeric error code.

Returns: 

=over 4

=item * string - Error Code  

=back 

=cut

sub getErrorCode
{
    $self = shift;
    return $self->{'_errCode'};
}


=head3 getErrorStr()

Retrieves a string error message.

Returns: 

=over 4

=item * string - Error Description  

=back 

=cut

sub getErrorStr
{
    $self = shift;
    return $self->{'_errStr'};
}


=head3 displayError()

Prints the Oracle Error Code and Message to STDERR.

=cut

sub displayError
{

    my $self = shift;
    print STDERR "\nError Code: ", $DBI::err , " : " , $DBI::errstr , "\n";

}


=head3 closeConnection()

Terminates Oracle connection.  Destroys Database Handle.

Returns: 

=over 4

=item * defined - on success

=item * undef   - on faliure

=back

=cut

sub closeConnection
{

    $self = shift;

    my $dbh = $self->{'_dbh'};
    my $sth = $self->{'_sth'};

    if (defined $sth)
    {
        $sth->finish();
    }
    $dbh->disconnect();

}


=head3 DESTROY()

Destroys the object blessed into $self.

=cut

sub DESTROY
{

    my $self = shift;
    my $dbh;
    my $sth;

    if (defined($self->{'_sth'}))
    {
        $sth = $self->{'_sth'};
        $sth->finish();
        undef $self->{'_sth'};
    }
    if (defined($self->{'_dbh'}))
    {
        $dbh = $self->{'_dbh'};
        $dbh->disconnect();
        undef $self->{'_dbh'};
    }
    undef $self->{'_errCode'};
    undef $self->{'_errStr'};

}


=head3 commit()

Makes permanent changes made to the database.

Returns: 

=over 4

=item * defined - on success

=item * undef   - on faliure

=back

=cut

sub commit
{

    my $self = shift;

    my $dbh = $self->{'_dbh'};
    my $rc = $dbh->commit() || warn "error: " . $dbh->errstr;
    return $rc;
}


=head3 rollback()

Rolls back changes up to the most recent commit.

Returns: 

=over 4

=item * defined - on success

=item * undef   - on faliure

=back

=cut

sub rollback
{

    my $self = shift;

    my $dbh = $self->{'_dbh'};
    my $rc = $dbh->rollback() || warn "error: " . $dbh->errstr;    
    return $rc;
}


=head3 quote()

Quotes a string literal for use as a literal value 
in an SQL statement.

Takes:

=over 4

=item * lit - string literal

=item * dt  - data type

=back

Returns: 

=over 4

=item * quoted string

=back

=cut

sub quote
{

    my $self = shift;
    my ($lit, $dt) = @_;

    my $dbh = $self->{'_dbh'};
    return $dbh->quote($lit, $dt) || warn "error: " . $dbh->errstr;
}


=head3 getDBHandle()

Accessor Method.

Returns:

=over 4

=item * Database Handle reference

=back

=cut

sub getDBHandle
{
    $self = shift;
    return $self->{'_dbh'};
}


=head3 dumpResults()

Dumps the entire result set of an executed 
statement handle.

Takes:  

=over 4

=item * maxlen - max field length 

(optional, default: 35)

=item * lsep   - line separator 

(optional, default: "\n")

=item * fsep   - field separator 

(optional, default: ", ")

=item * fh     - output handle 

(optional, default: STDOUT)

=back

Returns: 

=over 4

=item * count of rows processed

=back

=cut

sub dumpResults
{
    $self = shift;
    my $maxlen = shift;
    my $lsep   = shift;
    my $fsep   = shift;
    my $fh     = shift;

    return $self->{'_sth'}->dump_results($maxlen, $lsep, $fsep, $fh);
}


=head3 getDBParmsfromOper()

Gets the Oracle Instance, Oracle User and Oracle Password from the 
operational DB.  Use the JOB, Sid, User and Password that are passed
as parameters to this function.  If they are not passed, then we use
the environment variables setup containing these parameters.

Takes: 

=over 4

=item * $job  - operational job 

( optional, default: $ENV{OP_JOB_NAME} )

=item * $sid  - operational database instance schema name 

( optional, default: $ENV{OP_ORA_INST} )


=item * $user - user name 

( optional, default: $ENV{OP_ORA_USER} )

=item * $pass - password

( optional, default: $ENV{OP_ORA_PASS} )

=back

Returns: 

=over 4

=item * $sid  - database instance schema name 

=item * $user - user name 

=item * $pass - password

=back

Or: 

=over 4

=item * undef - on faliure

=cut

sub getDBParmsfromOper()
{

    my $self   = shift;
    my $job    = shift;
    my $opSid  = shift;
    my $opUser = shift;
    my $opPass = shift;

    unless (defined $job)    { $job    = $ENV{OP_JOB_NAME} }
    unless (defined $opSid)  { $opSid  = $ENV{OP_ORA_INST} }
    unless (defined $opUser) { $opUser = $ENV{OP_ORA_USER} }
    unless (defined $opPass) { $opPass = $ENV{OP_ORA_PASS} }

    my $rc = $self->openConnection($opSid, $opUser, $opPass);
    if (!defined $rc)
    {
        displayError();
        print STDERR "\nPerhaps OP_JOB_NAME, OP_ORA_INST, OP_ORA_USER, and ",
          "OP_ORA_PASS are not set for the local operational schema? ";
        return undef;
    }

    my $sql = "select dbc.db_instance, dbc.username, dbc.password ";
    $sql = $sql . "  from jobdbconnect jdbc, dbconfig dbc ";
    $sql = $sql . " where dbc.db_connect_code = jdbc.db_connect_code ";
    $sql = $sql . "   and jdbc.run_mode = 'F' ";
    $sql = $sql . "   and jdbc.job_name = '$job'";

    ($sid, $user, $pass) = $self->selectFetchRow($sql);
    if (!defined $sid)
    {
        displayError();
    }
    $self->closeConnection();
    return ($sid, $user, $pass);
}


=head3 getInfranetDBParmsfromOper()

Much the same as getDBParmsfromOper() but looking for run_mode = 'F'.
Get the Oracle Instance, Oracle User and Oracle Password for the 
Database from the operational DB.  Use the JOB, Sid, User and Password 
that are passed as parameters to this function.  If they are not passed,
then we use the environment variables setup containing these parameters.

Takes: 

=over 4

=item * $job  - operational job 

( optional, default: $ENV{OP_JOB_NAME} )

=item * $sid  - operational database instance schema name 

( optional, default: $ENV{OP_ORA_INST} )

=item * $user - user name 

( optional, default: $ENV{OP_ORA_USER} )

=item * $pass - password

( optional, default: $ENV{OP_ORA_PASS} )

=back

Returns: 

=over 4

=item * $sid  - database instance schema name 

=item * $user - user name 

=item * $pass - password

=back

Or: 

=over 4

=item * undef - on faliure

=cut

sub getInfranetDBParmsfromOper()
{

    my $self   = shift;
    my $job    = shift;
    my $opSid  = shift;
    my $opUser = shift;
    my $opPass = shift;

    unless (defined $job)    { $job    = $ENV{OP_JOB_NAME} }
    unless (defined $opSid)  { $opSid  = $ENV{OP_ORA_INST} }
    unless (defined $opUser) { $opUser = $ENV{OP_ORA_USER} }
    unless (defined $opPass) { $opPass = $ENV{OP_ORA_PASS} }

    my $rc = $self->openConnection($opSid, $opUser, $opPass);
    if (!defined $rc)
    {
        $self->displayError();
        return undef;
    }

    my $sql = "select dbc.db_instance, dbc.username, dbc.password ";
    $sql = $sql . "  from jobdbconnect jdbc, dbconfig dbc ";
    $sql = $sql . " where dbc.db_connect_code = jdbc.db_connect_code ";
    $sql = $sql . "   and jdbc.run_mode = 'I' ";
    $sql = $sql . "   and jdbc.job_name = '$job'";

    ($sid, $user, $pass) = $self->selectFetchRow($sql);
    if (!defined $sid)
    {
        $self->displayError();
        print STDERR "\nPerhaps OP_JOB_NAME, OP_ORA_INST, OP_ORA_USER, and ",
          "OP_ORA_PASS are not set for the local operational ", "schema?";
    }
    $self->closeConnection();
    return ($sid, $user, $pass);
}


=head2 PROGRAMMING STYLE


=head3 SAMPLE CODE

This is just a simple example of how to use the USCDB Class.  
Please note that the first line (#!/opt/perl5/bin/perl)
should be the first line of your file, you cannot have any 
blank lines or anything above it.  Also, it should be 
the first character in the line, no leading spaces.

   #!/opt/perl5/bin/perl

   BEGIN {
      push(@INC, "/tmp_mnt/home/auto/mpsteam/lib");
   }

   # Load USCDB Module
   use USCDB;       
   
   # Create New Instance of Object                                                 
   $dbh = new USCDB();            
   
   # Connect to DB                                    
   $dbh->openConnection("pc1m01","m01appconn","m01appconn");          
   if (!defined $dbh) {
      $dbh->displayError();
   }

   # Select and display the current time
   $sql = "Select to_char(sysdate, 'HH24:MI:SS') from dual";          
   ($sysTime) = $dbh->selectFetchRow($sql);

   print STDOUT "Current System Time: $sysTime\n";

   # Build Query
   $sql = "Select ban, bill_cycle from billing_account";              

   # Set Query
   $rc = $dbh->setQuery($sql);                                        
   if (!defined $rc) {
      $dbh->displayError();
   }

   # Run Query
   $rc = $dbh->runQuery();                                            
   if (!defined $rc) {
      $dbh->displayError();
   }

   # Gather Results of Query
   while ((@results) = $dbh->fetchResults()) {                        
      if (!defined @results) {
         $dbh->displayError();
      }
      # Display customers ban and bill cycle
      print STDOUT "Ban: $results[0] -> Bill Cycle: $results[1]\n";   
   }

   # Close DB Connection
   $dbh->closeConnection();                                           

=head2 Change Log

   $Log: USCDB.pm.sh,v $
   # Revision 19.1.1.1  2004/09/20  18:25:40  ccus
   # created by vercopy from revision 17.1.1.2
   #
   # Revision 19.1  2004/09/20  18:25:39  ccus
   # Initial revision
   #
   # Revision 17.1.1.2  2004/06/08  05:18:52  ccus
   # copied from revision 16.1.1.1
   #
   # Revision 16.1.1.1  2004/04/12  16:30:11  ccus
   # created by vercopy from revision 15.1.1.1
   #
   # Revision 16.1  2004/04/12  16:30:11  ccus
   # Initial revision
   #
   # Revision 15.1.1.1  2004/02/17  03:58:24  ccus
   # created by vercopy from revision 14.1.1.1
   #
   # Revision 15.1  2004/02/17  03:58:24  ccus
   # Initial revision
   #
   # Revision 14.1.1.1  2003/09/15  19:08:11  ccus
   # created by vercopy from revision 13.1.1.1
   #
   # Revision 14.1  2003/09/15  19:08:11  ccus
   # Initial revision
   #
   # Revision 13.1.1.1  2003/08/01  17:10:33  ccus
   # created by vercopy from revision 12.1.1.1
   #
   # Revision 13.1  2003/08/01  17:10:33  ccus
   # Initial revision
   #
   # Revision 12.1.1.1  2003/03/20  23:21:49  ccus
   # created by vercopy from revision 11.1.1.1
   #
   # Revision 12.1  2003/03/20  23:21:49  ccus
   # Initial revision
   #
   # Revision 11.1.1.1  2003/03/11  00:03:29  ccus
   # created by vercopy from revision 10.1.1.2
   #
   # Revision 11.1  2003/03/11  00:03:29  ccus
   # Initial revision
   #
   # Revision 10.1.1.2  2003/01/22  16:02:46  ccus
   # AUTO INSERT, user: Pete Chudykowski message: Add getDBHandle, commit, rollback, quote and dumpResults.
   #
   # Revision 9.1.1.3  2003/01/13  13:00:00  md1pchu1
   # Add additional wrapper methods: getDBHandle,
   # commit, rollback, quote and dumpResults
   # 
   # Revision 9.1.1.2  2002/09/11  17:00:00  md1pchu1
   # Add additional method wrapper for the DBI's fetchHash.
   #
   # Revision 9.1.1.1  2002/06/25  15:45:34  stlcsm
   # changed perl module files to have .sh extension
   #
   # Revision 9.1  2002/06/25  15:45:34  stlcsm
   # Initial revision
   #
   # Revision 8.1.1.1  2002/06/25  15:45:34  stlcsm
   #  Initial CC revision
   #
   # Revision 8.1  2002/06/25  15:45:34  stlcsm
   # Initial revision
   #
   # Revision 7.1.1.1  2002/06/25  15:45:33  stlcsm
   #  Initial CC revision
   #
   # Revision 7.1  2002/06/25  15:45:33  stlcsm
   # Initial revision
   #
   # Revision 6.1.1.1  2002/06/25  15:45:33  stlcsm
   #  Initial CC revision
   #
   # Revision 6.1  2002/06/25  15:45:33  stlcsm
   # Initial revision
   #
   # Revision 5.1.1.1  2002/06/25  15:45:33  stlcsm
   #  Initial CC revision
   #
   # Revision 5.1  2002/06/25  15:45:33  stlcsm
   # Initial revision
   #
   # Revision 4.1.1.1  2002/06/25  15:45:33  stlcsm
   #  Initial CC revision
   #
   # Revision 4.1  2002/06/25  15:45:33  stlcsm
   # Initial revision
   #
   # Revision 3.1.1.1  2002/06/25  15:45:32  stlcsm
   #  Initial CC revision
   #
   # Revision 3.1  2002/06/25  15:45:32  stlcsm
   # Initial revision
   #
   # Revision 2.1.1.1  2002/06/25  15:45:32  stlcsm
   #  Initial CC revision
   #
   # Revision 2.1  2002/06/25  15:45:32  stlcsm
   # Initial revision
   #
   # Revision 1.1.1.1  2002/06/25  15:45:32  stlcsm
   #  Initial CC revision
   #
   # Revision 1.1  2002/06/25  15:45:32  stlcsm
   # Initial revision
   #
   # Revision 14.1.1.1  2002/05/22  01:16:19  ccus
   # created by vercopy from revision 12.1.1.1
   #
   # Revision 14.1  2002/05/22  01:16:19  ccus
   # Initial revision
   #
   # Revision 12.1.1.1  2002/01/25  02:47:51  ccus
   # created by vercopy from revision 11.1.1.6
   #
   # Revision 12.1  2002/01/25  02:47:50  ccus
   # Initial revision
   #
   # Revision 11.1.1.6  2001/11/08  18:09:58  ccus
   # AUTO INSERT, user: Craig Stalsberg message: Fixed a bug in selectFetchRow 
   # where we were not returning undefwhen a query failed. Also, added displayError() 
   # as the defaultmethod to display Oracle Error Information to STDERR.
   #
   # Revision 11.1.1.5  2001/10/05  16:52:31  ccus
   # copied from revision 10.1.1.4
   #
   # Revision 10.1.1.4  2001/09/26  15:11:30  ccus
   # AUTO INSERT, user: Brian Schneider message: Updated to call TlgGnInit_pr with 
   # MPS parameters to the  variable is set correctly.
   #
   # Revision 10.1.1.3  2001/08/01  19:11:48  ccus
   # AUTO INSERT, user: Craig Stalsberg message: Fixed problem with trying to free
   # statement handle that doesnt exist.
   #
   # Revision 10.1.1.2  2001/07/27  18:05:29  ccus
   # AUTO INSERT, user: Craig Stalsberg message: New Perl Modules for 
   # FCC_International_Calls report, I added it to main.list and am checking in 
   # the new files.
   #

=cut

