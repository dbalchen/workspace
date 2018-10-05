#! /usr/local/bin/perl

use DBI;
use Time::Piece;
use Time::Seconds;

BEGIN {
  #push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );

  #push( @INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5' );
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

# For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $conn  = getBODSPRD();

my $date = $ARGV[0];
my $period = '';

$period = Time::Piece->strptime( $date, "%Y%m%d" );
$period -= ONE_MONTH;


#my $sql = "select BA_NO,customer_no,account_no,doc_produce_ind, to_char('t1.bill_date','YYYYMMDD') from Bl1_Document t1 where bill_date >= '01-MAY-2018' group by  BA_NO,customer_no,account_no,doc_produce_ind, bill_date order by BA_NO,customer_no,account_no,doc_produce_ind, bill_date desc";

my $sql = "select t1.BA_NO,t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD') Bill_Date,mabel.MABEL_ID,mabel.DESCRIPTION,mabel.CONS,t1.doc_produce_ind,t2.BA_STATUS 
from Bl1_Document t1,  Bl1_Blng_Arrangement t2,
 (select t2.A_NO aact_no,t1.MABEL_ID,t1.Description,t1.MABEL_BILL_FORMAT mabel_format,t2.cons from Add9_Mabel_Ids t1,
(select account_no a_no, CONSOLIDATOR cons, max(sys_creation_date) mydate from Mabel_Audit group by account_no,CONSOLIDATOR) t2
where t2.cons = t1.CONSOLIDATOR) mabel
where t1.bill_date >= '01-May-2018' and t1.ACCOUNT_NO = t2.BA_ACCOUNT_NO 
and t1.ACCOUNT_NO = mabel.AACT_NO
group by  t1.BA_NO, t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD'),t1.doc_produce_ind, t2.BA_STATUS,mabel.MABEL_ID,mabel.DESCRIPTION,mabel.CONS 
order by t1.BA_NO ,t1.customer_no,t1.account_no,mabel.MABEL_ID,to_char(t1.bill_date,'YYYYMMDD') desc, t1.doc_produce_ind";

my $sth = $conn->prepare($sql);
$sth->execute() or sendErr();

my $who = "";
my $flag = 0;
my @prevRow;

while ( my @rows = $sth->fetchrow_array() ) {
  my($ba_no,$customer_no,$account_no,$bill_date,$mabel_id,$description,$consol,$doc_produce_ind,$status) = grep( s/\s*$//g, @rows );
  
  if(($who ne $ba_no) && $doc_produce_ind eq 'N') {
  	$who = $ba_no; $flag = 1;
  	@prevRow = @rows;
  }
  elsif(($who eq $ba_no) && $flag ==1 && $doc_produce_ind eq 'Y') {
  	
  	if($status eq "O")
  	{

    my $prev = join("\t", @prevRow);
    my $row = join("\t", @rows);
	print "$prev\t$row\n";
    $flag = 0;
    
 	}
  }
  else {
  	$flag = 0;
  }


}

exit(0);



sub getBODSPRD {
        my $dbPwd = "BODS_SVC_BILLINGOPS";
        my $dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));

  # my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "9000#GooBoo" );
  unless ( defined $dbods ) {
    sendErr();
  }
  return $dbods;
}

sub sendMsg() {

	my ( $to, $message, $excel_file ) = @_;
	my $mime_type = 'multipart/mixed';
	my $from      = "david.balchen\@uscellular.com";
	my $subject   = "APRM Report for $date";
	my $cc        = '';

	$message = "You'll find the report attached to this email\n\n" . $message;

	my $msg = MIME::Lite->new(
		From    => $from,
		To      => $to,
		Cc      => $cc,
		Subject => $subject,
		Type    => $mime_type
	) or die "Error creat
ing " . "MIME body: $!\n";

	$msg->attach(
		Type => 'TEXT',
		Data => $message
	) or die "Error adding text message: $!\n";

	$msg->attach(
		Type     => 'application/octet-stream',
		Encoding => 'base64',
		Path     => $ENV{'REC_HOME'} . $excel_file,
		Filename => $excel_file
	) or die "Error attaching file: $!\n";

	$msg->send();
}
