#! /usr/local/bin/perl


open( LOAD, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

while ($buff = <LOAD>) {
  chomp($buff);

  @loadAry = split("\t",$buff);
    
  $key = $loadAry[1].$loadAry[0];
    
  $lookup{$key} = $buff;
}

close(LOAD);


@loadAry = [];
$buff = ''; 

open( STDIN, $ARGV[1] ) || die "cannot open $ARGV[1]\n\n";

while ($buff = <STDIN>) {

  chomp($buff);

  $key = substr($buff,0,10); 
  $key = (split("\t",$buff))[0,1];

  if (exists $lookup{$key}) {

    my @findAll = (split("\t",$lookup{$key}))[2];

    my $count = 0;
    for ( @findAll ) {
      $count += $_;
    }


    my $incount = (split("\t",$buff))[2];

    @findAll = (split("\t",$lookup{$key}))[3];

    my $money = 0;
    for ( @findAll ) {
      $money += $_;
    }

    $money = sprintf("%.2f",$money);

    $money =~ s/\.//g;

    my $inmoney = (split("\t",$buff))[3];

    if ($count != $incount) {

      print "Wrong Count: $lookup{$key}\n";
      print "Count Diff: APRM $count CIBER $incount\n";
      print "Money Diff: APRM $money CIBER $inmoney\n";

    } elsif ($inmoney != $money) {

      print "Bad Money:  $lookup{$key}\n";
      print "Money Diff: APRM $money CIBER $inmoney\n";

    } else {

      print "Found: $lookup{$key}\n";

    }

  } else {
    print "Missing: $buff\n";

  }
}

close(STDIN);

exit(0);
