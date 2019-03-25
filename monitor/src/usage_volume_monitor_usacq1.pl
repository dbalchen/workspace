#!/usr/bin/perl

# usage_volume_monitor_usacq1.pl

use strict;
# use warnings;
# use diagnostics;
use DBI;
use Spreadsheet::WriteExcel;
use FileHandle;
use Cwd qw(abs_path);
use MIME::Lite;
# use Schedule::Cron;
use POSIX;
use Carp;

my $archive = 0;
my $chrt;
my $data1;
my $date1;
my $date2;
my $date3;
my $date4;
my $dbods;
my $distroTo = 0;
my $distroCc = 0;
my $dt;
my $fFrmt2;
my $flag3Gpre;
my $flag4Gpre;
my $flagNB;
my $g3;
my $g4;
my $mean;
my $nb;
my $nbOut;
my $outfile1;
my $outfile2;
my $path;
my $paycat;
my $vol1;
my $vol2;
my $vlmnOut;
my $stats;
my $xls;
my $xlsout;
my $y_values;
my $fh = '';
my $log = '';
my $logfile = '';
my %data1;
my @data1; 
my @data2; 
my @data3;
my @dates;
my @paycat;
my @row;
my @stats;
my @xlsin;

&scheduledTask();
# my $cron = new Schedule::Cron(\&scheduledTask,processprefix=>"usage_volume_monitor_usacq1");
# my $time = "0 6 * * *";
# $cron->add_entry($time);
# $cron->run(detach=>1,pid_file=>"/apps/ebi/usacq1/is_bill_ops_mntr/volume/usage_volume_monitor_pid");

