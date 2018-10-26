--#-----------------------------------------------------------------------------
--# Revision      : PR270997
--# Description   : Modified for TOPS 
--# Author        : David A Smith
--# Date          : Tue Jun 11 11:05:09 CDT 2013
--#-----------------------------------------------------------------------------

SELECT aclf.IDENTENTIFIER, 
       aclf.FPHY_ORIG_FILE_ID, 
       aclf.FSRC_SENSOR_ID, 
       TO_CHAR(aclf.RCRDNG_START_DATE,'YYYY-MM-DD HH24:MI:SS'), 
       aclf.STRT_BLOCK,
       MOD(aclf.END_BLOCK,10000) end_block --when NTI blocks wrap, 10,000 is added to the first value after wrap.
FROM AC_LOGICAL_FILES aclf,
     AC_PHYSICAL_FILES acpf
WHERE aclf.FPHY_ORIG_FILE_ID = acpf.IDENTIFIER
AND aclf.RCRDNG_START_DATE > sysdate - (?/24 + 1) -- from_hrs_ago
AND aclf.RCRDNG_START_DATE < sysdate - ?/24  -- to_hrs_ago
AND to_date(substr(file_name, -18,14),'YYYYMMDDHH24MISS') > sysdate - (72/24 + 1) --from_hrs_ago must be sysdate - ? + 48 
AND aclf.FSRC_TYPE_ID in ('AAA','SMS','QIS','PMG') 
AND aclf.FSRC_SENSOR_ID = ?
ORDER BY aclf.FSRC_SENSOR_ID, substr(file_name, -19,19),
      acpf.serial_number, aclf.STRT_BLOCK, aclf.END_BLOCK
