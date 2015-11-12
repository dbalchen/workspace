SELECT DECODE(FPFC_NXT_PGM_NAME, 
                'UPS2COLL','Collection', 
                'MAF2COLL','MAF_Collections', 
                'UPS2MDRV','Main_Driver',
                'mpgd_100mn','Guiding', 
                'mpup_100mn','Rating', 
                'CIBER_RECYCLE','Ciber_Rcl', 
                'UPS2RCCL','Ndc_Rcl',
              fpfc_nxt_pgm_name), 
       to_char(NXT_PGM_STR_DATE, 'DD-MON-YYYY HH24:MI:SS'), 
       IDENTIFIER 
FROM ac_processing_accounting
WHERE FILE_STATUS = 'IU' 
AND FPFC_NXT_PGM_NAME in ('UPS2RCCL',
                          'UPS2COLL',
                          'MAF2COLL',
                          'UPS2MDRV',
                          'mpgd_100mn',
                          'mpup_100mn',
                          'CIBER_RECYCLE') 
AND NXT_PGM_STR_DATE < (sysdate-(?/24))