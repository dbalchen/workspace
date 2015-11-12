SELECT fpfc_nxt_pgm_name,fpfc_nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac_processing_accounting 
WHERE fpfc_nxt_pgm_name = 'mpup_100mn' 
AND file_status ='CO' 
AND nxt_pgm_str_date  > ((sysdate) - ?)
group by fpfc_nxt_pgm_name,fpfc_nxt_file_alias
UNION
SELECT fpfc_nxt_pgm_name,fpfc_nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac_processing_accounting 
WHERE fpfc_nxt_pgm_name = 'mpgd_100mn' 
AND file_status ='CO' 
AND nxt_pgm_str_date  > ((sysdate) - ?)
group by fpfc_nxt_pgm_name,fpfc_nxt_file_alias
UNION
SELECT fpfc_nxt_pgm_name,fpfc_nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac_processing_accounting 
WHERE fpfc_nxt_pgm_name = 'UPS2MDRV' 
AND file_status ='CO' 
AND nxt_pgm_str_date  > ((sysdate) - ?)
group by fpfc_nxt_pgm_name,fpfc_nxt_file_alias
UNION
SELECT  fpfc_nxt_pgm_name,fpfc_nxt_file_alias,
      SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac_processing_accounting 
WHERE fpfc_nxt_pgm_name = 'UPS2COLL' 
AND file_status ='CO' 
and fpfc_nxt_file_alias like 'DUMMY%'
AND nxt_pgm_str_date  > ((sysdate) - ?)
group by fpfc_nxt_pgm_name,fpfc_nxt_file_alias
UNION
SELECT fpfc_nxt_pgm_name,fpfc_nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac_processing_accounting 
WHERE fpfc_nxt_pgm_name = 'MAF2COLL' 
AND file_status ='CO' 
and fpfc_nxt_file_alias='SMS'
AND nxt_pgm_str_date  > ((sysdate) - ?)
group by fpfc_nxt_pgm_name,fpfc_nxt_file_alias
UNION
SELECT fpfc_nxt_pgm_name,fpfc_nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac_processing_accounting 
WHERE fpfc_nxt_pgm_name = 'MAF2COLL' 
AND file_status ='CO' 
and fpfc_nxt_file_alias='SMS_SPLT'
AND nxt_pgm_str_date  > ((sysdate) - ?)
group by fpfc_nxt_pgm_name,fpfc_nxt_file_alias
