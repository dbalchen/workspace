--#-----------------------------------------------------------------------------
--# Revision      : PR270997
--# Description   : Modified for TOPS 
--# Author        : David A Smith
--# Date          : Fri Aug  3 09:29:41 CDT 2012
--#-----------------------------------------------------------------------------

SELECT nxt_pgm_name,nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac1_control 
WHERE nxt_pgm_name = 'LSN' 
AND file_status ='CO' 
AND nxt_process_start_time  > ((sysdate) - 1)
group by nxt_pgm_name,nxt_file_alias
UNION
SELECT nxt_pgm_name,nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac1_control 
WHERE nxt_pgm_name = 'SPL' 
AND file_status ='CO' 
AND nxt_process_start_time  > ((sysdate) - 1)
group by nxt_pgm_name,nxt_file_alias
UNION
SELECT nxt_pgm_name,nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac1_control 
WHERE nxt_pgm_name = 'MD' 
AND file_status ='CO' 
AND nxt_process_start_time  > ((sysdate) - 1)
group by nxt_pgm_name,nxt_file_alias
UNION
SELECT  nxt_pgm_name,nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac1_control 
WHERE nxt_pgm_name = 'HLD' 
AND file_status ='CO' 
--and nxt_file_alias like 'DUMMY%'
AND nxt_process_start_time  > ((sysdate) - 1)
group by nxt_pgm_name,nxt_file_alias
UNION
SELECT nxt_pgm_name,nxt_file_alias,
       SUM(nvl(wr_rec_quantity,0)),
       SUM(NVL(dr_time_quantity,0)), 
       COUNT(*)
FROM ac1_control 
WHERE nxt_pgm_name = 'RCL' 
AND file_status ='CO' 
--and nxt_file_alias='SMS'
AND nxt_process_start_time  > ((sysdate) - 1)
group by nxt_pgm_name,nxt_file_alias
--UNION
--SELECT nxt_pgm_name,nxt_file_alias,
--       SUM(nvl(wr_rec_quantity,0)),
--       SUM(NVL(dr_time_quantity,0)), 
--       COUNT(*)
--FROM ac1_control 
--WHERE nxt_pgm_name = 'MAF2COLL' 
--AND file_status ='CO' 
--and nxt_file_alias='SMS_SPLT'
--AND nxt_process_start_time  > ((sysdate) - 1)
--group by nxt_pgm_name,nxt_file_alias
