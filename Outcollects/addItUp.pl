#! /usr/local/bin/perl

$total = 0;

while ($buff = <STDIN>) {
  chomp($buff);

  $total = $total + $buff;
      }

      print "$total\n";

exit(0);
