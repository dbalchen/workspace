#! /usr/local/bin/perl

my $home = $ENV{'UTLITIES_HOME'};

chdir("$home");

my $date = `date '+%Y%m%d'`;
my $rdate = `date '+%A %B %d %T %Z'`;

chomp($date);

my $email = 'david.balchen@uscellular.com';

my $subject = "Long Duration Pre-Paid VoLTE calls for $rdate";

my $salutation =
"\n\nThe attached document contains a list of pre-paid VoLTE calls that have a duration of more than an hour.\nIf you have questions or concerns please contact David Balchen.\n\nDave\n";

my $hh = "$home/lib/bin/printSQL.pl  $home/lib/sql/find_long_VoLTE.sql";

if ( @ARGV != 0 ) {

	$email = 'USCDLISBillingandRevenueOpsOn-Call@uscellular.com:USCDLISOps-BillingandAROperations@uscellular.com';

	$subject =
"ALERT!!!! Pre-Paid VoLTE Long duration issue for $rdate -- Open an Escalated Remedy Ticket to Amdocs";

	$salutation ="
Some Pre-Paid VoLTE customers have experienced calls of extreme duration(see attached document).

Please open an escalated Remedy ticket to AMDOCS Tier 2 Billing using the Escalation Process flow listed below:

- Create a new Remedy ticket.
  1. Symptom/Request:: Use this email's subject line.
  2. System:: TOPS.
  3. Category:: Back Office.
  4. Product:: TC-TURBO CHARGING.
  5. Team Assigned:: IS Billing Revenue OPS.
  6. Create new ticket.

- In the newly created Remedy ticket
  1. Put into the description box the contents of this email.
  2. Click the escalated button and answer questions.
  3. Save this email and include it as an attachment in attachments field on the attachments/related tickets tab.
  4. Reassign the ticket to Amdocs-Tier 2 Billing
  5. Hit save and proceed to the next step.

- Call Amdocs (217-766-1979) tell them you have an escalated ticket and give them the ticket number.

- Take this email and forward (remember to send the attachment) it to GSSUSCCTier25RA\@amdocs.com.

In addition please contact either David Balchen (608-576-1900) or David Smith (608-212-2911) to inform them that a large duration alert has been issued.";

	$hh = "$home/lib/bin/printSQL.pl  $home/lib/sql/longVoLTEDuration.sql";

}

my $filename = "LongVoLTEDurations_" . $date . '.xlsx';

my @output = `$hh`;

if ( @output < 1 ) {

	exit(0);
}

my $heading =
"CUSTOMER_ID\tRESOURCE_VALUE\tSYS_CREATION_DATE\tL9_SYSTEM_SERVICE\tL3_DURATION\tL3_ROUNDED_UNIT\tL3_CHARGE_AMOUNT\tL3_CALL_DIRECTION\tL9_ROAMING_IND\tL9_CALLING_NUMBER\tL9_CALLED_NUMBER\tSERVICE_FILTER\tL9_DIALED_DIGITS\tL9_TOLL_DURATION\tL9_BALANCE_AMOUNT\tL9_DAILY_SURCHARGE_IND\tL3_OFFER_ID\tSOC_NAME\n";

my $sheetOut = "";

if ( @ARGV != 0 ) {
	$sheetOut = $heading . join( '', @output );
}
else {
	my @out1 = grep { /unl/i } @output;

	if ( @out1 > 0 ) {
		$sheetOut = $heading . join( '', @out1 );
	}

	my @out2 = grep { !/unl/i } @output;

	if ( @out2 > 0 ) {
		$sheetOut = $sheetOut . "::" . $heading . join( '', @out2 );
	}
}

$hh =
    'lib/bin/toSheet.py -t "Unlimited::Limited" -i "'
  . $sheetOut . '"'
  . " -o $home"
  . '/work/'
  . "$filename";

system($hh);

$hh =
    'printf  "'
  . $salutation
  . '" "https://usc.intranet.teldta.com/sites/is/operations/IS_Billing_Ops/_layouts/15/start.aspx#/oneNoteTest/Escalation%20Process%20Flow.aspx"| lib/bin/toEmail.py -e "'
  . $email
  . '" -sb "'
  . $subject . '"' . ' -a '
  . "'$home"
  . '/work/'
  . $filename . "'"
  . ' -s "Dearest OPS,"';

print "$hh";

system($hh);

print "$date Program Finished\n";

exit(0);
