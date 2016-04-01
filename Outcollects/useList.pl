#! /usr/bin/perl

$hh = "cat uscl_nbc_dat.txt | "; 

open(SH, "$hh") || die "Could not find topSeq\n";

open(BS, "> createSequenceTops.sql") || die "Could not create createSequenceTops.sql\n";

print BS "TRUNCATE TABLE MF1_CIBER_BATCH_SEQ;\n";
print BS "commit;\n";

$prefix = "Insert into MF1_CIBER_BATCH_SEQ (SERVE_SID,HOME_SID,SYS_CREATION_DATE,SYS_UPDATE_DATE,OPERATOR_ID,APPLICATION_ID,DL_SERVICE_CODE,DL_UPDATE_STAMP,SEQ_NO,STATUS_IND,LOCKED_SID) Values (";

$count = 0;

while ($buff = <SH>) {
  chomp($buff); $buff =~ s/  */ /g;

  if ((index($buff,"selected") == -1) and (length($buff) > 2)) {

    $serve = substr($buff,0,5);
    $home = substr($buff,5,5);
    $seq_no = substr($buff,10,3);
    $seq_no =~ s/^00*//g;

    $seq_no = $seq_no - 1;

    if($seq_no == 0)
    {
     $seq_no = 999;
     print " Look Out $serve  $home \n";
    }

    $out = $prefix."'".$serve."',"."'".$home."',"."sysdate,sysdate,'40683','sync','MP019', null,".$seq_no.", 'RD', 0);\n";

    print BS "$out\n";

    $count = $count+1;
    if ($count >= 1000) {
      print BS "commit;\n";
      $count = 0;
    }
  }
}

print BS "commit;\n";
print BS "quit;\n";

close(SH);
close(BS);

exit(0);

