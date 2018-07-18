#! /usr/local/bin/perl

open(STDIN,"gunzip -c SMADI_FUFF_ID000000_T20140519124600.DAT.gz |");

while($buff = <STDIN>)
{
    chomp($buff);

    @uff = split(/\|/, $buff);

    $cd = $uff[30];
    $sf = $uff[28];
    $et = $uff[17];

    if ($cd == 1 && index($sf,"VM") == -1 && $et eq 'L-L')
      {
        print "$buff\n";
}

}

exit(0);
