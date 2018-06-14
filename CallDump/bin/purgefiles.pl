#! /usr/bin/perl
use POSIX;
use Cwd;
use File::stat;
use lib "./MIME";
use MIME::Lite;
my ($p,$p,$p,$day,$month,$year,$p,$p,$p) = localtime(time - 31881600);
my $purgeDate = ($year+1900).padZero($month + 1).padZero($day + 1);
my $fileDir   = $ARGV[0];
my $dateStamp = strftime( "%m%d%Y%H%M%S", localtime );
my $wtxtdate  = strftime( "%Y%m%d", localtime( time() - (86400 * 40) ) );

chdir("../log");
$LOGPWD = `pwd`;
chomp($LOGPWD);

my $logfile = $LOGPWD . "/PURGE_JOB_" . $dateStamp . ".txt";

open( LOG, "> $logfile" )
  || errorExit("Could not open log file.... CallDump Failed!!!!");

chdir("../config");
my @zipPatterns = `cat compressPattern.ini`;
chomp(@zipPatterns);
my $zipPat = join( '', @zipPatterns );
$zipPat =~ s/  *//g;

chdir($fileDir);

$hh = "find . -name " . '"*"' . " -follow -print 2>> $logfile | egrep 'DAT|DROP|BILLEABLE' | grep -v old |";

if ( !open( RMLIST, "$hh" ) ) {
	print LOG "Cannot create RMLIST: \n";
	exit(2);
}

my $FilesRemoved = 0;
my $FilesZipped  = 0;

while ( $rmfile = <RMLIST> ) {

	chomp($rmfile);

	$rmfile =~ s/\.\///g;

	my $file = ( split( /\//, $rmfile ) )[-1];

	my $type = ( split( /_/, $file ) )[1];

	my $date = ( split( /_/, $file ) )[-1];

	if(index( $rmfile, "mft_to_stage" ) >= 0 )
        {
	 $date = substr( $date, 0, 8 );
        }
        else {
         $date = substr( $date, 1, 8 );
        }

	my $delfile = "$fileDir/" . $rmfile;

#	print "Infile = $file\n";

	# Remove the file.....
	if (   ( $date < $purgeDate )
		|| ( ( index( $rmfile, "mft_to_stage" ) >= 0 ) && ( $date < $wtxtdate ) ) )
	{
		print LOG "Removing the following file: $delfile" . "\n";
		$FilesRemoved++;
		$rh = "rm $delfile";
		print "Command = $rh\n";
		system($rh);
	}
	elsif ( index( $zipPat, $type ) >= 0 && index( $file, "gz" ) == -1 ) {
		print LOG "Zipped the following file: $delfile" . "\n";
		$FilesZipped++;
		$rh = "gzip  $delfile";
		print "Command = $rh\n";
		system($rh);
	}
}
close(RMLIST);

print LOG "Total number of files removed $FilesRemoved \n";
print LOG "Total number of files zipped $FilesZipped \n";
close(LOG) or die "Could not close the log\n";

emailLog( $logfile, "ISBillingOperations\@uscellular.com" );

exit(0);

sub emailLog {
	my ( $logFile, $email ) = @_;

	# Email basics.
	my $shortX    = ( split( /\//, $logFile ) )[-1];
	my $subject   = "$shortX";
	my $mime_type = 'multipart/mixed';
	my $message   = "Attached Logfile from the CallDump purge job.\n";

	# Initialize the email object.
	my $mime_msg = MIME::Lite->new(
		To      => $email,
		Subject => $subject,
		Type    => $mime_type
	) or die "Error creating " . "MIME body: $!\n";

	# Add a text message to the email body.
	$mime_msg->attach(
		Type => 'TEXT',
		Data => $message
	) or die "Error adding text message: $!\n";

	# Attach the test file.
	$mime_msg->attach(
		Type     => 'application/octet-stream',
		Encoding => 'base64',
		Path     => $logFile,
		Filename => $logFile
	) or die "Error attaching file: $!\n";

	# Send the email.
	$mime_msg->send();
}


sub padZero {

    my $pd = shift;

    if (length($pd) < 2)
    {
	$pd = "0".$pd;
    }

    return $pd;
}
