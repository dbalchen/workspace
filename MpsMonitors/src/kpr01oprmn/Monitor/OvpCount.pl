#!/usr/bin/perl

BEGIN {
   push(@INC, '/home/common/eps/perl_lib/lib/perl5/');
}

use strict;
use warnings;
use diagnostics;
use DBI;

my $path = 0;
my $ovp_files = 0;
my $ovp_recs;
my $ovp_100 = 0;
my $ovp_75 = 0;
my $ovp_disc = 0;
my $ovp_blnc = 0;
my $date = 0;
my $dbods = 0;


my $x = "+\"%D %I:%M:%S%p\"";
chomp $x;
my $time = `date $x`;
chomp($time);

print "{\"time\": \"$time\",";
print '"OVP"'.":[";
&ovpCount;
print "]}\n";

exit(0);


sub ovpCount(){
	$path = "/home/common/eps/ovp/";
	chdir "$path";

    $dbods = getBODSPRD();
	
		
	my $sql2 = qq#select /*+ parallel (16) */ x_notification_type, count(*) from table_x_notification
                    where x_notification_type = 'OVERAGE'
                    and trunc(x_create_date) = trunc(sysdate-1)
                    group by x_notification_type
                    union
                    select /*+ parallel (16) */ x_notification_type, count(*) from table_x_notification
                    where x_notification_type = 'BUCKET'
                    and trunc(x_create_date) = trunc(sysdate-1)
                    group by x_notification_type
                    union
                    select /*+ parallel (16) */ x_notification_type, count(*) from table_x_notification
                    where x_notification_type = 'BALANCE'
                    and trunc(x_create_date) = trunc(sysdate-1)
                    group by x_notification_type
                    union
                    select /*+ parallel (16) */ x_notification_type, count(*) from table_x_notification
                    where x_notification_type = 'DISCLAIMER'
                    and trunc(x_create_date) = trunc(sysdate-1)
                    group by x_notification_type
                    order by 1 desc
				#;
	my $sth2 = $dbods->prepare($sql2);
	$sth2->execute() or sendErr();
	
	while (my @row2 = $sth2->fetchrow_array()){
	
		if ($row2[0] eq "OVERAGE") {
			$ovp_100 = $row2[1];
		}
		
		if ($row2[0] eq "BUCKET") {
			$ovp_75 = $row2[1];
		}
		
		if ($row2[0] eq "DISCLAIMER") {
			$ovp_disc = $row2[1];
		}
		
		if ($row2[0] eq "BALANCE") {
			$ovp_blnc = $row2[1];
		}
	
		$ovp_recs += $row2[1];
	}
	
	print  '{"total_records":"'.$ovp_recs.'","recs_100":"'.$ovp_100.'","recs_75":"'.$ovp_75.'","disclamir":"'.$ovp_disc.'","balance":"'.$ovp_blnc.'"}';
	
	$sth2->finish();
	$dbods->disconnect();
	

}

sub getBODSPRD{
	my $dbPwd = "BODS_SVC_BILLINGOPS";
	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	unless (defined $dbods) {sendErr();}
	return $dbods;
}
