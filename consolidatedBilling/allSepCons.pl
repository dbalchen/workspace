#! /usr/local/bin/perl

use DBI;

BEGIN {
	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
}

use Spreadsheet::WriteExcel;
use MIME::Lite;

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/consolidatedBilling/';

$ENV{'REC_HOME'} = '/apps/ebi/ebiap1/bin/allSepCons/';

# For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $sqls = NULL;

$sqls{'Mabel MobileSense'} = "
select consolidator,
         destination_desc,
         contact_name,
         contact_phone_number,
         contact_email_address,
         addr_attention,
         addr_primary_ln,
         addr_secondary_ln,
         addr_city,
         addr_state_code,
         addr_zip,
         addr_zip_4,
         xmission_media_type,
         mabel_version,
         b2b_contact_name,
         b2b_mkt_rep_email_addr,
         b2b_contact_phone_number,
         invrpt_dest_code
    from mabel_destination
   where     effective_date <= sysdate
         and (expiration_date is null or expiration_date >= sysdate)
order by consolidator
";

$sqls{'Mabel MobileSense by Consolidator'} = "
select a1.co,
         a1.cc,
         ba_no,
         customer_no,
         account_no,
         a2.dn
    from bl1_document b1,
         (  select t1.account_no ac,
                   t1.consolidator co,
                   t1.cycle_code cc,
                      t1.cycle_run_year
                   || lpad (max (t1.cycle_run_month), 2, '0')
                   || '01'
                       cdate
              from mabel_audit t1
             where     (t1.cycle_run_year =
                            (select max (cycle_run_year)
                               from mabel_audit t2
                              where     t1.consolidator in
                                            (select invrpt_dest_code
                                               from invrpt_destination_mv
                                              where     eff_date <= sysdate
                                                    and (   exp_date is null
                                                         or exp_date >= sysdate))
                                    and t2.consolidator = t1.consolidator
                                    and t2.cycle_run_year >=
                                            (select (  to_number (
                                                           to_char (sysdate,
                                                                    'yyyy'))
                                                     - 1)
                                               from dual)))
                   and t1.account_no is not null
          group by t1.account_no,
                   t1.consolidator,
                   t1.cycle_code,
                   t1.cycle_run_year) a1,
         (  select invrpt_dest_code co, dest_name dn
              from invrpt_destination_mv
             where     eff_date <= sysdate
                   and (exp_date is null or exp_date >= sysdate)
          order by invrpt_dest_code) a2
   where     b1.account_no = a1.ac
         and bill_date >= to_date (a1.cdate, 'yyyymmdd')
         and a2.co = a1.co
group by a1.co,
         a1.cc,
         ba_no,
         customer_no,
         account_no,
         a2.dn
order by a1.co, a1.cc, ba_no";

$sqls{'Invoice Reports'} = "
  select invrpt_dest_code,
         dest_name,
         addr_attention,
         addr_primary_line,
         addr_secondary_line,
         addr_city,
         addr_state,
         addr_zip,
         addr_country,
         contact_name,
         contact_phone,
         contact_email,
         xmission_type,
         deliv_email_addr,
         send_rpt_to_rep,
         b2b_rep_name,
         b2b_rep_phone,
         b2b_rep_email
    from invrpt_destination_mv
   where eff_date <= sysdate and (exp_date is null or exp_date >= sysdate)
order by invrpt_dest_code
";

$sqls{'Invoice Reports by Consolidator'} = "
select a1.co,
         a1.cc,
         ba_no,
         customer_no,
         account_no,
         a2.dn
    from bl1_document b1,
         (  select t1.account_no ac,
                   t1.consolidator co,
                   t1.cycle_code cc,
                      t1.cycle_run_year
                   || lpad (max (t1.cycle_run_month), 2, '0')
                   || '01'
                       cdate
              from mabel_audit t1
             where     (t1.cycle_run_year =
                            (select max (cycle_run_year)
                               from mabel_audit t2
                              where     t1.consolidator in
                                            (select invrpt_dest_code
                                               from invrpt_destination_mv
                                              where     eff_date <= sysdate
                                                    and (   exp_date is null
                                                         or exp_date >= sysdate))
                                    and t2.consolidator = t1.consolidator
                                    and t2.cycle_run_year >=
                                            (select (  to_number (
                                                           to_char (sysdate,
                                                                    'yyyy'))
                                                     - 1)
                                               from dual)))
                   and t1.account_no is not null
          group by t1.account_no,
                   t1.consolidator,
                   t1.cycle_code,
                   t1.cycle_run_year) a1,
         (  select invrpt_dest_code co, dest_name dn
              from invrpt_destination_mv
             where     eff_date <= sysdate
                   and (exp_date is null or exp_date >= sysdate)
          order by invrpt_dest_code) a2
   where     b1.account_no = a1.ac
         and bill_date >= to_date (a1.cdate, 'yyyymmdd')
         and a2.co = a1.co
