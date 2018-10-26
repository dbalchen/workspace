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
# Date:        20151117 Add /*+ parallel (8)*/ to prm_dat_err_mngr select
#              David A Smith
#-------------------------------------------------------------------------------

use FileHandle;
use DBI;

# Tell perl to flush the buffer to stdout after every command.
STDOUT->autoflush();

$user = $ENV{'USER'};
$user =~ s/ //g;

$x = "+\"%D %I:%M:%S%p\"";
chomp $x;
$time = `date $x`;
chomp($time);

print "{\"time\": \"$time\",\n";
raterStatus();
print ",\n";
errors();
print ",\n";
fileStatus();
print ",\n";
processStuck();
print "\n}";


sub fileStatus{
  my ($user,$pass,$dbname) = getConnectParams("PRDAFCAPP");
  my $db = DBI->connect("dbi:Oracle:$dbname",$user,$pass);
  my $sql = qq#
select cur_pgm_name,  nxt_pgm_name, file_status, sum(cnt), sum(quantity) from
            (select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity from  prdappo.ac_control_01
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt,sum(wr_rec_quantity) as quantity from prdappo.ac_control_02
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity from prdappo.ac_control_03
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity  from  prdappo.ac_control_04
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt,sum(wr_rec_quantity) as quantity from prdappo.ac_control_05
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity from prdappo.ac_control_06
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt,sum(wr_rec_quantity) as quantity from prdappo.ac_control_07
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity from prdappo.ac_control_08
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity from prdappo.ac_control_09
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity from prdappo.ac_control_10
            where file_status not in ('CO', 'CN')
            group by cur_pgm_name,  nxt_pgm_name, file_status)
            group by cur_pgm_name,  nxt_pgm_name, file_status

#;
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
    print "{\"curpgm\":\"" . @$row[0] . "\",\"nxtpgm\":\"" . @$row[1] . "\",\"file_status\":\"" . @$row[2] . "\",\"count\":\"" . @$row[3] . "\",\"quantity\":\"" . @$row[4] . "\"}";
  }
  print "]";
}


sub raterStatus{
  my ($user,$pass,$dbname) = getConnectParams("PRDAFCAPP");
  my $db = DBI->connect("dbi:Oracle:$dbname",$user,$pass);
  my $sql = qq#
select  cur_pgm_name,  nxt_pgm_name, file_status, sum(cnt)  ,sum(quantity) , nxt_file_alias, create_date from(
select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_01 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_02 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_03 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_04 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_05 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_06 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_07 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_08 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_09 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_09 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
            union
            select cur_pgm_name,  nxt_pgm_name, file_status, count(*) as cnt ,sum(wr_rec_quantity) as quantity, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')  create_date  from prdappo.ac_control_10 where nxt_pgm_name = 'ICRATER'
            group by cur_pgm_name,  nxt_pgm_name, file_status, nxt_file_alias,to_char(file_create_date, 'YYYYMMDD')
) group by cur_pgm_name,nxt_pgm_name,file_status,nxt_file_alias,create_date
#;

  my $sth = $db->prepare($sql);
  $sth->execute();
  my $rows = $sth->fetchall_arrayref();
  print "\"rater_status\":[ ";
  my $first = 1;
  foreach my $row (@$rows){
    if($first == 0){
      print ",\n";
    }else{
      $first=0;
    }
    print "{\"curpgm\":\"" . @$row[0] . "\",\"nxtpgm\":\"" . @$row[1] . "\",\"file_status\":\"" . @$row[2] . "\",\"count\":\"" . @$row[3] . "\",\"quantity\":\"" . @$row[4] . "\",\"file_alias\":\"" . @$row[5] . "\",\"date\":\"" . @$row[6] . "\"}";
  }
  $sth->finish;
  $db->disconnect();
  print "]";
}

  

sub errors{
  my ($user,$pass,$dbname) = getConnectParams("PRDAFCAPP");
  my $db = DBI->connect("dbi:Oracle:$dbname",$user,$pass);
  my $sql = qq#select dominant_err_cd, count(*) from prm_dat_err_mngr
             group by dominant_err_cd
#;
  my $sth = $db->prepare($sql);
  $sth->execute();
  my $rows = $sth->fetchall_arrayref();
  print "\"errors\":[ ";
  my $first = 1;
  foreach my $row (@$rows){
    if($first == 0){
      print ",\n";
    }else{
      $first=0;
    }
    print "{\"name\":\"" . @$row[0] . "\",\"count\":\"" . @$row[1] . "\"}";
  }
  $sth->finish;
  $db->disconnect();
  print "]";
}


sub processStuck{
  my ($user,$pass,$dbname) = getConnectParams("PRDAFCAPP");
  my $db = DBI->connect("dbi:Oracle:$dbname",$user,$pass);
  my $first = 1;
  print "\"stuck\":[ ";
  for $ac_table ('ac_control_01','ac_control_02','ac_control_03','ac_control_04','ac_control_05','ac_control_06','ac_control_07','ac_control_08','ac_control_09','ac_control_10'){
    my $sql = qq#SELECT '$ac_table',nxt_pgm_name, file_status, count(*) cnt, sum(wr_rec_quantity) rec_quan
FROM $ac_table
WHERE nxt_pgm_name in ('ICLISTENER','ICUSGMGR','ICRATER','UPRTUSAGE') and file_status <> 'CN'
HAVING sum(wr_rec_quantity) > 1000000
GROUP BY nxt_pgm_name, file_status
#;
    my $sth = $db->prepare($sql);
    $sth->execute();
    my $rows = $sth->fetchall_arrayref();
    foreach my $row (@$rows){
      if($first == 0){
        print ",\n";
      }else{
        $first=0;
      }
      print "{\"ac\":\"" . @$row[0] . "\",\"nxt_pgm_name\":\"" . @$row[1] . "\",\"file_status\":\"" . @$row[2] . "\",\"count\":\"" . @$row[3] . "\",\"quantity\":\"" . @$row[4] . "\"}";
  }
    $sth->finish;
  }
  $db->disconnect();
  print "]";
}


  

sub getConnectParams{
  my ($connectCode) = @_;
  
  my $user='prdappc';
  my $pass='PRMAPPC!22';
  my $instance='prmprd';

  return ($user,$pass,$instance);
}


exit(0);
