#!/usr/bin/env perl

# use lib '/pkgbl01/inf/aimsys/prdwrk1/steve/lib/site_perl/5.10.0/x86_64-linux-thread-multi';
use DBI;
use Carp qw (croak);

#checkArgs();

my $mdn=$ARGV[0];
my $instance=$ARGV[1];


my ($customer_id,$subscriber_id,$cycle_code) = getCustInfo($mdn);
print "Cycle code for $customer_id is $cycle_code\n";
my $usg_DB = connectUsg($cycle_code);
my $cust_DB = connectCust();
my $ann_date = getAnnDate($subscriber_id,$cust_DB);
getBalanceInfo($customer_id,$usg_DB,$cycle_code);
getOfferInfo($subscriber_id,$usg_DB);
#getUsageOverPeriod($customer_id,$subscriber_id,$cycle_code,$usg_DB,$ann_date,3);
getUsageOverPeriod($customer_id,$subscriber_id,$cycle_code,$usg_DB,$ann_date,2);
getUsageOverPeriod($customer_id,$subscriber_id,$cycle_code,$usg_DB,$ann_date,1);
getUsageOverPeriod($customer_id,$subscriber_id,$cycle_code,$usg_DB,$ann_date,0);

cleanup($usg_DB,$cust_DB);

sub getOfferInfo{
  my ($subscriber_id,$usg_DB)=@_;
  
  my $offerSql=qq#select distinct a1.offer_id,a3.offer_name
   from ape1_subscr_offers a1, ape3_epcext_offers a3
   where subscriber_id=? and a1.offer_exp_date is null
   and a1.offer_id=a3.offer_id#;
   
  my $sth=$usg_DB->prepare($offerSql);
  $sth->execute($subscriber_id);
  
  print "Offers for $subscriber_id:\n";
  print "\tOffer ID\tOffer Name\n";
  while(my ($offer_id,$offer_name) = $sth->fetchrow_array()){
    print "\t$offer_id\t\t$offer_name\n"
  }
}

sub getUsageOverPeriod{
  my ($customer_id,$subscriber_id,$cycle_code,$usg_DB,$date,$month_shift) =@_;
  
  my ($beginDate,$endDate) = calcDate($date,$month_shift);
  
  my $usageSQL=qq#select event_type_id,sum(l3_rounded_unit),sum(l9_free_unit),sum(l3_charge_amount) from ape1_rated_event 
  where customer_id=? and subscriber_id=?
  and cycle_code=?
  and start_time >=to_date(?,'YYYY-MM-DD HH24:MI:SS')
  and start_time <=to_date(?,'YYYY-MM-DD HH24:MI:SS')
  and event_type_id in (51,54,60,62,69)
  group by event_type_id order by event_type_id#;
  
  my $sth=$usg_DB->prepare($usageSQL);
  $sth->execute($customer_id,$subscriber_id,$cycle_code,$beginDate,$endDate);
  print "Usage over period $beginDate to $endDate\n";
  print "\tEvent Type\tUsed\t\tPlan\t\tCharge Amount\n";
  while(my ($event,$used,$plan,$charge) = $sth->fetchrow_array()){
    print "\t$event\t\t$used\t\t$plan\t\t$charge\n";
  }
  
}

sub calcDate{
  my ($date,$month_shift) = @_;
  
  my $curDay=`date +"%d"`;
  chomp($curDay);
  my $curMonth=`date +"%m"`;
  chomp($curMonth);
  my $curYear=`date +"%Y"`;
  chomp($curYear);
  
  my $beginDate=$date;
  my $endDate=$date;
 
  substr($beginDate,0,4) = $curYear;
  substr($beginDate,5,2) = $curMonth-$month_shift;

  if(substr($beginDate,5,2) == 0){
    substr($beginDate,5,2) = '12-';
    substr($beginDate,0,4) = $curYear-1;
  }
  if(substr($beginDate,5,2) < 10){
    substr($beginDate,5,1)='0'. substr($beginDate,5,1) ;
  }

  substr($endDate,0,4) = '2014';
  
  substr($endDate,5,2) = $curMonth-$month_shift+1;
  if(substr($endDate,5,2) < 10){
    substr($endDate,5,1)='0'. substr($endDate,5,1) ;
  }
  if(substr($endDate,5,2) == 13){
    substr($endDate,5,2) = '01';
    substr($endDate,0,4) = $curYear + 1;
  }
  return ($beginDate,$endDate);
}
  

sub getBalanceInfo{
  my ($customer_id,$usg_DB,$cycle_code) = @_;
  
  my $balanceSQL= qq#  select offer_exp_date,l3_balance_status,l3_balance_amount from ape1_accumulators
					where customer_id=? and cycle_code=?
					and offer_instance=-1#;
  my $sth = $usg_DB->prepare($balanceSQL);
  $sth->execute($customer_id,$cycle_code);
  my ($date,$status,$amount) = $sth->fetchrow();
  print "Balance information for $customer_id:\n\tExpiration Date: $date\n\tBalance Status: $status\n\tBalance Amount: $amount\n";
  
}

sub getAnnDate{
  my ($subscriber_id,$cust_DB) = @_;
  
  my $annSQL= qq#select  to_char(to_date(param_values,'YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') from cm1_agreement_param where agreement_no=?
					and param_name='Anniversary date' and expiration_date is null#;
					
  my $sth = $cust_DB->prepare($annSQL);
  $sth->execute($subscriber_id);
  my $date = $sth->fetchrow();
  
  print "Anniversary date\n\t$subscriber_id: $date\n";
  return $date;
}

sub checkArgs{
  if (@ARGV != 1){
print @ARGV . "\n";
    print "Prepaid\n";
    print "How to run:\n\t./prepaid.pl <MDN> \n";
    exit 0;
  }
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

