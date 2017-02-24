#! /usr/bin/perl

my $file       = $ARGV[0];
my $dch_file   = $ARGV[1];

my $total_records = 0;
my $total_charge = 0;
my $total_volume = 0;

my %serSidSeq = {};

open(DCH,"< $dch_file") || exit(1);

while(my $buff = <DCH>)
{
    chomp($buff);
    my @vec = split(/\t/,$buff);
    my $key = $vec[2].$vec[3].$vec[4];
    $serSidSeq{$key} = $vec[7]."\t".$vec[8]."\t".$vec[9];
}

my $hh =  "cat $file " . '|'. " grep '^98' " . '|' . " sort -u " . '|';

open( PIPE, $hh ) or exit(1);

while ( my $buff = <PIPE> ) {
    chomp($buff);

#    my $mykey = substr( $buff, 16, 5 ).substr( $buff, 11, 5 ) ."0".substr( $buff, 8,  3 );
    my $mykey = substr( $buff, 11, 5 ).substr( $buff, 16, 5 ) ."0".substr( $buff, 8,  3 );

    my $result = $serSidSeq{$mykey};

    my($records,$charges,$volumes) = split(/\t/,$result);

    $total_records = $total_records + $records;
    $total_charges = $total_charges + $charges;
    $total_volume = $total_volume + $volumes;


}

print "$total_records\n";
print "$total_charges\n";
print "$total_volume\n";

close(PIPE);

exit(0);
