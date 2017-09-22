#!/usr/bin/env perl

BEGIN {
   #push(@INC, '/home/common/eps/perl_lib/lib/perl5/');
   push( @INC, '/home/dbalchen/workspace/perl_lib/lib/perl5' );
}

# use strict;
use MIME::Lite;
use DBI;
use Schedule::Cron;
use Spreadsheet::WriteExcel;
use FileHandle;
use Cwd qw(abs_path);
use POSIX;
use List::Uniq ':all';
#use Array::Utils qw(:all);

my $af_out = '';
my $date1 = 0;
my $date2 = 0;
my $dbods = 0;
my $email = 0;
my $exid = 0;
my $extid = '';
my $flcrdt = 0;
my $inrec = 0;
my $path = 0;
my $reccnt = 0;
my $stdev = 0;
my $time = 0;
my $xlsout = 0;
my $xlsout1 = 0;
my %externalId;
my @data;
my @data1;
my @dates;
my @exid;
my @exid1;
my @exid5;
my @extidesc;
my @extids;
my @row;
my @xlsin;

&scheduledTask();
# my $cron = new Schedule::Cron(\&scheduledTask,processprefix=>"ac1_control_volume_monitor");
# my $time = "0 4 * * *";
# $cron->add_entry($time);
# $cron->run(detach=>1,pid_file=>"ac1_control_volume_monitor_pid");

sub scheduledTask(){
	chdir("/home/common/eps/ac1/");
	$path = abs_path . "/";
	$archive = "$path"."archive/";	
	$date1 = `date +%Y%m%d%H%M`; chomp $date1;
	$date2 = `date --date="1 days ago" +"%Y%m%d"`; chomp $date2;
	$time = `date +%H%M`; chomp $time;
	$dbods = getBODSPRD();
	getExtId();
	getDate();
	volume();
	sendMail();
	cleanUp();
	$dbods->disconnect();
}

sub num2alpha($i){
    my $num = shift;

    my $alpha = 'A';
    $alpha++ for 2..$num;
	
	my $column = "\$$alpha";
    return $column;
}

sub getExtId{
	my $sql = qq#select /*+ parallel (a, 8)*/ distinct external_id, 
					decode(external_id, 'VALI', 'VALI_USCC_Third_Party_Content', 'AAA1', 'AAA1_USCC_Data',  'GSMD', 'GSMD_USCC_Data', 'GSMS', 'GSMS_USCC_SMS', 'GSMT', 'GSMT_USCC_SMS', 'MOT', 'MOT_USCC_SMS', 'PMG1', 'PMG1_USCC_MMS', 'PTX1', 'PTX1_USCC_MMS',
					'APPL', 'APPL_USCC_Voice', 'ASHE', 'ASHE_USCC_Voice', 'CDR2', 'CDR2_USCC_Voice', 'CLIN', 'CLIN_USCC_Voice', 'COLU', 'COLU_USCC_Voice', 'CONG', 'CONG_USCC_Voice', 'EURE', 'EURE_USCC_Voice', 'GRAN', 'GRAN_USCC_Voice', 'GREE', 'GREE_USCC_Voice', 
					'GSMV', 'GSMV_USCC_Voice', 'JOHN', 'JOHN_USCC_Voice', 'JOPL', 'JOPL_USCC_Voice', 'KNOX', 'KNOX_USCC_Voice', 'LLYN', 'LLYN_USCC_Voice', 'LROE', 'LROE_USCC_Voice', 'MADI', 'MADI_USCC_Voice', 'MEDF', 'MEDF_USCC_Voice', 'MORG', 'MORG_USCC_Voice', 
					'NEWB', 'NEWB_USCC_Voice', 'OKLA', 'OKLA_USCC_Voice', 'OMAH', 'OMAH_USCC_Voice', 'OWAS', 'OWAS_USCC_Voice', 'PEO2', 'PEO2_USCC_Voice', 'ROC2', 'ROC2_USCC_Voice', 'SALI', 'SALI_USCC_Voice', 'TAS1', 'TAS1_USCC_LTE_Voice', 'YAKI', 'YAKI_USCC_Voice',
					'PGW1', 'PGW1_USCC_LTE_DATA', 'DATACBR', 'DATACBR_Inter-Carrier_Roaming_Data',  'DIRI', 'DIRI_Inter-Carrier_Roaming_Voice',  'DATAIN', 'DATAIN_Intra-Company_Roaming_Data', 'SYNR', 'SYNR_Syniverse_Reject_Records')
					description 
                    from ac1_control_hist a
                    where data_group in ('MF1LSNTOMD','MF1LSNTOSPL','MF1LSNTOSPL')
                    and file_format in ('UFF','CIBER','DATAROAM','CIBER')
                    and nxt_pgm_name in ('MD','SPL')
                    and external_id != ' '
                    union
				select 'OUTCL', 'OUTCL_Outcollects' from dual
                    order by 1 asc   
				#;
	my $sth = $dbods->prepare($sql);
	$sth->execute() or sendErr();
		while (my @row = $sth->fetchrow_array()){
			push((@extids),("$row[0]"));
			push((@extidesc),("$row[1]"));
			my ($key, $val) = ($row[0],$row[1]);
			$externalId{$key} .= exists $externalId{$key} ? "$val" : $val;
		}
	$sth->finish();
}

