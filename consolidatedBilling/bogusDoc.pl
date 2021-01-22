#! /usr/local/bin/perl

use DBI;
use Time::Piece;
use Time::Seconds;

BEGIN {
#	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

# For test only....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $tme   = localtime;
my $today = $tme;

$tme -= ONE_MONTH;
my $fromDate = '01-' . $tme->monname . '-' . $tme->year;

my $conn = getBODSPRD();

my $sql =
"select t1.BA_NO,t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD') Bill_Date,mabel.MABEL_ID,mabel.DESCRIPTION,mabel.CONS,t1.doc_produce_ind,t2.BA_STATUS 
from Bl1_Document t1,  Bl1_Blng_Arrangement t2,
 (select t2.A_NO aact_no,t1.MABEL_ID,t1.Description,t1.MABEL_BILL_FORMAT mabel_format,t2.cons from Add9_Mabel_Ids t1,
(select account_no a_no, CONSOLIDATOR cons, max(sys_creation_date) mydate from Mabel_Audit group by account_no,CONSOLIDATOR) t2
where t2.cons = t1.CONSOLIDATOR) mabel
where t1.bill_date >= '$fromDate' and t1.ACCOUNT_NO = t2.BA_ACCOUNT_NO 
and t1.ACCOUNT_NO = mabel.AACT_NO
group by  t1.BA_NO, t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD'),t1.doc_produce_ind, t2.BA_STATUS,mabel.MABEL_ID,mabel.DESCRIPTION,mabel.CONS 
order by t1.BA_NO ,t1.customer_no,t1.account_no,mabel.MABEL_ID,to_char(t1.bill_date,'YYYYMMDD') desc, t1.doc_produce_ind";

my $heading = [
	"BAN",
	"Customer No.",
	"Account No.",
	"Date This Month",
	"Mabel ID",
	"Company Name",
	"Consolidator",
	"Document Indicator This Month",
	"Account Status This Month",
	"Date Previous",
	"Document Indicator Last month",
	"Account Status Last Month"
];

my $sth = $conn->prepare($sql);
$sth->execute() or sendErr();

my $who  = "";
my $flag = 0;
my @prevRow;

my $excel_file = "BogusDoc_" . $today . '.xls';
my $workbook   = Spreadsheet::WriteExcel->new($excel_file);
my $worksheet  = $workbook->add_worksheet("Bogus ID");
$worksheet->write( 'A1', $heading, $workbook->add_format( bold => 1 ) );
my $cntrow = 1;

while ( my @rows = $sth->fetchrow_array() ) {
	my (
		$ba_no,     $customer_no,     $account_no,
		$bill_date, $mabel_id,        $description,
		$consol,    $doc_produce_ind, $status
	) = grep( s/\s*$//g, @rows );

	if ( ( $who ne $ba_no ) && $doc_produce_ind eq 'N' ) {
		$who     = $ba_no;
		$flag    = 1;
		@prevRow = @rows;
	}
	elsif ( ( $who eq $ba_no ) && $flag == 1 && $doc_produce_ind eq 'Y' ) {

		if ( $status eq "O" ) {

			my $prev = join( "\t", @prevRow );
			my $row = join( "\t", @rows[ 3, 7, 8 ] );

			my @fix_cols = grep( s/\s*$//g, split( "\t", "$prev\t$row" ) );
			$worksheet->write_row( $cntrow, 0, \@fix_cols );
			$cntrow++;
			$flag = 0;

		}
	}
	else {
		$flag = 0;
	}

}

$workbook->close;

my @email = ('david.balchen@uscellular.com');
foreach my $too (@email) {

	sendMsg( $too, "Bogus Doc Report for $today\n", $excel_file );

}
exit(0);

sub getBODSPRD {

	my $dbPwd = "BODS_SVC_BILLINGOPS";       
	my $dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	# my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "5000#Reptar" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub sendMsg() {

	my ( $to, $message, $excel_file ) = @_;
	my $mime_type = 'multipart/mixed';
	my $from      = "david.balchen\@uscellular.com";
	my $subject   = "Bogus Doc Report for $today";
	my $cc        = '';

	$message = "You'll find the report attached to this email\n\n" . $message;

	my $msg = MIME::Lite->new(
		From    => $from,
		To      => $to,
		Cc      => $cc,
		Subject => $subject,
		Type    => $mime_type
	) or die "Error creating " . "MIME body: $!\n";

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
