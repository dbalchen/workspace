#! /usr/local/bin/perl
#exit(0);

use Time::Piece;
use Time::Seconds;

BEGIN {
  #	push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
  #	push( @INC, '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/perl_lib/lib/perl5' );
}

# For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

#Test parameters remove when going to production.
$ARGV[0] =
  "SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER,DATA_CIBER,LTE,NLDLT,DISP_RM";

#$ARGV[0] = "SDIRI_FCIBER,SDATACBR_FDATACBR,CIBER_CIBER";
#$ARGV[0] = "SDIRI_FCIBER";
#$ARGV[0] = "SDATACBR_FDATACBR";
#$ARGV[0] = "CIBER_CIBER";
#$ARGV[0] = "DATA_CIBER";
#$ARGV[0] = "LTE,DISP_RM";
#$ARGV[0] = "DISP_RM";
#$ARGV[0] = "LTE";
#$ARGV[0] = "DATA_CIBER,CIBER_CIBER";
#$ARGV[0] = "NLDLT";
#$ARGV[0] = "NLDLT,CIBER_CIBER";

#$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
$ENV{'REC_HOME'} = '/apps/ebi/ebiap1/bin/roamRecon/';

# Setup Initial variables
my $max_process = 10;
my $timeStamp   = $ARGV[1];

#$timeStamp = '20210531';
my $outTimeStamp = Time::Piece->strptime( "$timeStamp", "%Y%m%d" );
$outTimeStamp = $outTimeStamp - ONE_DAY;
$outTimeStamp =
	( $outTimeStamp->year )
  . pad( $outTimeStamp->mon,  '0', 2 )
  . pad( $outTimeStamp->mday, '0', 2 );

my $hh = "$ENV{'REC_HOME'}/dchList.pl $timeStamp";
print "$hh\n";

# system("$hh");

# Setup switch types and their directory location
my %dirs = {};
my %jobs = {};

$msg = "";

$dirs{'SDIRI_FCIBER'} =
  '/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/DIRI';
$dirs{'SDATACBR_FDATACBR'} =
  '/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/up/physical/switch/DATACBR';
$dirs{'CIBER_CIBER'} =
  '/pkgbl02/inf/prdsys/prodwrk2/var/usc/projs/apr/interfaces/output';
$dirs{'DISP_RM'} = '/pkgbl03/inf/prdsys/operaprm/var/usc/DISP';

$jobs{'SDIRI_FCIBER'}      = 'getFileInfo.pl';
$jobs{'SDATACBR_FDATACBR'} = 'getFileInfoData.pl';
$jobs{'CIBER_CIBER'}       = 'getFileInfoOutcollects.pl';
$jobs{'DATA_CIBER'}        = 'getFileInfoOutcollectsData.pl';
$jobs{'LTE'}               = 'getFileInfoLTE.pl';
$jobs{'DISP_RM'}           = 'getFileInfoLTEOut.pl';
$jobs{'NLDLT'}             = 'getFileInfoLTE.pl';

# Get Roaming switches to check
my @switches = split( ',', $ARGV[0] );

# Get Roaming files
foreach my $switch (@switches) {
	my $hh      = "";
	my $maxRecs = 1;
	if ( $switch ne "DATA_CIBER" ) {

		if ( $switch eq "LTE" ) {
			$hh = "$ENV{'REC_HOME'}/listLTE.pl $timeStamp |";
		}
		elsif ( $switch eq "NLDLT" ) {
			$hh = "$ENV{'REC_HOME'}/listLTE.pl $timeStamp NLDLT|";
		}
		elsif ( $switch eq "CIBER_CIBER" || $switch eq "DISP_RM" ) {
			$hh = 'find '
			  . $dirs{$switch}
			  . ' -name "'
			  . $switch . '*'
			  . $outTimeStamp
			  . '*" -print |';
		}
		else {
			$hh = 'find '
			  . $dirs{$switch}
			  . ' -name "'
			  . $switch . '*'
			  . $timeStamp
			  . '*" -print |';
		}

		if ( !open( FINDLIST, "$hh" ) ) {
			errorExit("Cannot create FINDLIST: $!\n");
		}

		while ( my $filename = <FINDLIST> ) {
			chomp($filename);

			$hh = "$ENV{'REC_HOME'}/$jobs{$switch} $filename &";

			# For testing...
			if ( $maxRecs < 50000000000000000000000000 ) {
				system($hh);
				$maxRecs = $maxRecs + 1;
			}

			# Put wait to complete 2 here
			while ( getTotalProc() > $max_process ) { sleep 5; }
		}

		# Put APRM Process Here

	}

	else {

		$hh = "$ENV{'REC_HOME'}/$jobs{$switch} $outTimeStamp &";

		print "$hh\n";

		#system($hh);
	}

	# Put wait to complete here
	while ( getTotalProc() > 0 ) { sleep 5; }

	if ( $maxRecs > 0 ) {

		my $tmpStamp = $timeStamp;

		if ( $switch eq "DISP_RM" or $switch eq "CIBER_CIBER" ) {
			$tmpStamp = $outTimeStamp;
		}

		if (   $switch eq 'LTE'
			|| $switch eq 'DISP_RM'
			|| $switch eq 'NLDLT' )
		{
			$hh = "$ENV{'REC_HOME'}/getFileInfoAprmLTE.pl $switch $tmpStamp &";
		}
		else {
			$hh = "$ENV{'REC_HOME'}/getFileInfoAprm.pl $switch $tmpStamp  &";
		}

		print "$hh\n";

		#		system($hh);
	}

	while ( getTotalProc() > 0 ) { sleep 5; }
}
exit(0);

sub getTotalProc {

	my $shh        = "ps aux | grep getFileInfo | grep -v 'grep' | wc -l";
	my $total_proc = `$shh`;
	chomp $total_proc;
	return $total_proc;
}
