Counting Data events in TC

Get the file Identifiers for settlement Period (A settlement period is between 16th and 15th of the next month (Ex. April 16th - May 15th)
select file_name, identifier 
     from prdafc.ac1_control_hist 
     where file_name like 'SDATACBR_FDATACBR%YYYYMMDD%.DAT'; YYYY = Year, MM = Month DD = Day)

TC_AF_IN (Turbo Charging A&F input)
select sum(in_rec_quantity) 
     from prdafc.ac1_control_hist 
     where phy_file_ident = 515547210078200
     and cur_pgm_name = 'LSN' 
      and cur_file_alias = 'DATACBR' 
      and nxt_pgm_name = 'MD' 
      and nxt_file_alias = 'DATACBR';

TC_AF_DROP (Dropped by A&F)
select sum(wr_rec_quantity) 
                from prdafc.ac1_control_hist 
                where phy_file_ident = 515547210078200
                and cur_pgm_name = 'MD' 
                 and cur_file_alias = 'DATA_DRP' 
                 and nxt_pgm_name = 'NONE' 
                 and nxt_file_alias = 'DATA_DRP';

TC_ES_IN (Turbo Charging Event Server input)
select sum(wr_rec_quantity) 
     from prdafc.ac1_control_hist 
     where phy_file_ident = 515547210078200
     and cur_pgm_name = 'MD' 
      and cur_file_alias = 'TCUSAGE' 
      and nxt_pgm_name = 'File2E' 
      and nxt_file_alias = 'Diameter';

TC_ES_REJ (Rejected by Event Server)
select sum(wr_rec_quantity) 
     from prdafc.ac1_control_hist 
     where phy_file_ident = 515547210078200
     and cur_pgm_name = 'File2E' 
      and cur_file_alias = 'Diameter' 
      and nxt_pgm_name = 'NONE' 
      and nxt_file_alias = 'REJECT';

Rejected Records
select l9_channel, original_event_id, error_id, max(l9_original_air_time_chg_amt)  
     from ape1_rejected_event 
     where original_event_id 
      in (select unique(original_event_id) 
           from ape1_rejected_event 
           where physical_source = 518721734281200) 
      and processing_status = 'CO' 
      and event_id = original_event_id 
group by  original_event_id, l9_channel, error_id;

TC_ES_OUT (Event Server output)
select sum(wr_rec_quantity) 
     from prdafc.ac1_control_hist 
     where phy_file_ident = 515547210078200
     and cur_pgm_name = 'File2E' 
      and cur_file_alias = 'Diameter' 
      and nxt_pgm_name = 'NONE' 
      and nxt_file_alias = 'GENERATE';

Counting events in APRM

APRM_SUCCESS (Successfully processed in APRM)
select /*+ PARALLEL(t1,12) */ count(*) 
     from usc_roam_evnts t1
     where event_date > '01-Apr-2016' 
      and prod_id = 2 
      and event_id = 2
     and ciber_file_name_1 = 'SDATACBR_FDATACBR_ID019892_T201605030033';

Breakdown Costs by carrier code 
select /*+ PARALLEL(h1,12) */ carrier_cd, bp_start_date,ciber_file_name_1||ciber_file_name_2, count(*), sum(usage),sum(TOTAL_CHRG_AMOUNT)  
     from  PRDAPPC.USC_ROAM_EVNTS where (ciber_file_name_1||ciber_file_name_2 = 'SDATACBR_FDATACBR_ID019892_T20160503003300.DAT') 
      or  (ciber_file_name_1||ciber_file_name_2 = 'SDATACBR_FDATACBR_ID019892_T20160503003300.DAT') 
      or  (ciber_file_name_1||ciber_file_name_2 like 'SDATACBR_FDATACBR_ID019892_T20160503003300.DAT') 
      or  (ciber_file_name_1||ciber_file_name_2 like 'SDATACBR_FDATACBR_ID019892_T20160503003300.DAT') 
      or  (ciber_file_name_1||ciber_file_name_2 like 'SDIRI_FCIBER_ID000769_T20160608182115.DAT') 
group by carrier_cd, bp_start_date,ciber_file_name_1,ciber_file_name_2;

APRM_DUP and APRM_REJ (Rejected by APRM; duplicate error code is '9')
select substr(adu,instr(adu,'SDATACBR_FDATACBR_ID'),46) ciber_file, file_tp, dominant_err_cd, count(*) noe 
     from prm_dat_err_mngr 
     where prod_id = 2 
      and event_id = 2 
      and substr(adu,instr(adu,'SDATACBR_FDATACBR_ID'),46) = 'SDATACBR_FDATACBR_ID019892_T20160503003300.DAT'
group by substr(adu,instr(adu,'SDATACBR_FDATACBR_ID'),46), file_tp, dominant_err_cd
order by 1,2;
