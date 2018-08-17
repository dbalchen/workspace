select distinct aclf.fsrc_sensor_id
FROM AC_LOGICAL_FILES aclf
    ,AC_PHYSICAL_FILES acpf
WHERE aclf.FPHY_ORIG_FILE_ID = acpf.IDENTIFIER
AND aclf.RCRDNG_START_DATE > sysdate - (?/24 + 1) -- from_hrs_ago
AND aclf.RCRDNG_START_DATE < sysdate - ?/24  -- to_hrs_ago
AND aclf.FSRC_TYPE_ID in ('AAA','SMS','QIS','PMG')