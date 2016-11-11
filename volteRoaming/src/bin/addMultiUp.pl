#! /usr/local/bin/perl

my $total = 0;
my $total_cost = 0;
my $total_air = 0;
my $total_toll = 0;
my $total_duration = 0;

while ($buff = <STDIN>) {
  chomp($buff);

  $total = $total + 1;

  $total_cost = substr($buff,0,10) + $total_cost;
  $total_air = substr($buff,10,6) + $total_air;
  $total_toll = substr($buff,16) + $total_toll;
}

$total_cost = $total_cost/100;
$total_duration = ($total_air + $total_toll)/60;


print $total."\t".$total_cost."\t".$total_duration."\n";

exit(0);
