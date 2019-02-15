#!/usr/bin/env perl

use lib './';
use DBI;
use Schedule::Cron;
use MIME::Lite;
use Carp qw (croak);



my @changedFiles;
#scheduledTask();

my $cron = new Schedule::Cron(\&scheduledTask);
my $time = "00 05 * * *";
$cron->add_entry($time);

$cron->run(detach=>1,pid_file=>"/pkgbl02/inf/aimsys/prdwrk2/eps/af_fixer.pid");

sub scheduledTask{
  @changedfiles=();
  my ($user,$pass,$db) = getConnectParams("PRDAFCAPP");
  my $emptyFiles = fixEmptyFile($user,$pass,$db);
  fixAfServe($user,$pass,$db);
  sendMsg($emptyFiles);
}

sub sendMsg{
  my ($emptyFiles) = @_;

  #$to = "Steven.Roehl\@uscellular.com";
  $to = "MPS\@uscellular.com";
  my $from = "EventProcessingTeam(auto)\@uscellular.com"; 
  my $subject = "CIBER AF Fixer status";

  my $message = "Results for the Automated CIBER AF Fixer:\n\n";

  if(@changedFiles > 0){
    while (@changedFiles > 0){
      my ($old,$new) = @{pop(@changedFiles)};
      if(length($new) <2){
        $message .= "File $old was not fixed because does not contain: 45696, 45697, or 45698";
      }else{
        $message .= "Fixed $old and replaced it with $new\n";
      }
    }
  }else{
    $message .= "No CIBER AF files that have the wrong serve sid exist\n";
  }

  $message .= "\nThere were ${emptyFiles} CIBER AF files with wr_rec_quantity of 2\n";

  $msg = MIME::Lite->new(
	From=>$from,
	To => $to,
	Subject => $subject,
	Data => $message
  );
#  print $message ."\n";
  $msg->send();
}

  


sub fixEmptyFile{
  my ($user,$pass,$db) = @_;
  my $db = DBI->connect("dbi:Oracle:${db}",$user,$pass);

  my $sql=qq# update ac1_control set file_status='CN' 
	where cur_file_alias='CIBER' and wr_rec_quantity=3 and file_status='AF'#;
  my $update_rows = $db->do($sql);
  #Change update_rows to 0 if it updates zero rows since it returns 0E0
  if($update_rows == 0){
    $update_rows = 0;
  }
  return $update_rows;
}
    
  


sub fixAfServe{
  my ($user,$pass,$db) = @_;

  my $switch = "/pkgbl02/inf/aimsys/prdwrk2/var/usc/projs/up/physical/switch/DIRI/";
  my $db = DBI->connect("dbi:Oracle:${db}",$user,$pass);
  my $sql = qq# select file_path,file_name 
		from ac1_control 
		where file_status='AF' and cur_file_alias='CIBER' and cur_pgm_name = 'LSN' #;
  my $sth = $db->prepare($sql);
  $sth->execute();
  my $files= $sth->fetchall_arrayref();
  my $runHold = 1;
  #push(@$files,['/pkgbl01/inf/aimsys/prdwrk1/steve/af_fixes','SDIRI_FCIBER_ID000032_T20131016185745.DAT']);
  foreach my $file (@$files){
    my $fixedFile =0;
    my $fullFile = $switch . @$file[1];
    my $newFile = $switch . substr(@$file[1],0,-6) . "99";
    print $fullFile . "\n";
    open IN,"<",$fullFile;
    print $newFile . ".DAT\n";
    open OUT,">",$newFile . ".DAT";
    while (<IN>){
      if (($_ =~ /^01[0-9]*45696/) or ($_ =~ /^01[0-9]*45697/) or ($_ =~ /^01[0-9]*45698/)){
        <IN>;
        $fixedFile = 1;
      }else{
        print OUT $_;
      }
    }
    close IN;
    close OUT;   
    system("touch ${newFile}.FIN");
  
    if($fixedFile == 1){
      push(@changedFiles,[$fullFile,$newFile]);
      my $cancelSql = qq#update ac1_control set file_status='CN' where file_name=? and file_path=?#;
      my $cansth=$db->prepare($cancelSql);
      $cansth->execute(@$file[1],@$file[0]);
    }else{
      $runHold=0;
      push(@changedFiles,[$fullFile,0]);
    }
  }
  if($runHold == 1){
    my $holdSql=qq#update ac1_control 
 		set cur_pgm_name = 'HLD',cur_file_alias = 'CBR_RETRCL',
      		nxt_pgm_name = 'MD', nxt_file_alias = 'CBR_RETRCL'
 		where nxt_pgm_name = 'HLD'
   		and nxt_file_alias = 'CBR_RETHLD'
   		and file_status = 'RD'#;
    my $holdSth=$db->prepare($holdSql);
    $holdSth->execute();
    $db->disconnect();
  }
}
  


sub getConnectParams{
  my ($connectCode) = @_;

  my $db = DBI->connect("dbi:Oracle:prdcust","PRDOPRC","con8cst8");
  $db->{LongReadLen}=1500;
  my $sql=qq# select conn_params from gn1_connect_params where connect_code=?#;
  my $sth = $db->prepare($sql);
  $sth->execute($connectCode);
  my $params = $sth->fetchrow();
  my $user = substr($params,index($params,'USER')+13,index($params,'"',index($params,'USER')+13)-index($params,'USER')-13);
  #print "user: ${user}\n";
  my $pass= substr($params,index($params,'PASSWORD')+17,index($params,'"',index($params,'PASSWORD')+17)-index($params,'PASSWORD')-17);
  #print "pass: ${pass}\n";
  my $instance= substr($params,index($params,'INSTANCE')+17,index($params,'"',index($params,'INSTANCE')+17)-index($params,'INSTANCE')-17);
  #print "instance: ${instance}\n";
  $sth->finish();
  $db->disconnect() if defined($db);
  return ($user,$pass,$instance);
}

sub connectUsg{
  my ($cycle_code) = @_;
  my $db;

  if ($cycle_code == 2 or $cycle_code == 8 or $cycle_code == 20){
    $db = DBI->connect("dbi:Oracle:prdusg1",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG1C");
    print "Connected to Usage 1\n";
  }elsif($cycle_code == 12 or $cycle_code == 18 or $cycle_code == 22){
    $db = DBI->connect("dbi:Oracle:prdusg2",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG2C");
    print "Connected to Usage 2\n";
  }elsif($cycle_code == 10 or $cycle_code==16 or $cycle_code==24 or $cycle_code==28){
    $db = DBI->connect("dbi:Oracle:prdusg3",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG3C");
    print "Connected to Usage 3\n";
  }elsif($cycle_code == 4 or $cycle_code == 6 or $cycle_code == 14 or $cycle_code == 26){
    $db = DBI->connect("dbi:Oracle:prdusg4",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG4C");
    print "Connected to Usage 4\n";
  }else{
    croak "Incorrect cycle code: $cycle_code\n";
  }
  return $db;
}

sub connectCust{
  my $db = DBI->connect("dbi:Oracle:prdcust",$user,$pass);
  $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDCUSTC");

  return $db;
}

sub cleanup{
  $usg_DB->disconnect() if defined($usg_DB);
  $cust_DB->disconnect() if defined($cust_DB);
} 