group by a1.co,
         a1.cc,
         ba_no,
         customer_no,
         account_no,
         a2.dn
order by a1.co, a1.cc, ba_no
";

my %headings = NULL;

$headings{'Mabel MobileSense'} = [
	"Consolidator",             "Destination_Desc",
	"Contact_Name",             "Contact_Phone_Number",
	"Contact_Email_Address",    "Addr_Attention",
	"Addr_Primary_Ln",          "Addr_Secondary_Ln",
	"Addr_City",                "Addr_State_Code",
	"Addr_Zip",                 "Addr_Zip_4",
	"Xmission_Media_Type",      "Mabel_Version",
	"B2b_Contact_Name",         "B2b_Mkt_Rep_Email_Addr",
	"B2b_Contact_Phone_Number", "Invrpt_Dest_Code"
];

$headings{'Invoice Reports'} = [
	"Invrpt_Dest_Code",    "Dest_Name",
	"Addr_Attention",      "Addr_Primary_Line",
	"Addr_Secondary_Line", "Addr_City",
	"Addr_State",          "Addr_Zip",
	"Addr_Country",        "Contact_Name",
	"Contact_Phone",       "Contact_Email",
	"Xmission_Type",       "Deliv_Email_Addr",
	"Send_Rpt_To_Rep",     "B2b_Rep_Name",
	"B2b_Rep_Phone",       "B2b_Rep_Email"
];

$headings{'Consolidator Reports'} = [
	"Consolidator",
	"Cycle Code",
	"BAN",
	"Customer Number",
	"Account Number",
	"Destination"
];

my $conn = getBODSPRD();

my ( $day, $month, $year ) = (localtime)[ 3, 4, 5 ];
my $timeStamp = 1900 + $year . pad( $month + 1, '0', 2 ) . pad( $day, '0', 2 );

$excel_file = "allSapCons_$timeStamp.xls";

$workbook = Spreadsheet::WriteExcel->new($excel_file);

retrieveFormat(
	$conn,
	$sqls{'Mabel MobileSense'},
	$headings{'Mabel MobileSense'},
	"Mabel MobileSense"
);

retrieveFormat(
	$conn,
	$sqls{'Mabel MobileSense by Consolidator'},
	$headings{'Consolidator Reports'},
	"MobileSense by Consolidator"
);
retrieveFormat(
	$conn,
	$sqls{'Invoice Reports'},
	$headings{'Invoice Reports'},
	"Invoice Reports"
);

retrieveFormat(
	$conn,
	$sqls{'Invoice Reports by Consolidator'},
	$headings{'Consolidator Reports'},
	"Invoice by Consolidator"
);

$conn->disconnect();
$workbook->close;

my $msg   = '';
#my @email = ('david.balchen@uscellular.com','Janeen.Podgorski@uscellular.com','BusinessBillingSup@uscellular.com');
my @email = ('david.balchen@uscellular.com');
foreach my $too (@email) {
	print $msg;
	sendMsg( $too, $msg );
}

exit(0);

sub retrieveFormat {
	my ( $conn, $sql, $headings, $sheetname ) = @_;
	my $worksheet = $workbook->add_worksheet($sheetname);
	my $bold = $workbook->add_format( bold => 1 );
	$worksheet->write( 'A1', $headings, $bold );

	my $sth = $conn->prepare($sql);
	$sth->execute() or sendErr();

	my $cntrow = 1;

	while ( my @rows = $sth->fetchrow_array() ) {

		my @fix_cols = grep( s/\s*$//g, @rows );
		$worksheet->write_row( $cntrow, 0, \@fix_cols );
		$cntrow = 1 + $cntrow;
	}
}

sub sendMsg {

	my ( $to, $message ) = @_;
	my $mime_type = 'multipart/mixed';
	my $from      = "david.balchen\@uscellular.com";
	my $subject   = "All Sep Cons";
	my $cc        = '';

	if ( length($message) > 3 ) {
		$subject = $subject . " (Investigation Required)";
	}

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

sub pad {

	my ( $padString, $padwith, $length ) = @_;

	while ( length($padString) < $length ) {
		$padString = $padwith . $padString;
	}

	return $padString;

}

sub getBODSPRD {

	my $dbPwd = "BODS_SVC_BILLINGOPS";
	my 	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	#my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "5000#Reptar" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

