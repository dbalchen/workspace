I used the wrong date ranges in the recalled email:  There is late usage billed every cycle using the given 30 day criteria.  The late usage below is 30 days outside the billing cycle, per the 60 day business rule.

SQL Statement which produced this data:
  select  /*+ parallel (16) */  distinct cycle_code, sum(l3_charge_amount) from ape1_rated_event
  where cycle_year = 2015
  and cycle_instance = 11
  and cycle_code = 2
  and trunc(start_time) between to_date('20150902','YYYYMMDD') and to_date('20151001','YYYYMMDD')
  group by cycle_code
  union
  select  /*+ parallel (16) */  distinct cycle_code, sum(l3_charge_amount) from ape1_rated_event
  where cycle_year = 2015
  and cycle_instance = 11
  and cycle_code = 4
  and trunc(start_time) between to_date('20150904','YYYYMMDD') and to_date('20151003','YYYYMMDD')
  group by cycle_code
  union
  select  /*+ parallel (16) */  distinct cycle_code, sum(l3_charge_amount) from ape1_rated_event
  where cycle_year = 2015
  and cycle_instance = 11
  and cycle_code = 6
  and trunc(start_time) between to_date('20150906','YYYYMMDD') and to_date('20151005','YYYYMMDD')
  group by cycle_code
  union
  select  /*+ parallel (16) */  distinct cycle_code, sum(l3_charge_amount) from ape1_rated_event
  where cycle_year = 2015
  and cycle_instance = 11
  and cycle_code = 8
  and trunc(start_time) between to_date('20150908','YYYYMMDD') and to_date('20151007','YYYYMMDD')
  group by cycle_code
  union
  select  /*+ parallel (16) */  distinct cycle_code, sum(l3_charge_amount) from ape1_rated_event
  where cycle_year = 2015
  and cycle_instance = 11
  and cycle_code = 10
  and trunc(start_time) between to_date('20150910','YYYYMMDD') and to_date('20151009','YYYYMMDD')
  group by cycle_code
  order by cycle_code
