#!/usr/bin/env perl

use lib '/pkgbl01/inf/aimsys/prdwrk1/steve/lib/site_perl/5.10.0/x86_64-linux-thread-multi';
use DBI;
use Carp qw (croak);

checkArgs();

my $mdn=$ARGV[0];
my $instance=$ARGV[1];


my ($customer_id,$subscriber_id,$cycle_code) = getCustInfo($mdn);
print "Cycle code for $customer_id is $cycle_code\n";
my $usg_DB = connectUsg($cycle_code);
my $cust_DB = connectCust();

dataUsage($customer_id,$usg_DB,$cycle_code,$instance);
#lastDataDate($customer_id,$usg_DB,$cycle_code,$instance);
cap_limits($customer_id,$cust_DB);
data_block($customer_id,$cust_DB);
trb_message($customer_id,$cust_DB);


cleanup($usg_DB,$cust_DB);


sub checkArgs{
  if (@ARGV != 2){
print @ARGV . "\n";
    print "Usage Finder\n";
    print "How to run:\n\t./usage_finder.pl <MDN> <CYCLE_INSTANCE>\n";
    exit 0;
  }
}


sub lastDataDate{
  my ($customer_id,$subscriber_id,$usg_DB,$cycle_code,$instance) = @_;
  my $sql =qq#select max(start_time),subscriber_id from ape1_rated_event where customer_id=$customer_id and subscriber_id=$subscriber_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (51,69) and l3_rounded_unit <> 0 group by subscriber_id#;
  my $sth = $usg_DB->prepare($sql);
  $sth->execute();
  while (my @row = $sth->fetchrow_array()){
    print "\tLast used data: " . $row[0] . "\n";
  }
  $sth->finish;
}


sub trb_message{
  my($customer_id,$cust_DB)=@_;

  my $sql = qq#
 select /*+PARALLEL(t,12)*/ sys_creation_date,substr(general_data,instr(general_data,'<SubscriberID>')+14,9) from prdcustc.TRB1_MST_LOG t 
 where entity_id=? and actv_code_id=5095 
 and general_data like '%<ActivityReason>Is Barred</ActivityReason>%'
 order by substr(general_data,instr(general_data,'<SubscriberID>')+14,9),sys_creation_date
#;

  my $sth=$cust_DB->prepare($sql);
  $sth->execute($customer_id);
  my $currentSub = 0;
  while(my @row = $sth->fetchrow_array()){
    if($row[1] ne $currentSub){
      print "TRB Messages for subscriber: $row[1]\n";
      $currentSub=$row[1];
    }
    print "\tSent on " . $row[0] . "\n";
  }
  $sth->finish;

}
sub cap_limits{
  my($customer_id,$cust_DB)=@_;

  my $sql = qq#select agreement_no,param_name,param_values,effective_date,expiration_date
 from prdcustc.cm1_agreement_param where param_name in ('Cap limit volume') 
and agreement_no in (select subscriber_no from prdcustc.subscriber where sub_status='A' and customer_id=?) order by agreement_no,effective_date#;

  my $sth=$cust_DB->prepare($sql);
  $sth->execute($customer_id);
  my $currentSub = 0;
  while(my @row = $sth->fetchrow_array()){
    if($row[0] ne $currentSub){
      print "Cap Limits for subscriber: $row[0]\n";
      print "\tLimit\tEffective Date\tExpiration Date\n";
      $currentSub = $row[0];
    }
    print "\t" . $row[2];
    print "\t" . $row[3];
    print "\t" . $row[4] . "\n";
  }
  $sth->finish;
}
    
sub data_block{
  my($customer_id,$cust_DB)=@_;

  my $sql = qq#select agreement_no,param_name,param_values,effective_date,expiration_date
 from prdcustc.cm1_agreement_param where param_name in ('Is Barred')
and agreement_no in (select subscriber_no from prdcustc.subscriber where sub_status='A' and customer_id=?) order by agreement_no,effective_date#;
  my $sth=$cust_DB->prepare($sql);
  $sth->execute($customer_id);
  my $currentSub = 0;
  while(my @row = $sth->fetchrow_array()){
    if($row[0] ne $currentSub){
      print "Data Block for subscriber: $row[0]\n";
      print "\tBlocked?\tEffective Date\tExpiration Date\n";
      $currentSub = $row[0];
    }
    print "\t" . $row[2];
    print "\t\t" . $row[3];
    print "\t" . $row[4] . "\n";
  }
  $sth->finish;
}

 


