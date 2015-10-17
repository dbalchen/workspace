#! /usr/bin/perl


$filename = $ARGV[0];

print "$filename\n";

$duration = getDuration($filename) - 0.02;
#$duration = 1.45;
print "$duration\n";

$hh = "/usr/bin/sox $filename TMP0.wav fade 0.02 $duration 0.02";

print "$hh\n";

system($hh);

$num = 0;

while (($duration) < 12.00) {

$position = $duration - 0.02;
$excess = 0.45 * 1;
$leeway = 0.55 * 1;
$nfile = "TMP".($num+1).".wav";
$hh = "sox TMP$num.wav  TMP$num.wav $nfile splice $position,$excess,$leeway" ;
print "$hh\n";
system($hh);
$duration = getDuration($nfile);

$num = $num + 1;

}


$hh = "mv $filename $filename.old";
print "$hh\n";
system($hh);

$hh = "mv TMP$num.wav $filename";
print "$hh\n";
system($hh);

$hh = 'rm TMP*.wav';
print "$hh\n";
system($hh);

exit(0);

sub getDuration
  {

    my $fn = shift;

    my $fhh = "/usr/bin/soxi -d $fn";

    my $fduration = `$fhh`;

    chomp $fduration;

    my ($cr,$min,$fduration) = split(/:/,$fduration);

    return $fduration + ($min*60);


  }
