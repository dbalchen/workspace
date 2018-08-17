--#-----------------------------------------------------------------------------
--# Revision      : PR270997
--# Description   : Modified for TOPS 
--# Author        : David A Smith
--# Date          : Tue Jun 11 11:05:09 CDT 2013
--#-----------------------------------------------------------------------------

SELECT FSRC_SENSOR_ID,
       TO_CHAR(MAX(system_rcv_date), 'DD-MON-YYYY HH:MI:SS AM') 
FROM AC_LOGICAL_FILES 
WHERE  FSRC_TYPE_ID in (select file_type from ac_source)
GROUP BY FSRC_SENSOR_ID
HAVING MAX(NEW_TIME(system_rcv_date,'GMT',?)) < sysdate - (?/24)
