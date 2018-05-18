#! /usr/local/bin/perl

my $total = 0;
my $total_cost = 0;
my $total_air_minutes = 0;
my $total_air_seconds = 0;
my $total_toll = 0;
my $total_duration = 0;

while ($buff = <STDIN>) {
  chomp($buff);

  $total = $total + 1;

  $total_cost = substr($buff,0,10) + $total_cost;
  $total_air_minutes = substr($buff,10,10) + $total_air_minutes;
}

$total_cost = $total_cost/100;
$total_duration =  $total_air_minutes;

print $total."\t".$total_cost."\t".$total_duration."\n";

exit(0);
