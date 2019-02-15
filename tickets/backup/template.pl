#!/usr/bin/env perl

use lib '/pkgbl01/inf/aimsys/prdwrk1/steve/lib/site_perl/5.10.0/x86_64-linux-thread-multi';
use DBI;
use Carp qw (croak);

checkArgs();
my $user=$ARGV[0];
my $pass=$ARGV[1];
my $mdn=$ARGV[2];


my ($customer_id,$subscriber_id,$cycle_code) = getCustInfo($mdn);
my $usg_DB = connectUsg($cycle_code);
my $cust_DB = connectCust();



cleanup($usg_DB,$cust_DB);




sub checkArgs{
  if (@ARGV != 4){
    print "NAME\n";
    print "How to run:\n\t./NAME.pl <DB_USERNAME> <DB_PASSWORD> <MDN> <CYCLE_INSTANCE>\n";
    exit 0;
  }
}


sub getCustInfo{
  my $db = DBI->connect("dbi:Oracle:prdaf",$user,$pass);
  $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDAFC");
  my $sql = qq# select customer_id,subscriber_id,bill_cycle from agd1_resources
		where resource_value = ? and resource_type = 0
		and sub_status='A' and expiration_date > sysdate+100
		#;
  my $sth = $db->prepare($sql);
  $sth->execute($mdn);
  my @row = $sth->fetchrow_array();
  return @row;
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