sub scheduledTask{
	$| = 1;
	chdir("/apps/ebi/usacq1/is_bill_ops_mntr/volume/");
	$path = abs_path . "/";
	$archive = "$path"."archive/";
	$log = "$path"."log/";	
	$date1 = `date +%Y%m%d%H%M`; chomp $date1;	
	$date2 = `date --date="0 days ago" +"%Y%m%d"`; chomp $date2;
	$date3 = `date --date="1 days ago" +"%Y%m%d"`; chomp $date3;
	$date4 = `date --date="2 days ago" +"%Y%m%d"`; chomp $date4;
	$flag3Gpre = 'N';
	$flag4Gpre = 'N';	
	$flagNB = 'N';
	$distroTo = '';
	# $distroTo = 'david.smith@uscellular.com';
	$distroCc = '';
	
	$logfile = "usage_volume_monitor_usacq1_$date1.log";
	open (my $fh, ">> $logfile") or croak;
	close(STDERR);
	open(STDERR, ">> $logfile") or croak;		
	
	eval {$dbods = getBODSPRD()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	eval {ppAlert()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	eval {sendNB()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	eval {getDate()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	eval {getData()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	eval {$dbods->disconnect()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	eval {sendMsg()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	close(STDERR);
	close($fh);	
	eval {cleanUp()};
	if ($@){
		print $fh "$@\n";
		sendErr();
	}	
}

sub mean(){
	my $total = 0;
	foreach (@stats) {
		$total += $_;
	}
	if ($#stats == 0){
		$#stats = 1;
		my $mean = ceil($total/$#stats);
	} else {
		$mean = ceil($total/$#stats);
	}
	return $mean;
}

sub stdev(){
	if($#stats == 1){
		return 0;
	}	
	my $mean = &mean($stats);					# calculate the mean or average
	my $sqsum = 0;
	for (@stats) {
		$sqsum += (($_-$mean)**2);				# calculate the variance, take each difference, square it...
	} 
	$sqsum /= $#stats;							# average the result
	my $stdev = ceil(sqrt($sqsum)**0.5);		# calculate standard deviation, take the square root of variance
	# print "$extid\t mean: $mean\t stdev: $stdev\n";
	return $stdev;
}

sub getDate{
	my $sql = qq#select trim(to_char(trunc(sysdate - rownum), 'YYYYMMDD'))
					from dual connect by rownum < 90
				#;
	my $sth = $dbods->prepare($sql);
	$sth->execute() or sendErr();
		while (my @row = $sth->fetchrow_array()){
			push((@dates),("$row[0]"));
		}
	$sth->finish();
}

sub num2alpha($i){
    my $num = shift;

    my $alpha = 'A';
    $alpha++ for 2..$num;
	
	my $column = "\$$alpha";
    return $column;
}

sub ppAlert(){
	my $sql1 = qq#select nb from (
					select /*+parallel(t,6) */ to_char(trunc(sys_creation_date), 'mm/dd/yyyy') day, min(sys_creation_date) min_date, 
						to_char(trunc(sys_creation_date, 'hh'), 'hh24') hour, count(*) nb
					from ape1_rated_event t 
					where (cycle_code,cycle_instance, cycle_year) in (select cycle_code, cycle_instance,cycle_year from adj1_cycle_state where sysdate between first_date and close_date ) 
					and l3_payment_category = 'PRE' and event_type_id in (51,69) and trunc(sys_creation_date) = trunc(sysdate)
					group by trunc(sys_creation_date), trunc(sys_creation_date, 'hh')
				  ) where hour='00'
				  order by day
				#;
	my $sth1 = $dbods->prepare($sql1);
	$sth1->execute() or die $DBI::errstr;
	$nb = $sth1->fetchrow_array();	
	$sth1->finish;
	if($nb < 120000){
		$flagNB = 'Y';
		$nbOut .= "NB Count: $nb\n\n";
	} else {
		$flagNB = 'N';
		$nbOut .= "NB Count: $nb\n\n";
	}	
}

sub getData(){
	@paycat = ('POST','PRE');
	
	foreach my $paycat (@paycat){
		if($paycat eq 'POST'){
			my $sql1 = qq#select /*+ parallel (t1,16) */ t1.l3_payment_category, to_char(trunc(t1.sys_creation_date),'YYYYMMDD'), round(sum(t1.l3_volume/1024/1024/1024/1024),8) from ape1_rated_event t1
							where t1.event_type_id = 69
							and t1.l3_payment_category = '$paycat'
							and t1.l9_volume_type = '4G'
							and trunc(t1.sys_creation_date) between trunc(sysdate-90) and trunc(sysdate-1)
							group by t1.l3_payment_category, to_char(trunc(t1.sys_creation_date),'YYYYMMDD')
							order by 2 asc
						#;
			my $sth1 = $dbods->prepare($sql1);
			$sth1->execute() or die $DBI::errstr;
			while (@row = $sth1->fetchrow_array()){
				$vol1 = ceil($row[2]);
				push((@data1),("$row[0],$row[1],$row[2]"));
				my ($key, $val) = ($row[1],$row[2]);
				$data1{$key} .= exists $data1{$key} ? "$val" : $val;
			}		
			$sth1->finish;
			foreach $dt (@dates){ 
				if (!exists $data1{$dt}) {
					push((@data3),("$paycat,$dt,0"));
				} else {
					push((@data3),("$paycat,$dt,$data1{$dt}"));
				}
			}		
			undef @data1;
			undef %data1;
		}
		
		if($paycat eq 'PRE'){
			my $sql1 = qq#select /*+ parallel (t1,16) */ t1.l3_payment_category, to_char(trunc(t1.sys_creation_date),'YYYYMMDD'), round(sum(t1.l3_volume/1024/1024/1024/1024),8) from ape1_rated_event t1
							where t1.event_type_id = 69
							and t1.l3_payment_category = '$paycat'
							and t1.l9_volume_type = '4G'
							and trunc(t1.sys_creation_date) between trunc(sysdate-90) and trunc(sysdate-1)
							group by t1.l3_payment_category, to_char(trunc(t1.sys_creation_date),'YYYYMMDD')
							order by 2 asc
						#;
			my $sth1 = $dbods->prepare($sql1);
			$sth1->execute() or die $DBI::errstr;
			while (@row = $sth1->fetchrow_array()){
				$vol1 = ceil($row[2]);
				push((@data1),("$row[0],$row[1],$row[2]"));
				my ($key, $val) = ($row[1],$row[2]);
				$data1{$key} .= exists $data1{$key} ? "$val" : $val;
			}		
			$sth1->finish;
			foreach $dt (@dates){ 
				if (!exists $data1{$dt}) {
					push((@data3),("$paycat,$dt,0"));
				} else {
					push((@data3),("$paycat,$dt,$data1{$dt}"));
				}
			}
			$vol2 = ceil($data1{$date4});
			my $dropVol = $vol2 - $vol1;
			if($dropVol >= 5){
				$flag4Gpre = 'Y';
				$vlmnOut .= "4G Prepaid Volume dropped more than 5 TB on $date4:\nVolume $vol2 - $vol1 = Dropped $dropVol\n\n";
			} else {
				$flag4Gpre = 'N';
			}
			undef @data1;
			undef %data1;					
		}	
	}
	
	$outfile1 = "usage_post_pre_4G_volume_$date2.xls";
	$xlsout = $outfile1;
	@xlsin = sort { $a cmp $b } @data3;
	$g4 = 'Y';
	eval {volumeChart()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	$g4 = 'N';
	
	undef @data3;
	
	foreach my $paycat (@paycat){
		if($paycat eq 'POST'){
			my $sql1 = qq#select /*+ parallel (t1,16) */ t1.l3_payment_category, to_char(trunc(t1.sys_creation_date),'YYYYMMDD'), round(sum(t1.l3_volume/1024/1024/1024),8) from ape1_rated_event t1
						where t1.event_type_id in (51,69)
						and t1.l3_payment_category = '$paycat'
						and t1.l9_volume_type in ('2G','3G')
						and trunc(t1.sys_creation_date) between trunc(sysdate-90) and trunc(sysdate-1)
						group by t1.l3_payment_category, to_char(trunc(t1.sys_creation_date),'YYYYMMDD')
						order by 2 asc
						#;
			my $sth1 = $dbods->prepare($sql1);
			$sth1->execute() or die $DBI::errstr;
			while (@row = $sth1->fetchrow_array()){
				$vol1 = ceil($row[2]);
				push((@data1),("$row[0],$row[1],$row[2]"));
				my ($key, $val) = ($row[1],$row[2]);
				$data1{$key} .= exists $data1{$key} ? "$val" : $val;
			}					
			$sth1->finish;
			foreach $dt (@dates){ 
				if (!exists $data1{$dt}) {
					push((@data3),("$paycat,$dt,0"));
				} else {
					push((@data3),("$paycat,$dt,$data1{$dt}"));
				}
			}			
			undef @data1;
			undef %data1;
		}	
	
		if($paycat eq 'PRE'){
			my $sql1 = qq#select /*+ parallel (t1,16) */ t1.l3_payment_category, to_char(trunc(t1.sys_creation_date),'YYYYMMDD'), round(sum(t1.l3_volume/1024/1024/1024),8) from ape1_rated_event t1
						where t1.event_type_id in (51,69)
						and t1.l3_payment_category = '$paycat'
						and t1.l9_volume_type in ('2G','3G')
						and trunc(t1.sys_creation_date) between trunc(sysdate-90) and trunc(sysdate-1)
						group by t1.l3_payment_category, to_char(trunc(t1.sys_creation_date),'YYYYMMDD')
						order by 2 asc
						#;
			my $sth1 = $dbods->prepare($sql1);
			$sth1->execute() or die $DBI::errstr;
			while (@row = $sth1->fetchrow_array()){
				$vol1 = ceil($row[2]);
				push((@data1),("$row[0],$row[1],$row[2]"));
				my ($key, $val) = ($row[1],$row[2]);
				$data1{$key} .= exists $data1{$key} ? "$val" : $val;
			}					
			$sth1->finish;
			foreach $dt (@dates){ 
				if (!exists $data1{$dt}) {
					push((@data3),("$paycat,$dt,0"));
				} else {
					push((@data3),("$paycat,$dt,$data1{$dt}"));
				}
			}
			$vol2 = ceil($data1{$date4});
			my $dropVol = $vol2 - $vol1;			
			if($dropVol >= 1000){
				$flag3Gpre = 'Y';
				$vlmnOut .= "3G Prepaid Volume dropped more than 1000 GB on $date4:\nVolume $vol2 - $vol1 = Dropped $dropVol\n\n";
			} else {
				$flag3Gpre = 'N';
			}
			undef @data1;
			undef %data1;			
		}					
	}
	
	$outfile2 = "usage_post_pre_3G_volume_$date2.xls";
	$xlsout = $outfile2;
	@xlsin = sort { $a cmp $b } @data3;
	$g3 = 'Y';
	eval {volumeChart()};
	if ($@){
		print $fh "$@";
		sendErr();
	}
	$g3 = 'N';
	
	undef @data3;
}

sub volumeChart(){
	@data2 = @paycat;	
	my $workbook = Spreadsheet::WriteExcel->new($xlsout)or die "failed to create new workbook: $!";
	my $worksheet = $workbook->add_worksheet();
	my $bold      = $workbook->add_format(bold => 1);
	my $font      = $workbook->add_format(font => 'Arial 8');
	$worksheet->write_row(0,0,['',''],$font);
	my $chart1 = 1;
	my $cntsht = 1;
	my $cntrow = 0;
	my $cntcol = 0;
	my $cntdata = 0;
	$fFrmt2 = shift(@data2);
	while ($fFrmt2){
		foreach (@xlsin){
			my @x = split(',',$xlsin[$cntdata]);
			if ($fFrmt2 eq $x[0]){
				my @cols = split(',',$xlsin[$cntdata]);
				my @fix_cols = grep(s/\s*$//g, @cols);
				$worksheet->write_row($cntrow,$cntcol,\@fix_cols);
				$cntrow++;
				$cntdata++;
			}				
		}
		$cntrow = 0;
		$cntcol = $cntcol + 3;			
		$fFrmt2 = shift(@data2);
	}
	@data2 = @paycat;
	my $x = $#paycat*3+3;
	my @columns;
	for(my $i=1; $i<=$x; $i++){	
		push((@columns),(&num2alpha($i)));
	}
	my $font = $workbook->add_format(font => 'Arial 8');
	foreach $chrt (@paycat){
		$chart1 = $workbook->add_chart(type => 'line', name => $chrt);
		$fFrmt2 = shift(@data2);
		my $scaler = join(",", @xlsin);
		my $cntrow =()= $scaler =~ /$fFrmt2/g;
		my $column = shift @columns;
		$column = shift @columns;
		my $c = '!'.$column.'$2:';
		my $x_values = '=Sheet'."$cntsht".$c.$column.'$'."$cntrow";
		$column = shift @columns;
		$c = '!'.$column.'$2:';
		$y_values = '=Sheet'."$cntsht".$c.$column.'$'."$cntrow";
		if($g4 eq 'Y'){
			$chart1->set_title(name => '4G DATA USAGE VOLUME');
			$chart1->set_x_axis(name => 'DATE');
			$chart1->add_series(
				categories => $x_values,
				values => $y_values,
				name => $chrt,
			);
			$chart1->set_y_axis(name => 'TERA BYTES',);
		}
		if($g3 eq 'Y'){
			$chart1->set_title(name => '3G DATA USAGE VOLUME');
			$chart1->set_x_axis(name => 'DATE');
			$chart1->add_series(
				categories => $x_values,
				values => $y_values,
				name => $chrt,
			);
			$chart1->set_y_axis(name => 'GIGA BYTES',);
		}		
		$chart1++;
	}
	$cntsht++;
}

sub getBODSPRD{
	my $dbPwd = "BODS_SVC_BILLINGOPS";
	my $dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	unless ($dbods) {sendErr();}
	return $dbods;
}

sub sendNB(){
	# my $to = 'david.smith@uscellular.com';
	my $to = '';
	my $cc = '';
	my $from = 'USCDLISBillingandRevenueOps@uscellular.com'; 
	my $subject .= '';
	my $message .= '';
	if($flagNB eq 'Y'){
		$to .= 'USCCShiftManagement@amdocs.com,anupam.basak@amdocs.com,rakesh.ruhil@amdocs.com,vikaskh@amdocs.com,christine.bekos@uscellular.com,marla.suda@uscellular.com,gerardo.lopez@uscellular.com,Robert.McKay@uscellular.com';
		$cc .= 'ISBillingOperations@uscellular.com';
		$subject .= "PREPAID USAGE DROP MONITOR for $date2 - NB < 120000 INVESTIGATION REQUIRED";
		$message .= "Open a sev 4 Remedy ticket against Amdocs - Tier 2 Billing\n\n";
		$message .= $nbOut;
	} else {
		$to .= 'ISBillingOperations@uscellular.com';
		$subject = "PREPAID USAGE DROP MONITOR for $date2 - NO ACTION REQUIRED";
		$message .= $nbOut;
	}

	my $msg = MIME::Lite->new(
		From => $from,
		To => $to,
		Cc => $cc,
		Subject => $subject,
		Data => $message
	);	
	$msg->send();
}

sub sendMsg(){
	my $to = $distroTo;
	my $cc = $distroCc;
	my $from = 'USCDLISBillingandRevenueOps@uscellular.com'; 
	my $subject .= '';
	my $message .= '';
	if($flag3Gpre eq 'Y' || $flag4Gpre eq 'Y'){
		$to .= 'USCCShiftManagement@amdocs.com,anupam.basak@amdocs.com,rakesh.ruhil@amdocs.com,vikaskh@amdocs.com,christine.bekos@uscellular.com,marla.suda@uscellular.com,gerardo.lopez@uscellular.com,Robert.McKay@uscellular.com';
		$cc .= 'ISBillingOperations@uscellular.com';
		$subject .= "PREPAID USAGE VOLUME MONITOR for $date2 - INVESTIGATION REQUIRED";
		$message .= "Open a sev 4 Remedy ticket against Amdocs - Tier 2 Billing\n\n";
		$message .= $vlmnOut;
	} else {
		$to .= 'ISBillingOperations@uscellular.com';
		$subject = "PREPAID AND POSTPAID USAGE VOLUME MONITOR for $date2";
	}
	$message .= "See attached $outfile1 for Event Trend Graph and Supporting Data.\n";
	$message .= "See attached $outfile2 for Event Trend Graph and Supporting Data.\n\n";
	$message .= "$archive$outfile1\n";
	$message .= "$archive$outfile2";
	
	my $msg = MIME::Lite->new(
		From => $from,
		To => $to,
		Cc => $cc,
		Subject => $subject,
		Data => $message
	);
	
	$msg->attach(
	Type => "application/vnd.ms-excel",
	# Type => "text/plain",	
	Path => $path.$outfile1,
	Filename => $outfile1,
	Disposition => "attachment"
	);		
	
	$msg->attach(
	Type => "application/vnd.ms-excel",
	# Type => "text/plain",	
	Path => $path.$outfile2,
	Filename => $outfile2,
	Disposition => "attachment"
	);	
	
	$msg->send();	
	
}

sub sendErr(){
	my $to = $distroTo;
	my $cc = $distroCc;
	my $from = 'USCDLISBillingandRevenueOps@uscellular.com'; 
	my $subject = "PREPAID AND POSTPAID USAGE VOLUME MONITOR FAILED!";
	my $message .= "Failed to create USAGE VOLUME MONITOR for $date2!: $!, $?, $@\n";
	$message .= "$log$logfile\n";

	my $msg = MIME::Lite->new(
		From => $from,
		To => $to,
		Cc => $cc,
		Subject => $subject,
		Data => $message
	);
	
	$msg->attach(
		Type => "application/vnd.ms-excel",
		# Type => "text/plain",
		Path => $path.$logfile,
		Filename => $logfile,
		Disposition => "attachment"
	);	
	
	$msg->send();
	
	close(STDERR);
	close($fh);	
	eval {cleanUp()};
	if ($@){
		print $fh "$@\n";
		sendErr();
	}
	exit;
}

sub cleanUp() {
	chdir("/apps/ebi/usacq1/is_bill_ops_mntr/volume/");
	my $cmd = "mv usage_post_pre*xls $archive";
	system($cmd);
	$cmd = "mv usage_post_pre*log $log";
	system($cmd);	
}
