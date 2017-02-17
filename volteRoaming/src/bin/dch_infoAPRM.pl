#! /usr/bin/perl
use DBI;

$ARGV[0] = "/home/dbalchen/Desktop/SDIRI_FCIBER";
$ARGV[1] = '20170211';

# # For test only.....
my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
my $ORACLE_SID  = "bodsprd";
$ENV{ORACLE_HOME} = $ORACLE_HOME;
$ENV{ORACLE_SID}  = $ORACLE_SID;
$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

my $dbconn  = getBODSPRD();
my %dchInfo = {};

my $dch_file = '/home/dbalchen/Desktop/IncollectDCH_voice22.csv';


my %serSidSeq = {};

open(DCH,"< $dch_file") || exit(1);

while(my $buff = <DCH>)
{
    chomp($buff);
    my @vec = split(/\t/,$buff);
    my $key = $vec[3].$vec[2].$vec[4];
    $serSidSeq{$key} = $vec[7]."\t".$vec[8]."\t".$vec[9];
}


my $hh =
    " cat $ARGV[0]" . '*'
  . "$ARGV[1]" . '*'
  . " | grep '^98' | sort -u | cut -b 9-21 | sort -u |";

open( PIPE, $hh ) or exit(1);

while ( my $buff = <PIPE> ) {
	chomp($buff);

	my $key = substr( $buff, 3, 5 );

#	$hh =
#	  substr( $buff, 8, 5 ) . "\t" . $key . "\t" . '0' . substr( $buff, 0, 3 );


#	$hh = "cat $dch_file | grep '$hh'";

	$hh = substr( $buff, 8, 5 ) . $key . '0' . substr( $buff, 0, 3 );
	# my $result = `$hh`;
	$result = $serSidSeq{$hh};
	
	chomp($result);

	my ($trecs, $tch, $tdur ) = split( /\t/, $result );

	my ( $trecs2, $tch2, $tdur2 ) = 0;

	my $sql = "select setlmnt_contract_cd from pc9_sid where sids = '$key'";
	my $sth = $dbconn->prepare($sql);
	$sth->execute() or sendErr();

	$key = $sth->fetchrow_array();

	if ( defined( $dchInfo{$key} ) ) {
		( $trecs2, $tdur2, $tch2 ) = split( /\t/, $dchInfo{$key} );

		$trecs2        = $trecs2 + $trecs;
		$tdur2         = $tdur2 + $tdur;
		$tch2          = $tch2 + $tch;
		$dchInfo{$key} = "$trecs2\t$tdur2\t$tch2"

	}
	else {
		$dchInfo{$key} = "$trecs\t$tdur\t$tch";
	}
}

$dbconn->disconnect();

my @keys = keys %dchInfo;

foreach my $key (@keys) {
	print "$key -- $dchInfo{$key}\n";
}

exit(0);

sub getBODSPRD {
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "BooG00900#" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}
