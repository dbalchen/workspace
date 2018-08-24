#! /usr/local/bin/perl

#$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon2/';
$ENV{'REC_HOME'} = '/apps/ebi/ebiap1/bin/roamRecon/';
#exit(0);

chdir("$ENV{'REC_HOME'}");

my $hh = "";

 $hh = "cat IncollectDCH_data* | tr -d '".'\0'."'| grep '^[0-9]' | dos2unix | sort -u > IncollectDCH_data.csv.all.tmp";
system("$hh");

$hh = "cat IncollectDCH_voice* | tr -d '".'\0'."' | grep '^[0-9]' | dos2unix | sort -u  > IncollectDCH_voice.csv.all.tmp";
system("$hh");

$hh = "cat OutcollectDCH_voice* | tr -d '".'\0'."' | grep '^[0-9]' | dos2unix| sort -u  > OutcollectDCH_voice.csv.all.tmp";
system("$hh");

$hh =  "cat IncollectDCH_GSM* | tr -d '".'\0'."' | grep '^[0-9]' | dos2unix | sort -u  > IncollectDCH_GSM.csv.all.tmp";
system("$hh");

$hh = "mv *DCH*_2*csv OldDCH";
system("$hh");

$hh = "mv IncollectDCH_data.csv.all.tmp IncollectDCH_data.csv.all";
system("$hh");
$hh = "mv IncollectDCH_voice.csv.all.tmp IncollectDCH_voice.csv.all";
system("$hh");
$hh = "mv OutcollectDCH_voice.csv.all.tmp OutcollectDCH_voice.csv.all";
system("$hh");
$hh = "mv IncollectDCH_GSM.csv.all.tmp IncollectDCH_GSM.csv.all";
system("$hh");

my %month = {};
$month{'01'} = 'Jan';
$month{'02'} = 'Feb';
$month{'03'} = 'Mar';
$month{'04'} = 'Apr';
$month{'05'} = 'May';
$month{'06'} = 'Jun';
$month{'07'} = 'Jul';
$month{'08'} = 'Aug';
$month{'09'} = 'Sep';
$month{'10'} = 'Oct';
$month{'11'} = 'Nov';
$month{'12'} = 'Dec';

system("gunzip USAUD_Volume_Report_4G*gz");
system("dos2unix USAUD_Volume_Report_4G*tsv");

# Incollect Processing
system("cat *4G_Incollect*tsv | sort -u > 4G_Incollecttsv.tmp");

$hh = "cat 4G_Incollecttsv.tmp | cut -f1 | sort -u";
my @files = `$hh`;
chomp(@files);

tnsCollect( \@files, "4G_Incollecttsv.tmp", "tnsIncollect.csv.tmp" );

system(
"cat tnsIncollect.csv.all tnsIncollect.csv.tmp | sort -u | grep -v '^FILE' > tnsIncollect.tmp; mv tnsIncollect.tmp tnsIncollect.csv.all"
);

# Outcollect Processing
system("cat *4G_Outcollect*tsv | sort -u > 4G_Outcollecttsv.tmp");

$hh    = "cat 4G_Outcollecttsv.tmp | cut -f1 | sort -u";
@files = `$hh`;
chomp(@files);

tnsCollect( \@files, "4G_Outcollecttsv.tmp", "tnsOutcollect.csv.tmp" );

system(
"cat tnsOutcollect.csv.all tnsOutcollect.csv.tmp | sort -u | grep -v '^FILE' > tnsOutcollect.tmp; mv tnsOutcollect.tmp tnsOutcollect.csv.all"
);

system("rm *tmp; gzip *tsv;mv *tsv.gz OldDCH");

exit(0);

sub tnsCollect {

	my ( $ptr, $file2check, $filename ) = @_;

	my @files = @{$ptr};

	open( TNS, "> $filename" )
	  || errorExit("could not open tnsIncollect file\n");

	foreach my $file (@files) {
		$hh = "grep '^" . $file . "' $file2check| cut -f 2,5,8,9";

		my @info = `$hh`;

		my ( $total, $bytes, $cost, $date ) = 0;

		for ( my $a = 0 ; $a < @info ; $a = $a + 1 ) {
			my @subinfo = split( /\t/, $info[$a] );
			chomp(@subinfo);

			$total = $total + $subinfo[0];
			$bytes = $bytes + $subinfo[1];
			$cost  = $cost + $subinfo[2];
			$date  = $subinfo[3];
		}

		my @fixdate = split( /\//, $date );
		$date =
		    $fixdate[0] . '-'
		  . $month{ $fixdate[1] } . '-'
		  . substr( $fixdate[2], 2 );

		my $printOut =
"$file\t\t\t\t\t$date\t\t\t$bytes\t$total\t\t\t\t\t\t\t\t\t\t\t\t\t\t$cost\n";

		print TNS $printOut;

	}
	close(TNS);
}
