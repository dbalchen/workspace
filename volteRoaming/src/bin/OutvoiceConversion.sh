source /apps/ebi/ebiap1/.bashrc
cd /apps/ebi/ebiap1/bin/roamRecon/

perl -e '
my $dt = `date +%Y%m%d`;chomp($dt);
my $file = "OutcollectDCH_voice_$dt";
my $hh = "cat ".$file."\*.csv"." | ./OutvoiceStringReplace.sh > tmp$file\.csv";
system("$hh");
$hh = "mv $file\*.csv ./OldDCH";
system("$hh");
$hh = "mv tmp$file.csv $file.csv";
system("$hh");
'

exit 0