sub getDate{
	my $sql = qq#select trim(to_char(trunc(sysdate - rownum), 'YYYYMMDD'))
					--from dual connect by rownum < 62
					from dual connect by rownum < 5 --test
					order by 1 asc
				#;
	my $sth = $dbods->prepare($sql);
	$sth->execute() or sendErr();
		while (my @row = $sth->fetchrow_array()){
			push((@dates),("$row[0]"));
		}
	$sth->finish();
}

sub mean(){
	my $total = 0;
	foreach (@stats){
		$total += $_;
	}
	my $mean = ceil($total/$#stats);
	return $mean;
}

sub stdev(){
	if($#stats == 1){
		return 0;
	}	
	my $mean = &mean($stats);			# calculate the mean or average
	my $sqsum = 0;
	for (@stats){
		$sqsum += (($_-$mean) ** 2);	# calculate the variance, take each difference, square it...
	} 
	$sqsum /= $#stats;					# average the result
	my $stdev = ceil(sqrt($sqsum));		# calculate standard deviation, take the square root of variance
	# print "$extid\t mean: $mean\t stdev: $stdev\n";
	return $stdev;
}

sub volume(){
	$af_out .= "\n\n"; 
	$af_out .= "See attached for Record Trend Graph and Supporting Data.\n";
	# $af_out .= "Contact USCC Rating SME when Warnings are Shown Below.";
	$af_out .= "***Warnings shown below are monitored by USCC Rating SME. No action is required at this time.***";
	@exid = @extids;
	undef @exid; #test
	push((@exid),("OUTCL")); #test
	foreach $extid (@exid){
		my $sql1 = '';
		my $sth1 = '';
		foreach $dt (@dates){
			if($extid ne 'OUTCL'){
				$sql1 = qq#select /*+ parallel (a, 8)*/ a.external_id, trim(to_char(trunc(a.file_create_date), 'YYYYMMDD')) file_create_date, sum(a.in_rec_quantity) in_rec_quantity, count(*) count from ac1_control_hist a
								where a.data_group in ('MF1LSNTOMD','MF1LSNTOSPL','MF1LSNTOSPL')
								and a.file_format in ('UFF','CIBER','DATAROAM','CIBER')
								and a.nxt_pgm_name in ('MD','SPL')                    
								and a.external_id = '$extid'
								and trunc(a.file_create_date) = to_date('$dt','YYYYMMDD')
								group by a.external_id, trunc(a.file_create_date)
								order by trunc(a.file_create_date), a.external_id
							#;
			}		
			if($extid eq 'OUTCL'){
				$sql1 = qq#select /*+ parallel (a, 8)*/ nvl(a.external_id,'OUTCL'), trim(to_char(trunc(a.file_create_date), 'YYYYMMDD')) file_create_date, sum(a.wr_rec_quantity) wr_rec_quantity, count(*) count from ac1_control_hist a
								where SUBSTR(a.FILE_NAME,0,11) = 'CIBER_CIBER' --analysis
								and a.nxt_pgm_name = 'CBRRPT'
								and trunc(a.file_create_date) = to_date('$dt','YYYYMMDD')
								group by a.external_id, trunc(a.file_create_date)
								order by trunc(a.file_create_date), a.external_id
							#;
			}
			$sth1 = $dbods->prepare($sql1);
			$sth1->execute() or die $DBI::errstr;
			@row = $sth1->fetchrow_array();
			$exid = $row[0];
			$flcrdt = $row[1];
			$reccnt = $row[2];
			push((@data),("$flcrdt"));
			push((@stats),("$reccnt")); # record count		
				if(!@row){
					push((@data1),("$extid,$dt,0"));
				} else {
					push((@data1),("$exid,$flcrdt,$reccnt")); # record count
					push((@exid1),("$exid"));
				}
			}
			$sth1->finish;

			$inrec = $stats[$#stats-1];
			my $mean = &mean();
			$stdev = &stdev();
			$stdev = ($stdev * 1);
			my $r1 = $mean - $stdev;
			my $r2 = $mean + $stdev;
			
			# print "$extid\t count: $inrec\t mean: $mean\t stdev: $stdev\trange: $r1\t$r2\n";
			$af_out .= "\n\n";
			$af_out .= "WARNING - $externalId{$extid} $date2 record count, $inrec, is outside the standard deviation range, $stdev, for the mean $mean!"; # record count	
			undef @stats;
	}
	
	@xlsin = @data1;
	@exid = uniq(@exid1);
	$xlsout1 = "ac1_volume_monitor_1_$date1.xls";
	$xlsout = $xlsout1;
	volumeChart();
}

sub volumeChart(){
	chdir("/home/common/eps/ac1/");
	@exid5 = @exid;
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
	$extid = shift(@exid5);
	while ($extid){
		foreach (@xlsin){
			my @x = split(',',$xlsin[$cntdata]);
			if ($extid eq $x[0]){
				my @cols = split(',',$xlsin[$cntdata]);
				my @fix_cols = grep(s/\s*$//g, @cols);
				$worksheet->write_row($cntrow,$cntcol,\@fix_cols);
				$cntrow++;
				$cntdata++;
			}				
		}
		$cntrow = 0;
		$cntcol = $cntcol + 3;			
		$extid = shift(@exid5);
	}
	@exid5 = @exid;
	my $x = $#exid*3+3;
	my @columns;
	for(my $i=1; $i<=$x; $i++){	
		push((@columns),(&num2alpha($i)));
	}
	my $font   = $workbook->add_format(font => 'Arial 8');
	foreach $chrt (@exid){
		$chart1 = $workbook->add_chart(type => 'line', name => $chrt);
		$extid = shift(@exid5);
		my $scaler = join(",", @xlsin);
		my $cntrow =()= $scaler =~ /$extid/g;
		my $column = shift @columns;
		$column = shift @columns;
		my $c = '!'.$column.'$2:';
		my $x_values = '=Sheet'."$cntsht".$c.$column.'$'."$cntrow";
		$column = shift @columns;
		$c = '!'.$column.'$2:';
		$y_values = '=Sheet'."$cntsht".$c.$column.'$'."$cntrow";			
		$chart1->add_series(
			categories => $x_values,
			values => $y_values,
			name => $externalId{$chrt},
			);
	$chart1->set_title(name => 'USAGE RECORD VOLUME',); # record count
	$chart1->set_x_axis(name => 'DATE',);
	$chart1->set_y_axis(name => 'COUNT',);
	$chart1++;
	}
	$cntsht++;
}

sub sendMail(){
	# my $to = 'ISBillingOperations@uscellular.com';
	my $to = 'david.smith@uscellular.com';
	my $cc = '';
	my $from = 'USCDLISOps-BillingCycleManagement@uscellular.com';
	my $subject = "AC1_CONTROL Record Volume Monitor Report for $date1";
  
	my $msg = MIME::Lite->new(
		From=>$from,
		To => $to,
		Cc => $cc,
		Subject => $subject,
		Data => $af_out
	);

	$msg->attach(
		Type => "application/vnd.ms-excel",
		# Type => "text/plain",
		Path => $path.$xlsout1,
		Filename => $xlsout1,
		Disposition => "attachment"
	);

	$msg->send();
}

sub sendErr(){
	# my $to = 'ISBillingOperations@uscellular.com';
	my $to = 'david.smith@uscellular.com';
	my $cc = '';
	my $from = 'USCDLISOps-BillingCycleManagement@uscellular.com'; 
	my $subject = "AC1_CONTROL Record Volume Monitor Report FAILED!";
	my $message .= "Failed to create AC1_CONTROL Record Volume Monitor Report for $date!: $!, $?, $@\n";
	$message .= print "File: ", __FILE__, " Line: ", __LINE__, "\n";
	$message .= warn("ac1_control_volume_monitor.pl");

	my $msg = MIME::Lite->new(
		From => $from,
		To => $to,
		Cc => $cc,
		Subject => $subject,
		Data => $message
	);
	
	$msg->send();
	
	exit;
}

#sub getBODSPRD{
#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
#	unless (defined $dbods) {sendErr();}
#	return $dbods;
#}

sub getBODSPRD {

	#	my $dbPwd = "BODSPRD_INVOICE_APP_EBI";
	#	$dbods = (DBI->connect("DBI:Oracle:$dbPwd",,));
	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "9000#BooGoo" );
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}

sub cleanUp(){
	chdir("/home/common/eps/ac1/");
	$cmd = "mv ac1*volume*xls $archive";
		system($cmd);	
}
