#! /usr/contrib/bin/perl

chomp(@ARGV);

$email = $ARGV[0];
$pager = $ARGV[1];
$msgtxt = $ARGV[2];
$title = $ARGV[3];

$hh = '/usr/bin/mailx -s "'.$title.'"'." $email < $msgtxt";
system("$hh");

$hh = "/usr/bin/mailx $pager < $msgtxt";
system("$hh");

exit(0);

