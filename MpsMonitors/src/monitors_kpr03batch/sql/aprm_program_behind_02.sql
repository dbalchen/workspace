SELECT nxt_pgm_name, file_status, count(*) cnt, sum(wr_rec_quantity) rec_quan 
FROM ac_control_02
WHERE nxt_pgm_name in ('ICLISTENER','ICUSGMGR','ICRATER','UPRTUSAGE')
HAVING sum(wr_rec_quantity) > ?
GROUP BY nxt_pgm_name, file_status
