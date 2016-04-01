#! /usr/bin/perl

open( LOAD, $ARGV[0] ) || die "cannot open $ARGV[0]\n\n";

%lookup = {};

while ($key = <LOAD>) {
  chomp($key);
  $key =~ s/  *//;
  $key =~ s/\t//; 
  $lookup{$key} = "";
}

close(LOAD);


$hh = "cat USCLLBCData20160310.txt | "; 

open(SH, "$hh") || die "Could not find topSeq\n";
open(BS, "> updateSequenceTops.sql") || die "Could not create updateSequenceTops.sql\n";

$count = 0;

while ($buff = <SH>) {

  chomp($buff);

  if ((index($buff,"selected") == -1) and (length($buff) > 2)) {

    $serve = substr($buff,0,5);
    $home = substr($buff,5,5);
    $seq_no = substr($buff,10,3);
    $seq_no =~ s/^00*//g;

    $key = $serve.$home;
    if (exists $lookup{$key}) {
      # $sqlout = "update MF1_CIBER_BATCH_SEQ set SEQ_NO = ".$seq_no." where serve_sid = '".$serve."' and home_sid = '".$home."'; \n";
           $sqlout = "select * from  MF1_CIBER_BATCH_SEQ where SEQ_NO = ".$seq_no." and serve_sid = '".$serve."' and home_sid = '".$home."'; \n";

      print BS "$sqlout";

      $count = $count+1;

      if ($count >= 1000) {
	print BS "commit;\n";
	$count = 0;
      }

    }
  }
}

print BS "commit;\n";

close(SH);
close(BS);

exit(0);

