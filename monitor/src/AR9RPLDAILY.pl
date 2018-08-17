#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      AR9RPLDAILY
#
# Description: Created for TOPS.  This script gets information about the ac1_control
#		and the status of files in it. 
#
# Author:      David Balchen
#
# Date:        Thursday 
#
#-------------------------------------------------------------------------------


BEGIN {
#   push(@INC, '/pkgbl01/inf/aimsys/prdwrk1/mark/perl_lib/lib/perl5/');
    push(@INC, '/home/dbalchen/workspace/perl_lib/lib/perl5/');
}

#use Schedule::Cron;
use MIME::Lite;
use FileHandle;
use DBI;


# For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";


# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush();

my $pid = "AR9RPLDAILY.pid";

scheduledTask();

#my $cron = new Schedule::Cron(\&scheduledTask,processprefix=>"AR9RPLDAILY");
#my $time = "00 9,16 * * *";
#$cron->add_entry($time);
#$cron->run(detach=>1,pid_file=>"/pkgbl01/inf/aimsys/prdwrk1/eps/$pid");

exit(0);

sub scheduledTask{

my $info = runQuery();

# sendEmail($info);

print "Nothing Found\n";

};
  
sub runQuery {
#   my ($user,$pass,$dbname) = getConnectParams("PRDAPP");
#        my $user = 'md1dbal1';
#        my $pass = 'Reptar500#';
#        my $dbname = 'BODSPRD';

   my $db = getBODSPRD(); # DBI->connect("dbi:Oracle:$dbname",$user,$pass);
   my $message =  "";
   my $sql = qq#select  identifier, nxt_pgm_name, file_status, file_format, file_name, file_path from ac1_control a
                where nxt_pgm_name = 'AR9RPLDAILY'
                and file_status <> 'CO'
                order by sys_creation_date desc#;

  my $sth = $db->prepare($sql);
  $sth->execute();
  my $rows = $sth->fetchall_arrayref();
  my $first = 1;

  foreach my $row (@$rows){
    $message =  $message."@$row[0] \t @$row[1] \t @$row[2] \t @$row[3] \t @$row[4] \t @$row[5]\n";  

  }

  $sth->finish;
  $db->disconnect();

   return $message;
}

sub getBODSPRD {

	 my $dbPwd = "BODS_SVC_BILLINGOPS";
	 my $dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
    # $dbods = DBI->connect( "dbi:Oracle:BODSPRD", "md1dbal1", "9000#GooBoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

#sub getConnectParams{
#  my ($connectCode) = @_;
#
#  my $db = DBI->connect("dbi:Oracle:prdcust","PRDOPRC","con8cst8");
#  $db->{LongReadLen}=1500;
#  my $sql=qq# select conn_params from gn1_connect_params where connect_code=?#;
#  my $sth = $db->prepare($sql);
#  $sth->execute($connectCode);
#  my $params = $sth->fetchrow();
#  my $user = substr($params,index($params,'USER')+13,index($params,'"',index($params,'USER')+13)-index($params,'USER')-13);
#  #print "user: ${user}\n";
#  my $pass= substr($params,index($params,'PASSWORD')+17,index($params,'"',index($params,'PASSWORD')+17)-index($params,'PASSWORD')-17);
#  #print "pass: ${pass}\n";
#  my $instance= substr($params,index($params,'INSTANCE')+17,index($params,'"',index($params,'INSTANCE')+17)-index($params,'INSTANCE')-17);
#  #print "instance: ${instance}\n";
#  $sth->finish();
#  $db->disconnect() if defined($db);
#  return ($user,$pass,$instance);
#}


sub sendEmail {

my $message = shift;

my $subject = 'AR9RPLDAILY Alert';
my @email = ('ISBillingOperations@uscellular.com','david.balchen@uscellular.com','progyan.sharma@uscellular.com');

if ($message eq '') {
$message = "\n\n **** All files are processed, no further action required ****\n\n";
$subject = $subject." --- No Issues To Report";
}
else {
$subject = $subject." --- Please Investigate!!!!!";
$message = $message."\n\n **** Please note that the RPL/MT transactions did not process today, so these transactions will not journal until tomorrow. ****\n\n";
push(@email,'CashAccounting@tdsinc.com');
push(@email,'paula.gross@tdsinc.com');
}

$message = "Identifier \t NXT_PGM_NAME \t File_Status \t File_Format \t File_Name \t File_Path\n\n\n".$message;

my $from_address = "EpsMonitor<\@>";
my $mime_type = 'multipart/mixed';
my $too = '';

foreach $too (@email)
{
#Create the initial text of the message.
my $mime_msg = MIME::Lite->new(From=>$from_address,
                               To=>$too,
                               Subject=>$subject,
                               Type=>$mime_type) or die "Error creating MIME body: $!\n";

$mime_msg->attach(Type=>'TEXT',
                  Data=>$message) or die "Error adding the text message: $!\n";

#$mime_msg->send();
}

}
