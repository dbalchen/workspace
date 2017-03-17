#! /usr/bin/perl

#### Test Only
$ARGV[0] = '/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/apr/interfaces/output/CIBER_CIBER_20170311122648_3637360_0074.dat.done';
$ARGV[1] = '/home/dbalchen/workspace/volteRoaming/src/bin/OutcollectDCH_voice.2csv';
my $file       = $ARGV[0];
my $dch_file   = $ARGV[1];
my $date       = substr( $file, index( $file, "2017" ), 8 );
my $short_date = substr( $date, 2 );

my $process_date =
    substr( $date, 0, 4 ) . '-'
  . substr( $date, 4, 2 ) . '-'
  . substr( $date, 6, 2 );

$hh =
    "cat $file " . '|'
  . " grep '^98' " . '|'
  . " sort -u " . '|'
  . " grep '^98"
  . $short_date . "' " . '|';

my $fileout = $date . "_differences.csv";

open( OUT, ">>$fileout" ) or exit(1);

open( PIPE, $hh ) or exit(1);

while ( my $buff = <PIPE> ) {
    chomp($buff);
    my $totrecs = substr( $buff, 21, 4 );
    $totrecs =~ s/^0+//g;
    my $totcharges = substr( $buff, 25, 12 ) / 100;
    $totcharges = sprintf( "%.2f", $totcharges );

    my $mygrep =
        substr( $buff, 16, 5 ) . "\t"
      . substr( $buff, 11, 5 ) . "\t" . "0"
      . substr( $buff, 8,  3 ) . "\t"
      . $totrecs . "\t"
      . $totcharges;

    $hh = "grep '$mygrep' $dch_file";

    my @sniff = `$hh`;

    if ( @sniff == 0 ) {
        my $mygrep2 =
            substr( $buff, 16, 5 ) . "\t"
          . substr( $buff, 11, 5 ) . "\t" . "0"
          . substr( $buff, 8,  3 ) . "\t"
          . $totrecs;
        $hh = "grep '$mygrep2' $dch_file ";

        my @sniffsniff = `$hh`;

        if ( @sniffsniff >= 1 ) {

            print OUT "Charge Difference -- USCC: " . "\t" . $mygrep . "\n";
            print OUT "Charge Difference -- Syniverse: " . "\t".$sniffsniff[0];

        }
        elsif ( @sniffsniff == 0 ) {

            my $mygrep3 =
                substr( $buff, 16, 5 ) . "\t"
              . substr( $buff, 11, 5 ) . "\t" . "0"
              . substr( $buff, 8,  3 );
            $hh = "grep '$mygrep3' $dch_file";

            my @sniffsniffsniff = `$hh`;

            if ( @sniffsniffsniff >= 1 ) {

                print OUT "Record Difference - Rejects -- USCC: " . "\t"
                  . $mygrep . "\n";
                print OUT "Record Difference - Rejects -- Syniverse: "."\t"
                  . $sniffsniffsniff[0];

            }
            else {

                print OUT "Block Rejected: " . "\t".$mygrep . "\n";

            }
        }
    }

}

close(OUT);

exit(0);
