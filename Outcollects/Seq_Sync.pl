#! /usr/bin/perl

$prefix = "Insert into MF1_CIBER_BATCH_SEQ (SERVE_SID,HOME_SID,SYS_CREATION_DATE,SYS_UPDATE_DATE,OPERATOR_ID,APPLICATION_ID,DL_SERVICE_CODE,DL_UPDATE_STAMP,SEQ_NO,STATUS_IND,LOCKED_SID) Values (";

$count = 0;

while($buff = <STDIN>)
{
    chomp($buff);

    ($serve,$home,$seq_no,$serv_code) = split(" ",$buff);

    $out = $prefix."'".$serve."',"."'".$home."',"."sysdate,sysdate,'40683','sync','".$serv_code."', null,".$seq_no.", 'RD', 0);\n";

    print "$out\n";

    $count = $count+1;
    if($count >= 1000)
    {
	print "commit;\n";
	$count = 0;
    }
}

	print "commit;\n";
exit(0);

