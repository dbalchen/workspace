#! /usr/local/bin/perl

my $email = 'david.balchen@uscellular.com';

my $home = '/home/dbalchen/workspace/usageUtlities/'; #chdir($ENV{'UTLITIES_HOME'});

chdir("$home");

my $date = `date '+%Y%m%d'`;
chomp($date);

my $filename = "$home/work/LongVoLTEDurations_" . $date . '.xlsx';

my $subject = "Long Duration Pre-Paid VoLTE calls for $date";

my $salutation =
"The attached document contains a list pre-paid VoLTE calls that have a duration of more than an hour.\n";

my $hh = " $home/lib/exe/printSQL.pl  $home/lib/sql/find_long_VoLTE.sql";

my @output = `$hh`;

if ( @output < 1 ) {

	exit(0);
}

my $heading =
"CUSTOMER_ID\tRESOURCE_VALUE\tSYS_CREATION_DATE\tL9_SYSTEM_SERVICE\tL3_DURATION\tL3_ROUNDED_UNIT\tL3_CHARGE_AMOUNT\tL3_CALL_DIRECTION\tL9_ROAMING_IND\tL9_CALLING_NUMBER\tL9_CALLED_NUMBER\tSERVICE_FILTER\tL9_DIALED_DIGITS\tL9_TOLL_DURATION\tL9_BALANCE_AMOUNT\tL9_DAILY_SURCHARGE_IND\tL3_OFFER_ID\tSOC_NAME\n";

my $sheetOut = "";

my @out1 = grep { /unl/i } @output;

if ( @out1 > 0 ) {
	$sheetOut = $heading . join( '', @out1 );
}

my @out2 = grep { !/unl/i } @output;

if ( @out2 > 0 ) {
	$sheetOut = $sheetOut . "::" . $heading . join( '', @out2 );
}

$hh =
    'lib/exe/toSheet.py -t "Unlimited::Limited" -i "'
  . $sheetOut . '"'
  . " -o $filename";

system($hh);

$hh =
    'printf "'
  . $salutation
  . '" | lib/exe/toEmail.py -e "'
  . $email
  . '" -sb "'
  . $subject . '"' . ' -a "'
  . $filename . '"'.' -s "Hello\n"';

system($hh);

print "$date Program Finished\n";

exit(0);
