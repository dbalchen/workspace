#! /usr/local/bin/perl

$ENV{'REC_HOME'} = '/home/dbalchen/workspace/volteRoaming/src/bin';

#$ENV{'REC_HOME'} = '/pkgbl02/inf/aimsys/prdwrk2/eps/monitors/roaminRecon/';

chdir("$ENV{'REC_HOME'}");



my $hh = "cat IncollectDCH_data* | tr -d '".'\0'."'| grep '^[0-9]' | sort -u | dos2unix > IncollectDCH_data.csv.all.tmp";
system("$hh");

$hh = "cat IncollectDCH_voice* | tr -d '".'\0'."' | grep '^[0-9]' | sort -u | dos2unix > IncollectDCH_voice.csv.all.tmp";
system("$hh");

$hh = "cat OutcollectDCH_voice* | tr -d '".'\0'."' | grep '^[0-9]' | sort -u | dos2unix > OutcollectDCH_voice.csv.all.tmp";
system("$hh");

$hh =  "cat IncollectDCH_GSM* | tr -d '".'\0'."' | grep '^[0-9]' | sort -u | dos2unix > IncollectDCH_GSM.csv.all.tmp";
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
exit(0);


