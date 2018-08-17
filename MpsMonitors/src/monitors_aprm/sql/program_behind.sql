--#-----------------------------------------------------------------------------
--# Revision      : PR270997
--# Description   : Modified for TOPS 
--# Author        : David A Smith
--# Date          : Fri Aug  3 09:29:41 CDT 2012
--#-----------------------------------------------------------------------------

SELECT decode (nxt_pgm_name,'LSN','MF1LISTENER','SPL','MF1SPLITTER','MD','MF1MAINDRIVER','HLD','MF9HOLD',nxt_pgm_name), 
file_status, count(*) cnt, sum(wr_rec_quantity) rec_quan 
FROM ac1_control 
WHERE nxt_pgm_name in ('LSN','SPL','MD','HLD')
AND file_status in ('IU','AF','AE','RD','WA') 
HAVING sum(wr_rec_quantity) > ? --$self->{_behindThresh}
GROUP BY nxt_pgm_name, file_status