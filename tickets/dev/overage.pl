#!/usr/bin/env perl

use lib '/pkgbl01/inf/aimsys/prdwrk1/steve/lib/site_perl/5.10.0/x86_64-linux-thread-multi';
use DBI;
use Carp qw (croak);

checkArgs();
my $mdn=$ARGV[0];
my $instance=$ARGV[1];

my %offerLookup=();


my ($customer_id,$subscriber_id,$cycle_code) = getCustInfo($mdn);
my $usg_DB = connectUsg($cycle_code);
my $cust_DB = connectCust();


accumUsage($customer_id,$usg_DB,$cycle_code,$instance);
checkParams($subscriber_id,$usg_DB,$cust_DB);

cleanup($usg_DB,$cust_DB);


sub checkArgs{
  if (@ARGV != 2){
    print "Overage\n";
    print "How to run:\n\t./overage.pl <MDN> <CYCLE_INSTANCE>\n";
    exit 0;
  }
}


sub checkParams{
  my ($subscriber_id,$usg_DB,$cust_DB) = @_;
 
  my $offersSql = qq# select offer_id,offer_instance,source_offer_agr_id,source_offer_instance 
		from ape1_subscr_offers 
		where subscriber_id=$subscriber_id and offer_exp_date is null and offer_id not in (1474696)#;
  my $paramsSql = qq#select param_name,param_values from cm1_agreement_param
     where offer_instance_id=?
     and agreement_no=? and expiration_date is null and param_name like 'Get%'#;

  my $offersSth = $usg_DB->prepare($offersSql);
  my $paramSth = $cust_DB->prepare($paramsSql);
  $offersSth->execute();
  while(my @row = $offersSth->fetchrow_array()){
    print "execute: $row[1] \t $subscriber_id\n";
    $paramSth->execute($row[1],$subscriber_id);
    my $paramRows = $paramSth->fetchall_arrayref();
    if(@$paramRows > 0){
      print "Settings for subscriber: $subscriber_id offer id: $row[0] offer name: " . getOfferName($row[0]) . "\n";
      foreach my $paramRow (@$paramRows){
        print "\t@$paramRow[0]\t@$paramRow[1]\n";
      }
      if($row[1] ne $row[3]){
        $paramSth->execute($row[3],$row[2]);
        my $paramRows = $paramSth->fetchall_arrayref();
        if(@$paramRows > 0){
          print "Settings for agreement level subscriber: $row[2] offer id: $row[0] offer name: " . getOfferName($row[0]) . "\n";
          print "These settings must be set to 'A' for individual subscriber to get message\n";
          foreach $paramRow (@$paramRows){
            print "\t@$paramRow[0]\t@$paramRow[1]\n";
          }
        }else{
	  print "The agreement level subscriber should have rows in cm1_agreement_param for offer_id: $row[0] and offer_instance: $row[4] but doesn't appear to, please check\n";
        }
      }
      print "\n----------------------------------------------\n";
    }else{
      print "No overage entries fround in cm1_agreement_param\n";
    }
  }
  print "This only reflects current settings\n";
  print "\n\n";
}

sub accumUsage{
  my ($customer_id,$usg_DB,$cycle_code,$instance) = @_;

  my $accSql=qq/ select owner_id,offer_id,l9_unlimited_ind,l9_first_threshold,l9_first_threshold_sent_ind,l9_second_threshold,l9_second_threshold_sent_ind,l9_notified_ctn,
    replace(substr(quota_per_period,instr(quota_per_period,'#=',-1)+2),';','') "Usage per period",
    replace(substr(utilize_quota_per_month_period,instr(utilize_quota_per_month_period,'#=',-1)+2),';','') "Used usage per period",uom
     from ape1_accumulators aa
where aa.customer_id=$customer_id
and aa.cycle_code = $cycle_code
and aa.cycle_instance =$instance
and quota_per_period is not null
and offer_id <> 0
order by owner_id,offer_id/;

  my $accSth=$usg_DB->prepare($accSql);
  $accSth->execute();
  my $currentSub = 0;

  while(my @row = $accSth->fetchrow_array()){
    if($row[0] ne $currentSub){
      print "Overage for subscriber: $row[0]\n";
      printf("\t%10s\t%55s\tFirst Message?\tSecond Message?\tNotified CTN\tUsage for period\tUsed usage\tUOM\n","Offer id", "Offer Name");
      $currentSub=$row[0];
    }
    printf("\t%10s\t%55s\t%14s\t%15s\t%12s\t%16s\t%10s\t%3s\n",$row[1],getOfferName($row[1]),$row[4],$row[6],$row[7],$row[8],$row[9],$row[10]);
  }
  print "\n\n";
}

sub getOfferName{
  my ($offer_id)=@_;
  my $offerName;
  if(defined($offerLookup{$offer_id})){
    $offerName = $offerLookup{$offer_id};
  }else{
    my $offerSql = qq# select soc_name from csm_offer where soc_cd=$offer_id#;
    my $offerSth = $cust_DB->prepare($offerSql);
    $offerSth->execute();
    $offerName = $offerSth->fetchrow();
    $offerLookup{$offer_id}=$offerName;
  }
  return $offerName;
}
  


sub getCustInfo{
    my ($user,$pass,$instance) = getConnectParams("PRDAFCAPP");
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
    my ($user,$pass,$instance) = getConnectParams("PRDUSG1");
    $db = DBI->connect("dbi:Oracle:prdusg1",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG1C");
    print "Connected to Usage 1\n";
  }elsif($cycle_code == 12 or $cycle_code == 18 or $cycle_code == 22){
    my ($user,$pass,$instance) = getConnectParams("PRDUSG2");
    $db = DBI->connect("dbi:Oracle:prdusg2",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG2C");
    print "Connected to Usage 2\n";
  }elsif($cycle_code == 10 or $cycle_code==16 or $cycle_code==24 or $cycle_code==28){
    my ($user,$pass,$instance) = getConnectParams("PRDUSG3");
    $db = DBI->connect("dbi:Oracle:prdusg3",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG3C");
    print "Connected to Usage 3\n";
  }elsif($cycle_code == 4 or $cycle_code == 6 or $cycle_code == 14 or $cycle_code == 26){
    my ($user,$pass,$instance) = getConnectParams("PRDUSG4");
    $db = DBI->connect("dbi:Oracle:prdusg4",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG4C");
    print "Connected to Usage 4\n";
  }else{
    croak "Incorrect cycle code: $cycle_code\n";
  }
  return $db;
}

sub connectCust{
    my ($user,$pass,$instance) = getConnectParams("PRDAPP");
  my $db = DBI->connect("dbi:Oracle:prdcust",$user,$pass);
  $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDCUSTC");

  return $db;
}

sub cleanup{
  $usg_DB->disconnect() if defined($usg_DB);
  $cust_DB->disconnect() if defined($cust_DB);
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

