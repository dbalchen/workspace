#! /usr/local/bin/perl

my $hostname = `hostname`;

my $email = 'USCDLISBillingandRevenueOpsOn-Call@uscellular.com:USCDLISOps-BillingandAROperations@uscellular.com';

#my $email = 'david.balchen@uscellular.com';

chomp($hostname);

my $rdate = `date '+%A %B %d %T %Z'`;

chomp($rdate);

chdir( $ENV{'UTLITIES_HOME'} );

my $subject =
"ALERT!!!! Shared Memory Error found on $hostname for $rdate -- Open an Escalated Remedy Ticket to Amdocs";

my $salutation = "Dearest OPS,

A Shared Memory Error found on $hostname for $rdate,

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

- Take this email and forward it to GSSUSCCTier25RA\@amdocs.com.

In addition please contact either David Balchen (608-576-1900) or David Smith (608-212-2911) to inform them that a large duration alert has been issued.

===   Log Errors   ===

";

my $date = `date '+%Y%m%d'`;
my $hh =
    'find '
  . $ENV{"HOME"}
  . '/var/usc/projs/apr/log/ES* -name "ADJ1EVENTSRV*_'
  . $date
  . '*.log"'
  . " -print -follow | xargs -i egrep "
  . '"Event is rejected due to missing AVPs required for rating|'
  . 'exceed maximum defined size' . " '5'" . '" {}';

my @output = `$hh`;
#my @output = `ps aux`;

if ( @output > 0 ) {

	$hh =
	    "| $ENV{'UTLITIES_HOME'}/lib/bin/toEmail.py -s " . '"'
	  . $salutation
	  . '" -sb "'
	  . $subject
	  . '" -e "'
	  . $email . '"';

	my $pid = open( WRITEME, "$hh" )
	  or die "Couldn't fork: $!\n";

	print WRITEME "@output";

	close(WRITEME) or die "Couldn't close: $!\n";
}

print "$date Program findBadSids Finished\n";

exit(0);
