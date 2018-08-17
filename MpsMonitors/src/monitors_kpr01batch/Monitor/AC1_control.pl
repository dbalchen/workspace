#!/usr/local/bin/perl
#-------------------------------------------------------------------------------
# Script:      AC1_control.pl
#
# Description: Created for TOPS.  This script gets information about the ac1_control
#		and the status of files in it. 
#
# Author:      Steve M Roehl
#
# Date:        Wed Feb 12 12:47:48 CDT 2014
#
#-------------------------------------------------------------------------------

use FileHandle;
use DBI;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush();

$user = $ENV{'USER'};
$user =~ s/ //g;

$flip = 0;

$x = "+\"%D %I:%M:%S%p\"";
chomp $x;
$time = `date $x`;
chomp($time);

print "{\"time\": \"$time\",\n";
fileStatus();
fileStatus2();
print ",\n";

dataStatus();
print "\n}";


sub dataStatus {
  my ($user,$pass,$dbname) = getConnectParams("PRDAFCAPP");
  my $db = DBI->connect("dbi:Oracle:$dbname",$user,$pass);
  my $sql = qq#select count(*),substr(file_name,instr(file_name,'_T')+2,8) "Date",file_status
            from ac1_control
            where identifier = phy_file_ident and substr(file_name,instr(file_name,'_T')+2,4) = '2016'
            group by substr(file_name,instr(file_name,'_T')+2,8),file_status
            order by substr(file_name,instr(file_name,'_T')+2,8),file_status#;
  my $sth = $db->prepare($sql);
  $sth->execute();
  my $rows = $sth->fetchall_arrayref();
  print "\"data_status\":[ ";
  my $first = 1;
  foreach my $row (@$rows){
    if($first == 0){
      print ",\n";
    }else{
      $first=0;
    }
    print "{\"count\":\"" . @$row[0] . "\",\"date\":\"" . @$row[1] . "\",\"file_status\":\"" . @$row[2] . "\"}";
  }
  print "]";
}


sub fileStatus {
  my ($user,$pass,$dbname) = getConnectParams("PRDAFCAPP");
  my $db = DBI->connect("dbi:Oracle:$dbname",$user,$pass);
  my $sql = qq#select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date) as sys_creation_date, trunc(sys_update_date) as sys_update_date, count(*) from  ac1_control
            where file_status  in ('IU','RD','HO')
            and cur_pgm_name = 'SPL'
            and nxt_pgm_name = 'HLD'
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date)
            union
            select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*) from  ac1_control
            where file_status  in ('IU','RD','HO')
            and cur_pgm_name = 'MD'
            and nxt_pgm_name = 'AEM'
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date)
            union
            select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*) from  ac1_control
            where file_status  in ('IU','RD','HO')
            and nxt_pgm_name = 'RGD'
            and cur_pgm_name = 'SPL1'
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date)
            union
            select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*) from  ac1_control
            where file_status = 'AF'
            and cur_pgm_name != 'EVTPOPX'
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date)
            union
            select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*) from  ac1_control
            where file_status in ('IU')
            and  trunc(sys_creation_date) < trunc(sysdate)
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date)
            union
            select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*) from  ac1_control
            where nxt_pgm_name in ('MD','File2E')
            and file_status in ('IU','RD','HO')
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name ,trunc(sys_creation_date), trunc(sys_update_date)
            union
            select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*) from  ac1_control
            where file_status in ('FR')
            and  trunc(sys_creation_date) < trunc(sysdate-0.09)
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name ,trunc(sys_creation_date), trunc(sys_update_date)
            union
            select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*) from prdafc. ac1_control
            where file_status in ('IU')
            and cur_pgm_name != 'EVTPOPX'
            and  trunc(sys_creation_date) < trunc(sysdate-1)
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name ,trunc(sys_creation_date), trunc(sys_update_date)#;

  my $sth = $db->prepare($sql);
  $sth->execute();
  my $rows = $sth->fetchall_arrayref();
  print "\"file_status\":[ ";
  my $first = 1;
  foreach my $row (@$rows){
    if($first == 0){
      print ",\n";
    }else{
      $first=0;
    }

    $flip = 1;

    print "{\"file_format\":\"" . @$row[0] . "\",\"file_status\":\"" . @$row[1] . "\",\"curpgm\":\"" . @$row[2] . "\",\"nxtpgm\":\"" . @$row[3] . "\",\"create_date\":\"" . @$row[5] . "\",\"update_date\":\"" . @$row[6] . "\",\"count\":\"" . @$row[7] . "\"}";
  }
  $sth->finish;
  $db->disconnect();
}

  
sub fileStatus2 {
   my ($user,$pass,$dbname) = getConnectParams("PRDAPP");
   my $db = DBI->connect("dbi:Oracle:$dbname",$user,$pass);

   my $sql = qq#select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*) from  ac1_control
            where file_status <> 'CO' 
            and (cur_pgm_name in ('AR1PYMRCT', 'AREXTRACT', 'AR9RPLDAILY', 'AR1JRNLEXT', 'AR1INVRCT', 'AR9PYMBCK', 'AR1JRNLANAL', 'AR1PYMPOST')
            or nxt_pgm_name like 'AR1PYM%'  or nxt_pgm_name = 'AR9RPLDAILY')
            and file_format != 'ERRORFILE' 
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date)
	    union
            select  file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date), count(*)
             from ac1_control where nxt_pgm_name='AR1INVRCT' 
            group by file_format, file_status, cur_pgm_name, nxt_pgm_name, host_name, trunc(sys_creation_date), trunc(sys_update_date)#;

  my $sth = $db->prepare($sql);
  $sth->execute();
  my $rows = $sth->fetchall_arrayref();
  my $first = 1;
  foreach my $row (@$rows){
    if($first == 0){
      print ",\n";
    }else{
      $first=0;
if($flip == 1){print ",\n";};$flip =0;
    }
    print "{\"file_format\":\"" . @$row[0] . "\",\"file_status\":\"" . @$row[1] . "\",\"curpgm\":\"" . @$row[2] . "\",\"nxtpgm\":\"" . @$row[3] . "\",\"create_date\":\"" . @$row[5] . "\",\"update_date\":\"" . @$row[6] . "\",\"count\":\"" . @$row[7] . "\"}";
  }
  $sth->finish;
  $db->disconnect();
  print "]";

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


exit(0);
