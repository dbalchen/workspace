#!/usr/local/bin/perl

use DBI;
use Carp qw (croak);

## For test only....
#my $ORACLE_HOME = "/usr/lib/oracle/12.1/client/";
#my $ORACLE_SID  = "bodsprd";
#$ENV{ORACLE_HOME} = $ORACLE_HOME;
#$ENV{ORACLE_SID}  = $ORACLE_SID;
#$ENV{PATH}        = "$ENV{PATH}:$ORACLE_HOME/bin";

checkArgs();

my $mdn = $ARGV[0];
# $mdn = '6085761900';
my $instance = $ARGV[1];
# $instance = 1;

my $db = getBODSPRD();

my ( $customer_id, $subscriber_id, $cycle_code ) = getCustInfo( $mdn, $db );

print "Cycle code for $customer_id is $cycle_code\n";

print "Last voice was on "
  . lastVoiceDate( $customer_id, $db, $cycle_code, $instance ) . "\n";
voiceUsage( $customer_id, $db, $cycle_code, $instance );

print "Last data was on "
  . lastDataDate( $customer_id, $db, $cycle_code, $instance ) . "\n";
dataUsage( $customer_id, $db, $cycle_code, $instance );

msgUsage( $customer_id, $db, $cycle_code, $instance );

$db->disconnect();

exit(0);

sub checkArgs {
	if ( @ARGV != 2 ) {
		print @ARGV . "\n";
		print "Usage Finder\n";
		print "How to run:\n\t./usage_finder.pl <MDN> <CYCLE_INSTANCE>\n";
		exit 0;
	}
}

sub lastVoiceDate {
	my ( $customer_id, $usg_DB, $cycle_code, $instance ) = @_;
	my $sql =
qq#select max(start_time) from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id=62#;
	my $sth = $usg_DB->prepare($sql);
	$sth->execute();
	my $date = $sth->fetchrow();
	return $date;
}

sub lastDataDate {
	my ( $customer_id, $usg_DB, $cycle_code, $instance ) = @_;
	my $sql =
qq#select max(start_time) from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (51,69) and l3_rounded_unit <> 0#;
	my $sth = $usg_DB->prepare($sql);
	$sth->execute();
	my $date = $sth->fetchrow();
	return $date;
}

sub voiceUsage {
	my ( $customer_id, $usg_DB, $cycle_code, $instance ) = @_;
	my $usgSql =
qq#with vals as (select $customer_id customer_id, $cycle_code cycle_code, $instance cycle_instance from dual)
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

	my $offerSql =
qq# select distinct l3_offer_id from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (62)#;
	my $offerSth = $usg_DB->prepare($offerSql);
	$offerSth->execute();
	my @offers = ();
	while ( my $offerRow = $offerSth->fetchrow() ) {
		push( @offers, $offerRow );
	}

	my $usgSth = $usg_DB->prepare($usgSql);
	$usgSth->execute();
	my $currentSub = 0;

	print "Voice offers for customer $customer_id:\n";
	foreach $offer (@offers) {
		print "\t$offer: " . getOfferName( $offer, $usg_DB ) . "\n";
	}

	while ( my @row = $usgSth->fetchrow_array() ) {
		if ( $row[0] ne $currentSub ) {
			print "Voice Usage for subscriber: $row[0]\n";
			print
"\tUsage Type\tUsed Mins\tFree Mins\tCharged Mins\tCharge Amount\n";
			$currentSub = $row[0];
		}
		printf( "\t%-14s", $row[1] );
		print "\t$row[2]\t";
		print "\t$row[3]\t";
		print "\t$row[4]\t";
		print "\t$row[5]\n";
	}
	$usgSth->finish;
}

sub dataUsage {
	my ( $customer_id, $usg_DB, $cycle_code, $instance ) = @_;
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
	$usgSth->execute();
	my $currentSub = 0;

	my $offerSql =
qq# select distinct l3_offer_id from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (51,69)#;
	my $offerSth = $usg_DB->prepare($offerSql);
	$offerSth->execute();
	my @offers = ();
	while ( my $offerRow = $offerSth->fetchrow() ) {
		push( @offers, $offerRow );
	}
	print "Data offers for customer $customer_id:\n";
	foreach $offer (@offers) {
		print "\t$offer: " . getOfferName( $offer, $usg_DB ) . "\n";
	}

	while ( my @row = $usgSth->fetchrow_array() ) {
		if ( $row[0] ne $currentSub ) {
			print "Data Usage for subscriber: $row[0]\n";
			print
			  "\tUsage Type\tUsed MB\t\tFree MB\t\tCharged MB\tCharge Amount\n";
			$currentSub = $row[0];
		}
		printf( "\t%-14s",  $row[1] );
		printf( "\t%.2f\t", $row[2] );
		printf( "\t%.2f\t", $row[3] );
		printf( "\t%.2f\t", $row[4] );
		printf( "\t%.2f\n", $row[5] );
	}
	$usgSth->finish;
}

sub msgUsage {
	my ( $customer_id, $usg_DB, $cycle_code, $instance ) = @_;
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
	$usgSth->execute();
	my $currentSub = 0;

	my $offerSql =
qq# select distinct l3_offer_id from ape1_rated_event where customer_id=$customer_id and cycle_code=$cycle_code and cycle_instance=$instance and event_type_id in (54,60)#;
	my $offerSth = $usg_DB->prepare($offerSql);
	$offerSth->execute();
	my @offers = ();
	while ( my $offerRow = $offerSth->fetchrow() ) {
		push( @offers, $offerRow );
	}
	print "Message offers for customer $customer_id:\n";
	foreach $offer (@offers) {
		print "\t$offer: " . getOfferName( $offer, $usg_DB ) . "\n";
	}

	while ( my @row = $usgSth->fetchrow_array() ) {
		if ( $row[0] ne $currentSub ) {
			print "Message Usage for subscriber: $row[0]\n";
			print "\tUsage Type\tSent Messages\tCharge Amount\n";
			$currentSub = $row[0];
		}
		printf( "\t%-14s", $row[1] );
		print "\t$row[2]\t";
		print "\t$row[3]\n";
	}
	$usgSth->finish;
}

sub getCustInfo {

	my ( $mdn, $db ) = @_;

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

sub getOfferName {
	my ( $offer_id, $cust_DB ) = @_;
	$offerLookup{6605775} = "Postpaid Market Level Offers";
	my $offerName;
	if ( defined( $offerLookup{$offer_id} ) ) {
		$offerName = $offerLookup{$offer_id};
	}
	else {
		my $offerSql =
		  qq# select soc_name from csm_offer where soc_cd=$offer_id#;
		my $offerSth = $cust_DB->prepare($offerSql);
		$offerSth->execute();
		$offerName = $offerSth->fetchrow();
		$offerLookup{$offer_id} = $offerName;
	}
	return $offerName;
}

sub getBODSPRD {
	my $dbPwd = " BODS_SVC_BILLINGOPS ";
	my $dbods = ( DBI->connect( "DBI:Oracle:$dbPwd",, ) );
#	my $dbods = DBI->connect( "dbi:Oracle:bodsprd", "md1dbal1", "Potat000#" );
	
	unless ( defined $dbods ) {
		sendErr();
	}
	return $dbods;
}
