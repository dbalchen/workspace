#! /usr/bin/perl

$login = 'sqlplus -s md1dbal1/BooGoo900#@'.$ARGV[0].' > ';
print "$login\n";

#system('sqlplus -s md1dbal1/BooGoo900#@pc1m03 > distinctServeHome @getSeq.sql');
system($login.'distinctServeHome'.$ARGV[0].' @getSeq.sql');

open(SH, "< distinctServeHome".$ARGV[0]) || die "Could not find distinctServeHome\n";
open(BS, "> getSequences".$ARGV[0].'.sql') || die "Could not create getSequences.sql\n";

print BS "set linesize 9999\n";
print BS "set pagesize 0\n";

while ($buff = <SH>) {
  chomp($buff); $buff =~ s/  */ /g;

  if ((index($buff,"SELECTED") == -1) and (length($buff) > 2)) {

    ($serve,$home) = split(/ /,$buff);

    print BS "select decode(max(t1.sequence_no), '999','1',max(t1.sequence_no)+1),'".$serve."','".$home."' from outcol_batch_control t1 where serve_sid = '".$serve."' and home_sid = '".$home."' and sys_creation_Date = ( select max(sys_creation_Date) from outcol_batch_control where serve_sid = '".$serve."' and home_sid = '".$home."');\n";

  }
}
print BS "quit;\n";
close(BS);
close(SH);

#system('sqlplus -s md1dbal1/BooGoo900#@pc1m03 > topSeq @getSequences.sql');
system($login.'topSeq'.$ARGV[0].' @getSequences'.$ARGV[0].'.sql');

$hh = "cat topSeq".$ARGV[0]." | tr -d '".'\011'."' | sed '".'s/  */ /g'."' | grep -v '".'^$'."' |"; 

open(SH, "$hh") || die "Could not find topSeq\n";

open(BS, "> createSequenceTops".$ARGV[0].".sql") || die "Could not create createSequenceTops.sql\n";

print BS "TRUNCATE TABLE MF1_CIBER_BATCH_SEQ;\n";
print BS "commit;\n";

$prefix = "Insert into MF1_CIBER_BATCH_SEQ (SERVE_SID,HOME_SID,SYS_CREATION_DATE,SYS_UPDATE_DATE,OPERATOR_ID,APPLICATION_ID,DL_SERVICE_CODE,DL_UPDATE_STAMP,SEQ_NO,STATUS_IND,LOCKED_SID) Values (";

$count = 0;

while ($buff = <SH>) {
  chomp($buff); $buff =~ s/  */ /g;

  if ((index($buff,"selected") == -1) and (length($buff) > 2)) {

    ($seq_no,$serve,$home) = split(" ",$buff);

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


