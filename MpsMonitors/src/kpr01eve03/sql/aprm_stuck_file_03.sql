SELECT nxt_pgm_name, to_char(file_create_date, 'DD-MON-YYYY HH24:MI:SS') as create_date, identifier 
FROM ac_control_03
WHERE file_status = 'IU'
AND trunc(file_create_date) < trunc(sysdate-(?/24))
