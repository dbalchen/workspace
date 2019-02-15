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

print "Last voice was on " . lastVoiceDate($customer_id,$usg_DB,$cycle_code,$instance). "\n";
voiceUsage($customer_id,$usg_DB,$cycle_code,$instance);
print "Last data was on " . lastDataDate($customer_id,$usg_DB,$cycle_code,$instance) . "\n";
dataUsage($customer_id,$usg_DB,$cycle_code,$instance);
msgUsage($customer_id,$usg_DB,$cycle_code,$instance);



cleanup($usg_DB,$cust_DB);


sub checkArgs{
  if (@ARGV != 2){
print @ARGV . "\n";
    print "Usage Finder\n";
    print "How to run:\n\t./usage_finder.pl <MDN> <CYCLE_INSTANCE>\n";
    exit 0;
  }
}

sub lastVoiceDate{
  my ($customer_id,$usg_DB,$cycle_code,$instance) = @_;
  my $sql = qq#select max(start_time) from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id=62#;
  my $sth = $usg_DB->prepare($sql);
  $sth->execute();
  my $date = $sth->fetchrow();
  return $date;
}

sub lastDataDate{
  my ($customer_id,$usg_DB,$cycle_code,$instance) = @_;
  my $sql =qq#select max(start_time) from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (51,69) and l3_rounded_unit <> 0#;
  my $sth = $usg_DB->prepare($sql);
  $sth->execute();
  my $date = $sth->fetchrow();
  return $date;
}


