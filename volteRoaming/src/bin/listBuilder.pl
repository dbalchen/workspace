#! /usr/local/bin/perl

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';
#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon2/';

chdir("$ENV{'REC_HOME'}");

#my $hh = "cat IncollectDCH_data* | tr -d '".'\0'."'| grep '^[0-9]' | dos2unix | sort -u > IncollectDCH_data.csv.all.tmp";
#system("$hh");
#
#$hh = "cat IncollectDCH_voice* | tr -d '".'\0'."' | grep '^[0-9]' | dos2unix | sort -u  > IncollectDCH_voice.csv.all.tmp";
#system("$hh");
#
#$hh = "cat OutcollectDCH_voice* | tr -d '".'\0'."' | grep '^[0-9]' | dos2unix| sort -u  > OutcollectDCH_voice.csv.all.tmp";
#system("$hh");
#
#$hh =  "cat IncollectDCH_GSM* | tr -d '".'\0'."' | grep '^[0-9]' | dos2unix | sort -u  > IncollectDCH_GSM.csv.all.tmp";
#system("$hh");
#
#$hh = "mv *DCH*_2*csv OldDCH";
#system("$hh");
#
#$hh = "mv IncollectDCH_data.csv.all.tmp IncollectDCH_data.csv.all";
#system("$hh");
#$hh = "mv IncollectDCH_voice.csv.all.tmp IncollectDCH_voice.csv.all";
#system("$hh");
#$hh = "mv OutcollectDCH_voice.csv.all.tmp OutcollectDCH_voice.csv.all";
#system("$hh");
#$hh = "mv IncollectDCH_GSM.csv.all.tmp IncollectDCH_GSM.csv.all";
#system("$hh");

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

$hh = "cat *4G_Outcollect*csv | cut -f1 | sort -u";
my @files = `$hh`;

open(TNS, "> tnsOutcollect.csv.tmp") || errorExit("could not open tnsOutcollect file\n");

foreach my $file (@files)
{
	$hh = "grep '^".$file."' *4G_Outcollect*csv | cut -f 2,5,8,9";
	
	my @info = `$hh`;
	
	my($total,$bytes,$cost,$date) = 0;
	
	for(my $a = 0; $a < @info; $a = $a +1)
	{
		my @subinfo = split(/\t/,$info[$a]);
		
		$total = $total + $subinfo[0];
		$bytes = $bytes + $subinfo[1];
		$cost = $cost +  $subinfo[2];
		$date = $subinfo[3];
	}
	
	my @fixdate = split(/\//,$date);
	$date = $fixdate[0].'-'.$month{$fixdate[1]}.'-'.$fixdate[2];
	
	print TNS "$file\t\t\t\t$date\t\t\t$bytes\t$total\t\t\t\t$cost\t\t\t\t\n"
	
}

close(TNS);

exit(0);


