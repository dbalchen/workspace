#! /usr/local/bin/perl

use strict;

# Need to
use Mail::Box::Manager;

$ENV{MAIL} = '/var/mail/dbalchen';

my $mgr    = Mail::Box::Manager->new;
my $folder = $mgr->open( $ENV{MAIL} );

print "Mail folder $folder contains ", $folder->nrMessages, " messages:\n";

foreach my $message ( $folder->messages ) {
	printf "%3d. %s\n", $message->seqnr, $message->subject;

	$message->printStructure;
	my $m = $message->clone;

	foreach my $part ( $m->parts ) {
		my $attachment = $part->body->dispositionFilename("./");
		print $attachment, "\n";

		open( FH, '>', $attachment )
		  or die "ERROR: cannot write attachment to $attachment: $!\n";

		$part->decoded->print( \*FH );
		close(FH)
		  or die "ERROR: writing to $attachment: $!\n";
	}
}

exit(0);
