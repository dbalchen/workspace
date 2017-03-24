#! /usr/local/bin/perl


open( LOAD, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

$file2Clean =  $ARGV[0];

$hh = " cat $file2Clean | cut -b 12-21 | sort -u |";

open(PIPE,"$hh") || die "cannot open $ARGV[0]\n\n";


while ($key = <PIPE>) {
  chomp($key);

  my $hh = "cat $file2Clean | cut -b 12-37 | grep '^".$key."'";

  my @findall = `$hh`;
  

  my $count = 0;
  my $money = 0;

  foreach my $nsum ( @findall ) {
    my $tmp = substr($nsum,10,4);
    $count += $tmp;
    my $tmp1 = substr($nsum,14);
    $money += $tmp1;
  }


  $count = pad($count,5);
  $money = pad($money,12);

  my $key1 = substr($key,0,5);
  my $key2 = substr($key,5);
  print "$key1\t$key2\t$count\t$money\n";

}

exit(0);

sub pad {

  my ($pstring,$newl) = @_;
  while (length($pstring) < $newl) {
    $pstring = '0'.$pstring;
  }
  return $pstring
}
