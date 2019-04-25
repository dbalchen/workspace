#! /usr/bin/perl

my $hh = "find . -name " . '"*.htm*"' . " -print -follow |";

if ( !open( FINDLIST, "$hh" ) ) {
	errorExit("Cannot create FINDLIST: $!\n");
}

while ( my $filename = <FINDLIST> ) {
	chomp($filename);

	my $htmlfile = ( split( /\//, $filename ) )[-1];
	
	my $dir = substr($filename,0,length($filename) - length($htmlfile));
	
	$hh = "html2text $filename > ".$dir.$htmlfile.'.txt';
	
	print "$hh\n";
	
	system($hh);

}

close(FINDLIST);
exit(0);

