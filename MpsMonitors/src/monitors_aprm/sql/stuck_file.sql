--#-----------------------------------------------------------------------------
--# Revision      : PR270997
--# Description   : Modified for TOPS 
--# Author        : David A Smith
--# Date          : Fri Aug  3 09:29:41 CDT 2012
--#-----------------------------------------------------------------------------

SELECT decode (nxt_pgm_name,'LSN','MF1LISTENER','SPL','MF1SPLITTER','MD','MF1MAINDRIVER','HLD','MF9HOLD',nxt_pgm_name), 
to_char(NXT_PROCESS_START_TIME, 'DD-MON-YYYY HH24:MI:SS'),identifier 
FROM ac1_control
WHERE file_status = 'IU' 
AND nxt_pgm_name in ('LSN','SPL','MD' ,'HLD')
AND nxt_process_start_time < (sysdate-(?/24))
