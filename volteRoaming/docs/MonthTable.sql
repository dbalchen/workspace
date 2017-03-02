Incollect LTE

select /*+ PARALLEL(t1,12) */ 'Settlement',serving_bid, 'LTE', 'Incollect','Data','',sum(charge_amount), carrier_cd, bp_start_date from prm_rom_incol_events_ap t1 
where   (process_date >= to_date('20170101', 'YYYYMMDD') and process_date <= to_date('20170131', 'YYYYMMDD'))and carrier_cd != 'NLDLT' group by serving_bid,carrier_cd, bp_start_date


Incollect GSM

select /*+ PARALLEL(t1,12) */ 'Settlement',serving_bid, 'GSM', 'Incollect',charge_type,'',sum(charge_amount), carrier_cd, bp_start_date from prm_rom_incol_events_ap t1  where   (process_date >= to_date('20170101', 'YYYYMMDD') and process_date <= to_date('20170131', 'YYYYMMDD'))and carrier_cd = 'NLDLT' group by serving_bid,carrier_cd, bp_start_date, charge_type


Outcollect LTE
select /*+ PARALLEL(t1,12) */ 'Settlement', home_bid, 'LTE','Outcollect','DATA', carrier_cd,  count(*), sum(tot_net_charge_lc),bp_start_date from prm_rom_outcol_events_ap t1 where (process_date >= to_date('20170101', 'YYYYMMDD') and process_date <= to_date('20170131', 'YYYYMMDD')) and carrier_cd != 'NLDLT' group by  home_bid,carrier_cd, bp_start_date


Incollect Voice Settlement:
select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'SDIRI_FCIBER_ID(.*)_T2017011[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'SDIRI_FCIBER_ID%T2017012%'
	     or  ciber_file_name_1 like 'SDIRI_FCIBER_ID%T2017013%'
	     or ciber_file_name_1 like 'SDIRI_FCIBER_ID%T2017020%'
	     or REGEXP_LIKE (ciber_file_name_1, 'SDIRI_FCIBER_ID(.*)_T2017021[0,1,2,3,4,5](.*)'))
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date;


Incollect Voice Accrual:
select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'SDIRI_FCIBER_ID(.*)_T2017011[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'SDIRI_FCIBER_ID%T2017012%'
	     or  ciber_file_name_1 like 'SDIRI_FCIBER_ID%T2017013%')
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date;


Incollect Data Settlement:
select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Incollect','Data',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'SDATACBR_FDATACBR_ID(.*)_T2017011[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T2017012%'
	     or  ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T2017013%'
	     or ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T2017020%'
	     or REGEXP_LIKE (ciber_file_name_1, 'SDATACBR_FDATACBR_ID(.*)_T2017021[0,1,2,3,4,5](.*)'))
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date;

Incollect Voice Accrual:
select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Incollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'SDATACBR_FDATACBR_ID(.*)_T2017011[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T2017012%'
	     or  ciber_file_name_1 like 'SDATACBR_FDATACBR_ID%T2017013%')
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date;

Outcollect Voice Settlement:
select  /*+ PARALLEL(h1,12) */  'Settlement', serve_sid,'CDMA','Outcollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'CIBER_CIBER(.*)_2017011[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'CIBER_CIBER%2017012%'
	     or  ciber_file_name_1 like 'CIBER_CIBER%2017013%'
	     or ciber_file_name_1 like 'CIBER_CIBER%2017020%'
	     or REGEXP_LIKE (ciber_file_name_1, 'CIBER_CIBER(.*)_2017021[0,1,2,3,4,5](.*)'))
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date;

Outcollect Voice Accrual:
select  /*+ PARALLEL(h1,12) */  'Accural', serve_sid,'CDMA','Outcollect','Voice',sum(TOTAL_CHRG_AMOUNT),carrier_cd, bp_start_date from USC_ROAM_EVNTS where
(REGEXP_LIKE (ciber_file_name_1, 'CIBER_CIBER(.*)_2017011[6,7,8,9](.*)')
	     or ciber_file_name_1 like 'CIBER_CIBER%2017012%'
	     or  ciber_file_name_1 like 'CIBER_CIBER%2017013%')
 and generated_rec < 2 
 group by serve_sid,carrier_cd, bp_start_date;

Outcollect Data Settlement

 select  /*+ PARALLEL(h1,12) */ 'Settlement','','CDMA','Outcollect','Data',  sum(t1.amount), TRIM(REGEXP_REPLACE(t1.PARTNER,',')) as PARTNER, ADD_MONTHS(t1.settlement_date+1,-1)
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and (t1.process_date >= to_date('20170116', 'YYYYMMDD') and t1.process_date <= to_date('20170215', 'YYYYMMDD'))
         group by TRIM(REGEXP_REPLACE(t1.PARTNER,',')),t1.settlement_date order by 1,2

 select  /*+ PARALLEL(h1,12) */ 'Accrual','','CDMA','Outcollect','Data',  sum(t1.amount), TRIM(REGEXP_REPLACE(t1.PARTNER,',')) as PARTNER, ADD_MONTHS(t1.settlement_date+1,-1)
         from data_outcollect t1, roaming_partner t2 where TRIM(REGEXP_REPLACE(t1.PARTNER,',')) = TRIM(REGEXP_REPLACE(t2.PARTNER,',')) 
         and (t1.process_date >= to_date('20170116', 'YYYYMMDD') and t1.process_date <= to_date('20170131', 'YYYYMMDD'))
         group by TRIM(REGEXP_REPLACE(t1.PARTNER,',')),t1.settlement_date order by 1,2


=====================================================================================================================================================================================


