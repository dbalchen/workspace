#! /usr/bin/perl

$hh = "cat USCL_LBC_DAT.TXT | "; 

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

    # $seq_no = $seq_no - 1;

    # if ($seq_no == 0) {
    #   $seq_no = 999;
    #   print " Look Out $serve  $home \n";
    # }

    $sqlout = "update MF1_CIBER_BATCH_SEQ set SEQ_NO = ".$seq_no." where serve_sid = '".$serve."' and home_sid = '".$home."'; \n";
#     $sqlout = "select * from  MF1_CIBER_BATCH_SEQ where SEQ_NO = ".$seq_no." and serve_sid = '".$serve."' and home_sid = '".$home."'; \n";

    print BS "$sqlout";

    $count = $count+1;

    if ($count >= 1000) {
      print BS "commit;\n";
      $count = 0;
    }

  }

}

print BS "commit;\n";
#print BS "quit;\n";

close(SH);
close(BS);

exit(0);

