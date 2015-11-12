SELECT decode(fpfc_nxt_pgm_name,'UPS2COLL','Collections', 
         'MAF2COLL','MAF_Collections', 
         'UPS2MDRV','Main_Driver','mpgd_100mn','Guiding',
         'mpup_100mn','Rating', fpfc_nxt_pgm_name), 
       file_status, count(*) cnt, sum(wr_rec_quantity) rec_quan 
FROM ac_processing_accounting 
WHERE fpfc_nxt_pgm_name in ('UPS2COLL','MAF2COLL','UPS2MDRV','mpgd_100mn',
                            'mpup_100mn') 
AND file_status in ('IU','AF','AE','RD','WA') 
HAVING sum(wr_rec_quantity) > ? --$self->{_behindThresh}
GROUP BY fpfc_nxt_pgm_name, file_status