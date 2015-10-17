#! /usr/bin/perl

$dir =  $ARGV[0];
$odir = $ARGV[1];
$strm = uc($ARGV[2]);

chomp($dir);chomp($odir);

$hh = "ls $dir".'/*'.$strm.'*UFF*DAT';

@files = `$hh`;

chomp(@files);

for ($a = 0; $a < @files; $a = $a + 1) {

  $hh = "./dataSplitter $dir $files[$a]";
  print "$hh\n";

  system($hh);

  $hh = "ls $files[$a].m0*";
  print "$hh\n";

  @tmpFiles = `$hh`;

  chomp(@tmpFiles);

  for ($b = 0; $b < @tmpFiles; $b++) {
    $market = '/m0'.(split(//,$tmpFiles[$b]))[-1];
    $hh = "mv $tmpFiles[$b] $market/$odir/".(split('/',($files[$a])))[-1];
    system("$hh");
  }

  $hh = "gzip $files[$a]";
  system($hh);

}

exit(0);
