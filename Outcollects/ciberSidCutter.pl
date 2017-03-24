#! /usr/local/bin/perl

open( LOAD, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

while ($buff = <LOAD>) {
  chomp($buff);

  @loadAry = split("\t",$buff);
  $key = $loadAry[1].$loadAry[2].checkWidth($loadAry[3],3);
    
  $lookup{$key} = $buff;
}

close(LOAD);

@loadAry = [];
$buff = ''; 

open( STDIN, $ARGV[1] ) || die "cannot open $ARGV[1]\n\n";

 while ($buff = <STDIN>) {

  chomp($buff);
 
  if (substr($buff,0,2) ne '98') {
    next;
  }   

  $key = substr($buff,11,5).substr($buff,16,5).substr($buff,8,3);

  if (exists $lookup{$key}) {
    my $total = (split("\t",$lookup{$key}))[4];

    my $other_total = substr($buff,21,4);

    my $one_lookup = $lookup{$key};

    if ($total == $other_total) {

      my $money = (split("\t",$one_lookup))[5];
      $money = sprintf("%.2f",$money);
      $money =~ s/\.//g;

      my $o_money = substr($buff,25,12);
      if($money == $o_money)
      {
        print "Match Found: $one_lookup\n";
	print "CIBER: $buff\n";
      }

    } else {
      print "Totals different: $one_lookup     Diff: $money\n";
      print "CIBER: $buff\n";
    }

  } else {
    # print "No Match: $buff\n";
  }

}
close(STDIN);

exit;


sub checkWidth {
  my ($cstring,$slen) = @_;

    while (length($cstring) < $slen) {
      $cstring = '0'.$cstring;
    }

  return $cstring;

}
