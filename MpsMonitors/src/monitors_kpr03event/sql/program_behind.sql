--#-----------------------------------------------------------------------------
--# Revision      : PR270997
--# Description   : Modified for TOPS 
--# Author        : David A Smith
--# Date          : Tue Jun 11 11:05:09 CDT 2013
--#-----------------------------------------------------------------------------

SELECT decode (nxt_pgm_name,'LSN','MF1LISTENER','SPL','MF1SPLITTER','MD','MF1MAINDRIVER','F2E', 'File2E','HLD','MF9HOLD','AEM','AEM',nxt_pgm_name), 
file_status, count(*) cnt, sum(wr_rec_quantity) rec_quan 
FROM ac1_control 
WHERE nxt_pgm_name in ('LSN','SPL','MD','F2E','HLD','AEM')
AND file_status in ('AE','AF','CN','HO','WA','UD','IU','RD','RJ','RT','UA','US','SP','SM','SF','PR') 
HAVING sum(wr_rec_quantity) > ? --$self->{_behindThresh}
GROUP BY nxt_pgm_name, file_status