sub voiceUsage{
  my ($customer_id,$usg_DB,$cycle_code,$instance) = @_;
  my $usgSql = qq#with vals as (select $customer_id customer_id, $cycle_code cycle_code, $instance cycle_instance from dual)
select  subscriber_id,"Call Type", "Used mins", "Free mins", "Charged Mins", "Charge Amount" from(
select subscriber_id,'Charged usage' "Call Type",sum(l3_rounded_unit)  "Used mins",sum(L9_FREE_UNIT)  "Free mins", sum(l3_rounded_unit)-sum(l9_free_unit) "Charged Mins",sum(l3_charge_amount) "Charge Amount",5 "Num"
 from ape1_rated_Event a,vals
where a.customer_Id = vals.customer_id
and a.cycle_instance = vals.cycle_instance
and a.cycle_code=vals.cycle_code
and event_type_id=62
and event_state <> 'X'
and (service_filter not like '%M2M%' or service_filter like 'VOM2MOFF%')
and service_filter not like '%SPLNUMA%'
and service_filter not like '%CDLX%'
and l3_call_direction = 2   
and(trim(to_char(start_time, 'Day')) not in ('Saturday','Sunday')
and trim(to_char(start_time, 'HH24')) >= 7
and trim(to_char(start_time, 'HH24')) < 19)
group by subscriber_id
union
select subscriber_id,'M2M',sum(l3_rounded_unit)  "Used mins",sum(L9_FREE_UNIT)  "Free mins", sum(l3_rounded_unit)-sum(l9_free_unit) "Charged Mins",sum(l3_charge_amount) "Charge Amount",4
 from ape1_rated_Event a,vals
where a.customer_Id = vals.customer_id
and a.cycle_instance = vals.cycle_instance
and a.cycle_code=vals.cycle_code
and event_type_id=62
and event_state <> 'X'
and (service_filter  like '%M2M%' and  service_filter not like 'VOM2MOFF%')
and service_filter not like '%SPLNUMA%'
and service_filter not like '%CDLX%'
group by subscriber_id
union
select subscriber_id,'N/W',sum(l3_rounded_unit)  "Used mins",sum(L9_FREE_UNIT)  "Free mins", sum(l3_rounded_unit)-sum(l9_free_unit) "Charged Mins",sum(l3_charge_amount) "Charge Amount",3
 from ape1_rated_Event a,vals
where a.customer_Id = vals.customer_id
and a.cycle_instance = vals.cycle_instance
and a.cycle_code=vals.cycle_code
and event_type_id=62
and event_state <> 'X'
and( trim(to_char(start_time, 'Day'))  in ('Saturday','Sunday')
or trim(to_char(start_time, 'HH24')) < 7
or trim(to_char(start_time, 'HH24')) >= 19
)
and (service_filter not like '%M2M%' or service_filter like 'VOM2MOFF%')
and l3_call_direction=2
and service_filter not like '%CDLX%'
and service_filter not like '%SPLNUMA%'
group by subscriber_id
union
select subscriber_id,'Incoming',sum(l3_rounded_unit)  "Used mins",sum(L9_FREE_UNIT)  "Free mins", sum(l3_rounded_unit)-sum(l9_free_unit) "Charged Mins",sum(l3_charge_amount) "Charge Amount",2
 from ape1_rated_Event a,vals
where a.customer_Id = vals.customer_id
and a.cycle_instance = vals.cycle_instance
and a.cycle_code=vals.cycle_code
and event_type_id=62
and event_state <> 'X'
and l3_call_direction=1
and service_filter not like '%CDLX%'
and (service_filter not like '%M2M%' or service_filter like 'VOM2MOFF%')
and service_filter not like '%SPLNUMA%'
group by subscriber_id
union
select subscriber_id,'All',sum(l3_rounded_unit)  "Used mins",sum(L9_FREE_UNIT)  "Free mins", sum(l3_rounded_unit)-sum(l9_free_unit) "Charged  Mins",sum(l3_charge_amount) "Charge Amount",1
 from ape1_rated_Event a,vals
where a.customer_Id = vals.customer_id
and a.cycle_instance = vals.cycle_instance
and a.cycle_code=vals.cycle_code
and event_type_id=62
and event_state <>'X'
and service_filter not like '%CDLX%'
and service_filter not like '%SPLNUMA%'
group by subscriber_id
) order by subscriber_id,"Num"#;

  my $offerSql=qq# select distinct l3_offer_id from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (62)#;
  my $offerSth = $usg_DB->prepare($offerSql);
  $offerSth->execute();
  my @offers = ();
  while(my $offerRow = $offerSth->fetchrow()){
    push(@offers,$offerRow);
  }

  my $usgSth = $usg_DB->prepare($usgSql);
  $usgSth -> execute();
  my $currentSub = 0;

  print "Voice offers for customer $customer_id:\n";
  foreach $offer (@offers){
    print "\t$offer: ". getOfferName($offer) . "\n";
  }

  while(my @row = $usgSth->fetchrow_array()){
    if($row[0] ne $currentSub){
      print "Voice Usage for subscriber: $row[0]\n";
      print "\tUsage Type\tUsed Mins\tFree Mins\tCharged Mins\tCharge Amount\n";
      $currentSub = $row[0];
    }
    printf("\t%-14s",$row[1]);
    print "\t$row[2]\t";
    print "\t$row[3]\t";
    print "\t$row[4]\t";
    print "\t$row[5]\n";
  }
  $usgSth->finish;
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


sub msgUsage{
  my ($customer_id,$usg_DB,$cycle_code,$instance) = @_;
  my $usgSql = qq#--Query to get SMS and MMS bu subscriber
with vals as (select $customer_id customer_id, $cycle_code cycle_code,$instance cycle_instance from dual)
select subscriber_id,decode(event_type_id,54,'SMS',60,'MMS') "Event Type",sum(l3_rounded_unit) "Messages" ,sum(l3_charge_amount) "Charges"
from ape1_rated_event a,vals
where a.customer_id=vals.customer_id
and a.cycle_instance = vals.cycle_instance
and a.cycle_code=vals.cycle_code
and event_type_id in (54,60)
and event_state <> 'X'
group by subscriber_id,event_type_id
order by subscriber_id,"Event Type"#;

  my $usgSth = $usg_DB->prepare($usgSql);
  $usgSth -> execute();
  my $currentSub = 0;

  my $offerSql=qq# select distinct l3_offer_id from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (54,60)#;
  my $offerSth = $usg_DB->prepare($offerSql);
  $offerSth->execute();
  my @offers = ();
  while(my $offerRow = $offerSth->fetchrow()){
    push(@offers,$offerRow);
  }
  print "Message offers for customer $customer_id:\n";
  foreach $offer (@offers){
    print "\t$offer: ". getOfferName($offer) . "\n";
  }

  while(my @row = $usgSth->fetchrow_array()){
    if($row[0] ne $currentSub){
      print "Message Usage for subscriber: $row[0]\n";
      print "\tUsage Type\tSent Messages\tCharge Amount\n";
      $currentSub = $row[0];
    }
    printf("\t%-14s",$row[1]);
    print "\t$row[2]\t";
    print "\t$row[3]\n";
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

