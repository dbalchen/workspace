--MafAbends.sql

SELECT DECODE(FPFC_NXT_PGM_NAME, 'UPS2COLL','Collections', 
                                 'UPS2MDRV','Main_Driver',
              fpfc_nxt_pgm_name) "PROGRAM NAME", 
       FILE_STATUS, 
       COUNT(*) 
FROM ac_processing_accounting
WHERE FILE_STATUS IN ('AE','AF') 
AND FPFC_NXT_PGM_NAME in ('UPS2COLL',
                          'UPS2MDRV') 
GROUP BY FPFC_NXT_PGM_NAME, FILE_STATUS