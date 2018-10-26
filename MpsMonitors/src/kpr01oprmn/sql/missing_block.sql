--#-----------------------------------------------------------------------------
--# Revision      : PR270997
--# Description   : Modified for TOPS 
--# Author        : David A Smith
--# Date          : Fri Aug  3 09:29:41 CDT 2012
--#-----------------------------------------------------------------------------

SELECT aclf.IDENTENTIFIER, 
       aclf.FPHY_ORIG_FILE_ID, 
       aclf.FSRC_SENSOR_ID, 
       TO_CHAR(aclf.RCRDNG_START_DATE,'YYYY-MM-DD HH24:MI:SS'), 
       aclf.STRT_BLOCK,
       MOD(aclf.END_BLOCK,10000000) end_block -- when NTI blocks wrap, 10,000,000 is added to the first value after wrap.
FROM AC_LOGICAL_FILES aclf,
     AC_PHYSICAL_FILES acpf
WHERE aclf.FPHY_ORIG_FILE_ID = acpf.IDENTIFIER
AND aclf.RCRDNG_START_DATE > sysdate - (?/24 + 1) -- from_hrs_ago
AND aclf.RCRDNG_START_DATE < sysdate - ?/24  -- to_hrs_ago
AND aclf.FSRC_TYPE_ID in ('NTI','APLX') 
AND aclf.FSRC_SENSOR_ID = 'AAA1'
ORDER BY aclf.FSRC_SENSOR_ID,
      aclf.RCRDNG_START_DATE, aclf.RCDNG_END_DATE,
      acpf.serial_number, aclf.STRT_BLOCK, aclf.END_BLOCK