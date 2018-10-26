--#-----------------------------------------------------------------------------
--# Revision      : PR270997
--# Description   : Modified for TOPS 
--# Author        : David A Smith
--# Date          : Tue Jun 11 11:05:09 CDT 2013
--#-----------------------------------------------------------------------------

SELECT decode (nxt_pgm_name,'LSN','MF1LISTENER','SPL','MF1SPLITTER','MD','MF1MAINDRIVER','F2E', 'File2E','HLD','MF9HOLD','AEM','AEM',nxt_pgm_name), 
to_char(NXT_PROCESS_START_TIME, 'DD-MON-YYYY HH24:MI:SS'),identifier 
FROM ac1_control
WHERE file_status = 'IU' 
AND nxt_pgm_name in ('LSN','SPL','MD','F2E','HLD','AEM')
AND nxt_process_start_time < (sysdate-(?/24))