sub dataUsage{
  my ($customer_id,$usg_DB,$cycle_code,$instance) = @_;
  my $usgSql = qq#--Get Usage for data by subscriber
with vals as (select $customer_id customer_id, $cycle_code cycle_code,$instance cycle_instance from dual)
select * from(
select subscriber_id,decode(event_type_id,51,'3G',69,'LTE') "Event Type",sum(l3_rounded_unit)/1024 "Used MB",sum(l9_free_unit)/1024 "Free MB", sum(l3_rounded_unit)/1024-sum(l9_free_unit)/1024 "MB Charged",sum(l3_charge_amount) "Charged Amount"
from ape1_rated_event a, vals
where a.customer_id=vals.customer_id
and a.cycle_instance = vals.cycle_instance
and a.cycle_code=vals.cycle_code
and event_type_id in (51,69)
and event_state <> 'X'
and l3_rounded_unit <> 0
group by subscriber_id, event_type_id
 union
select subscriber_id,'Total' "Event Type",sum(l3_rounded_unit)/1024 "Used MB",sum(l9_free_unit)/1024 "Free MB", sum(l3_rounded_unit)/1024-sum(l9_free_unit)/1024 "MB Charged",sum(l3_charge_amount) "Charged Amount"
from ape1_rated_event a, vals
where a.customer_id=vals.customer_id
and a.cycle_instance = vals.cycle_instance
and a.cycle_code=vals.cycle_code
and event_type_id in (51,69)
and event_state <> 'X'
and l3_rounded_unit <> 0
 group by subscriber_id
 )
order by subscriber_id,"Event Type" #;

  my $usgSth = $usg_DB->prepare($usgSql);
  $usgSth -> execute();
  my $currentSub = 0;

  my $offerSql=qq# select distinct l3_offer_id from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (51,69)#;
  my $offerSth = $usg_DB->prepare($offerSql);
  $offerSth->execute();
  my @offers = ();
  while(my $offerRow = $offerSth->fetchrow()){
    push(@offers,$offerRow);
  }
  print "Data offers for customer $customer_id:\n";
  foreach $offer (@offers){
    print "\t$offer: ". getOfferName($offer) . "\n";
  }

  while(my @row = $usgSth->fetchrow_array()){
    if($row[0] ne $currentSub){
      print "Data Usage for subscriber: $row[0]\n";
      lastDataDate($customer_id,$row[0],$usg_DB,$cycle_code,$instance);
      print "\tUsage Type\tUsed MB\t\tFree MB\t\tCharged MB\tCharge Amount\n";
      $currentSub = $row[0];
    }
    printf("\t%-14s",$row[1]);
    printf("\t%.2f\t",$row[2]);
    printf("\t%.2f\t",$row[3]);
    printf("\t%.2f\t",$row[4]);
    printf("\t%.2f\n",$row[5]);
  }
  $usgSth->finish;
}



sub getCustInfo{
  my ($user,$pass,$instance) = getConnectParams("PRDAFCAPP");
  my $db = DBI->connect("dbi:Oracle:prdaf",$user,$pass);
  $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDAFC");
  my $sql = qq# select * from (
	 	select customer_id,subscriber_id,bill_cycle from agd1_resources
                where resource_value = ? and resource_type = 0
                and sub_status='A'  order by expiration_date desc 
                ) where rownum =1
		#;
  my $sth = $db->prepare($sql);
  $sth->execute($mdn);
  my @row = $sth->fetchrow_array();
  return @row;
}


sub getOfferName{
  my ($offer_id)=@_;
  $offerLookup{6605775}="Postpaid Market Level Offers";
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

sub connectUsg{
  my ($cycle_code) = @_;
  my $db;

  if ($cycle_code == 2 or $cycle_code == 8 or $cycle_code == 20 or $cycle_code == 1004 or $cycle_code == 1006 or $cycle_code==1014 or $cycle_code==1024){
  my ($user,$pass,$instance) = getConnectParams("PRDUSG1");
    $db = DBI->connect("dbi:Oracle:prdusg1",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG1C");
    print "Connected to Usage 1\n";
  }elsif($cycle_code == 12 or $cycle_code == 18 or $cycle_code == 22 or $cycle_code==1002 or $cycle_code==1010 or $cycle_code==1016 or $cycle_code==1028){
  my ($user,$pass,$instance) = getConnectParams("PRDUSG2");
    $db = DBI->connect("dbi:Oracle:prdusg2",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG2C");
    print "Connected to Usage 2\n";
  }elsif($cycle_code == 10 or $cycle_code==16 or $cycle_code==24 or $cycle_code==28 or $cycle_code==1008 or $cycle_code==1020 or $cycle_code==1022){
  my ($user,$pass,$instance) = getConnectParams("PRDUSG3");
    $db = DBI->connect("dbi:Oracle:prdusg3",$user,$pass);
    $db->do("ALTER SESSION SET CURRENT_SCHEMA = PRDUSG3C");
    print "Connected to Usage 3\n";
  }elsif($cycle_code == 4 or $cycle_code == 6 or $cycle_code == 14 or $cycle_code == 26 or $cycle_code=1012 or $cycle_code=1018 or $cycle_code==1026){
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

