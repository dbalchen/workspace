---- Counting Voice events in TC

--- Get the file Identifiers for settlement Period (A settlement period is between 16th and 15th of the next month (Ex. April 16th - May 15th)

select file_name, identifier from ac1_control_hist where file_name like 'SDIRI_FCIBER%YYYYMMDD%.DAT'; YYYY = Year, MM = Month DD = Day)


--TC_AF_IN (Turbo Charging AnF input)
select sum(in_rec_quantity) from ac1_control_hist where phy_file_ident = 518721734281200
and cur_pgm_name = 'LSN' and cur_file_alias = 'CIBER' and nxt_pgm_name = 'SPL' and nxt_file_alias = 'CIBER';

--TC_AF_DROP (Dropped by AnF)
select sum(wr_rec_quantity) from ac1_control_hist where phy_file_ident = 518721734281200
and cur_pgm_name = 'SPL' and cur_file_alias = 'CBR_DRP' and nxt_pgm_name = 'NONE' and nxt_file_alias = 'CBR_DRP';

--TC_AF_DUP (Dropped by AnF as duplicates)
select sum(wr_rec_quantity) from ac1_control_hist where phy_file_ident = 518721734281200
and cur_pgm_name = 'MD' and cur_file_alias = 'CIBER_DUP' and nxt_pgm_name = 'MD' and nxt_file_alias = 'CIBER_DUP';

--TC_ES_IN (Turbo Charging Event Server input)
select sum(in_rec_quantity) from ac1_control_hist where phy_file_ident = 518721734281200
and cur_pgm_name||'|'||cur_file_alias||'|'||nxt_pgm_name||'|'||nxt_file_alias in ('MD|TCUSAGE|File2E|Diameter','File2E|Diameter|File2E|Diameter');

--TC_ES_DROP (Dropped by Event Server)
select sum(dr_rec_quantity) from ac1_control_hist where phy_file_ident = 518721734281200
and cur_pgm_name||'|'||cur_file_alias||'|'||nxt_pgm_name||'|'||nxt_file_alias in ('MD|TCUSAGE|File2E|Diameter','File2E|Diameter|File2E|Diameter');

--TC_ES_REJ (Rejected by Event Server)
select sum(wr_rec_quantity) from ac1_control_hist where phy_file_ident = 518721734281200
and cur_pgm_name = 'File2E' and cur_file_alias = 'Diameter' and nxt_pgm_name = 'NONE' and nxt_file_alias = 'REJECT';

-- TC Rejected Records per file

select l9_channel, original_event_id, error_id, max(l9_original_air_time_chg_amt)  from ape1_rejected_event where original_event_id in 
(select unique(original_event_id) from ape1_rejected_event where physical_source = 518721734281200) 
and processing_status = 'CO' and event_id = original_event_id group by  original_event_id, l9_channel, error_id;

--TC_ES_DUP (Dropped by Event Server as duplicate)
select sum(wr_rec_quantity) from ac1_control_hist where phy_file_ident = 518721734281200
and cur_pgm_name = 'File2E' and cur_file_alias = 'Diameter' and nxt_pgm_name = 'NONE' and nxt_file_alias = 'DUPLICATE';

--TC_ES_OUT (Event Server output)
select sum(wr_rec_quantity) from ac1_control_hist where phy_file_ident = 518721734281200
and cur_pgm_name = 'File2E' and cur_file_alias = 'Diameter' and nxt_pgm_name = 'NONE' and nxt_file_alias = 'GENERATE';

-- Counting events in APRM

--APRM_SUCCESS (Successfully processed in APRM)
select /*+ PARALLEL(t1,12) */ count(*) from prdappc.usc_roam_evnts t1
where event_date > '01-Apr-2016' and prod_id = 2 and event_id <> 2
and ciber_file_name_1 = 'SDIRI_FCIBER_ID000769_T20160608182115.DA';

-- Breakdown Costs by carrier code
select /*+ PARALLEL(h1,12) */ carrier_cd, bp_start_date,ciber_file_name_1||ciber_file_name_2, count(*), sum(usage),sum(TOTAL_CHRG_AMOUNT)  
from  PRDAPPC.USC_ROAM_EVNTS where (ciber_file_name_1||ciber_file_na
me_2 = 'SDIRI_FCIBER_ID000769_T20160608182115.DAT') or  (ciber_file_name_1||ciber_file_name_2 = 'SDIRI_FCIBER_ID000769_T20160608182115.DAT') 
or  (ciber_file_name_1||ciber_file_name_2 like 'SDIRI_FCIBER_ID000769_T20160608182115.DAT') or  (ciber_file_name_1||cibe
r_file_name_2 like 'SDIRI_FCIBER_ID000769_T20160608182115.DAT') or  (ciber_file_name_1||ciber_file_name_2 like 'SDIRI_FCIBER_ID000769_T20160608182115.DAT') 
group by  carrier_cd, bp_start_date,ciber_file_name_1,ciber_file_name_2;


--APRM_DUP and APRM_REJ (Rejected by APRM; duplicate error code is '9')
select substr(adu,instr(adu,'SDIRI_FCIBER_ID'),41) ciber_file, file_tp, dominant_err_cd, count(*) noe 
from prdappc.prm_dat_err_mngr 
where prod_id = 2 and event_id <> 2 and adu like '%SDIRI_FCIBER_ID000769_T20160608182115.DAT%'
group by substr(adu,instr(adu,'SDIRI_FCIBER_ID'),41), file_tp, dominant_err_cd
order by 1,2;


