SELECT aclf.IDENTIFIER, 
       aclf.FPHY_ORIG_FILE_ID, 
       aclf.FSRC_SENSOR_ID, 
       TO_CHAR(aclf.RCRDNG_START_DATE,'YYYY-MM-DD HH24:MI:SS'), 
       aclf.STRT_BLOCK,
       DECODE(aclf.FSRC_SENSOR_ID,
		'GRIS',MOD(aclf.END_BLOCK,10000000),					'SALI',MOD(aclf.END_BLOCK,10000000),
		'SCH2',MOD(aclf.END_BLOCK,10000000),
                'NEWB',MOD(aclf.END_BLOCK,10000000), 
                'CDR2',MOD(aclf.END_BLOCK,10000000), 
                'MIXM',MOD(aclf.END_BLOCK,10000000), 
                'MADI',MOD(aclf.END_BLOCK,10000000), 
                'CLIN',MOD(aclf.END_BLOCK,10000000),           
		'BROO',MOD(aclf.END_BLOCK,10000000),
		'CONG',MOD(aclf.END_BLOCK,10000000),
		'APPL',MOD(aclf.END_BLOCK,10000000),
		'ROC2',MOD(aclf.END_BLOCK,10000000),
		'PEO2',MOD(aclf.END_BLOCK,10000000),
		'COLU',MOD(aclf.END_BLOCK,10000000),
		'GRAN',MOD(aclf.END_BLOCK,10000000),
		'OKLA',MOD(aclf.END_BLOCK,10000000),
		'STLO',MOD(aclf.END_BLOCK,10000000),
		'GREE',MOD(aclf.END_BLOCK,10000000),
		'OWAS',MOD(aclf.END_BLOCK,10000000),
		'WIC2',MOD(aclf.END_BLOCK,10000000),
		'KNOX',MOD(aclf.END_BLOCK,10000000),
		'MEDF',MOD(aclf.END_BLOCK,10000000),
		'YAKI',MOD(aclf.END_BLOCK,10000000),
		'OMAH',MOD(aclf.END_BLOCK,10000000),
		'EURE',MOD(aclf.END_BLOCK,10000000),
		'ASHE',MOD(aclf.END_BLOCK,10000000),
		'ATO2',MOD(aclf.END_BLOCK,10000000),
		'MANH',MOD(aclf.END_BLOCK,10000000),
		'JOPL',MOD(aclf.END_BLOCK,10000000),
		'DAVE',MOD(aclf.END_BLOCK,10000000),
		'TULS',MOD(aclf.END_BLOCK,10000000),
		'BEND',MOD(aclf.END_BLOCK,10000000),
		'LONG',MOD(aclf.END_BLOCK,10000000),
		'CDRP',MOD(aclf.END_BLOCK,10000000),
		'UKIA',MOD(aclf.END_BLOCK,10000000),
		'IOWA',MOD(aclf.END_BLOCK,10000000),
		'LOM3',MOD(aclf.END_BLOCK,10000000),
                 MOD(aclf.END_BLOCK,1000000)) end_block 
                 -- when NTI blocks wrap, 1,000,000 is
                 -- added to the first value after wrap or 10,000,000
                 -- depending on the rollover value.
FROM AC_LOGICAL_FILES aclf,
     AC_PHYSICAL_FILES acpf
WHERE aclf.FPHY_ORIG_FILE_ID = acpf.IDENTIFIER
AND aclf.RCRDNG_START_DATE > sysdate - (?/24 + 1) -- from_hrs_ago
AND aclf.RCRDNG_START_DATE < sysdate - ?/24  -- to_hrs_ago
AND aclf.FSRC_TYPE_ID in ('NTI','APLX') 
AND aclf.FSRC_SENSOR_ID = ?
ORDER BY aclf.FSRC_SENSOR_ID,
      aclf.RCRDNG_START_DATE, aclf.RCRDNG_END_DATE,
      acpf.serial_number, aclf.STRT_BLOCK, aclf.END_BLOCK