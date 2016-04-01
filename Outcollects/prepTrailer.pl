#! /usr/local/bin/perl


open( LOAD, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

$file2Clean =  $ARGV[0];

$hh = " cat $file2Clean | cut -b 1-10 | sort -u |";

open(PIPE,"$hh") || die "cannot open $ARGV[0]\n\n";


while ($key = <PIPE>) {
  chomp($key);

  my $hh = "grep '^".$key."'"." $file2Clean";
  my @findall = `$hh`;
  

  my $count = 0;
  my $money = 0;

  foreach my $nsum ( @findall ) {
    my $tmp = substr($nsum,10,4);
    $count += $tmp;
    my $tmp1 = substr($nsum,14);
    $money += $tmp1;
  }


  $count = pad($count,4);
  $money = pad($money,12);
  print $key.$count.$money."\n";

}

exit(0);

sub pad {

  my ($pstring,$newl) = @_;
  while (length($pstring) < $newl) {
    $pstring = '0'.$pstring;
  }
  return $pstring
}
