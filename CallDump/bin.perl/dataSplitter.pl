#! /usr/bin/perl

$dir =  $ARGV[0];
$odir = $ARGV[1];
$strm = uc($ARGV[2]);

%marketTotals = ("m01",0,"m02",0,"m03",0,"m04",0,"m05",0,"m06",0,"etc",0);

chomp($dir);chomp($odir);

@minLr = `cat /home/calldmp/CallDumpTest/bin/minLr.db`;

chdir($dir);

$hh = 'ls *'.$strm.'*UFF*DAT';

@files = `$hh`;


chomp(@files);

for ($a = 0; $a < @files; $a = $a + 1) {

  openSplitFiles($files[$a]);

  open(SPLITFILE,"< $files[$a]");

  while ($buff = <SPLITFILE>) {
    chomp($buff);
    @uff = split('\|', $buff);

    if ($uff[0] eq "DR") {

      $msid = guideBy(); #$uff[$mval];

      $market = lc(find_market($msid));

      $marketTotals{$market}++;

      $printTo = $market."Out";

      print($printTo "$buff\n");

    } elsif ($uff[0] eq "HR") {

      foreach my $item (keys(%marketTotals)) {
	$item = $item."Out";
	print($item "$buff\n");
      }

    } else {

      my $sss = $files[$a];
      foreach my $item (keys(%marketTotals)) {

	if ($marketTotals{$item} > 0) {

	  my $tmpf =  $item."Out";
	  $uff[-1] = $marketTotals{$item} + 2;
	  $buff = join '|', @uff;
	  print($tmpf "$buff\n");
	  close($tmpf);

	  if ($item ne "etc") {

	    my $ss = $dir.'/'.$sss.".$item";
	    my $tt = '/'."$item/".$odir.'/'.$files[$a];

            $hh = "mv $ss $tt";
	    print ("$hh\n");
	    system($hh);
	  }

	  $marketTotals{$item} = 0;

	} else {
	  my $tmpf =  $files[$a].".$item";
	  $item = $item."Out";
	  close($item);
	  unlink($tmpf);

	}
      }
      $hh = "gzip $sss";
      print ("$hh\n");
      system($hh);
    }
  }
  close(SPLITFILE);

}

exit(0);

sub openSplitFiles
  {
    my $sfile = shift;

    foreach my $item (keys(%marketTotals)) {
      open("$item"."Out","> $sfile.$item") || die "Could not create output file\n";
    }

  }

sub find_market
  {
    my $fmsid = shift;

    my $byhalf = int(@minLr / 2);
    my $end = @minLr;
    my $start = 0;
    my $found_market = "etc";

    while (!($fmsid >= (split("\t",$minLr[$byhalf]))[0] && $fmsid <= (split("\t",$minLr[$byhalf + 1]))[0]) && !(($end - $start) == 2)) {
      if ($fmsid > (split("\t",$minLr[$byhalf]))[0]) {
	$start =  $byhalf;
      } else {
	$end = $byhalf;
      }
      $byhalf = int(($end - $start) / 2) + $start;
    }

    my $st = (split("\t",$minLr[$byhalf]))[0];
    my $ed = substr($st,0,-4).(split("\t",$minLr[$byhalf]))[1];

    my $st2 = (split("\t",$minLr[$byhalf+1]))[0];
    my $ed2 = substr($st2,0,-4).(split("\t",$minLr[$byhalf + 1]))[1];

    if ($fmsid >= $st && $fmsid <= $ed) {
      $found_market = (split("\t",$minLr[$byhalf]))[-1];
    } elsif ($fmsid >= $st2 && $fmsid <= $ed2) {
      $found_market = (split("\t",$minLr[$byhalf+1]))[-1];
    } else {
      $found_market = "etc";
    }

    chomp($found_market);
    return $found_market;
  }

sub guideBy
{

 my $guideBy = $uff[19];

   if ($strm eq 'MOT' || $strm eq 'ALU' || $strm eq 'PTX' ||$strm eq 'PMG'  || $strm eq "AAA" || $strm eq "QIS" || $strm eq "VALI")
   {
       if ($uff[18] eq 'MO')
       {

	$guideBy = $uff[19];
	if(length($guideBy) == 0)
	{
	  $guideBy = $uff[21];
        }
       }
       elsif ($uff[18] eq 'MT') {

       $guideBy = $uff[23];
        if(length($guideBy) == 0)
        {
          $guideBy = $uff[24];
        } 
       }

   }
	return $guideBy;
}
