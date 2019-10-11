#! /usr/local/bin/perl

my $header = '<?xml version="1.0" encoding="UTF-8"?>
<uscc:XML_BILLS xmlns:uscc="http://www.uscc.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.uscc.com XML_BILLS.2.xsd" schemaVersion="2.0">';
my $trailer = "</uscc:XML_BILLS>";

my $hh = 'find . -name "dd.*xml*" -print |';

if ( !open( FINDLIST, "$hh" ) ) { errorExit("Cannot create FINDLIST: $!\n"); }

while ( my $file = <FINDLIST> ) {

	chomp($file);

	$hh = "";

	if ( index( $file, ".gz" ) != -1 ) {

		$hh = "gunzip $file;";

		$file = substr( $file, 0, -3 );
	}

	$hh = "$hh"
	  . "mv $file $file.bkup; (echo '$header'; cat $file.bkup; echo '$trailer') > $file";

	system($hh);
}

exit(0);
