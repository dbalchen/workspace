SELECT FSRC_SENSOR_ID,
       TO_CHAR(MAX(system_rcv_date), 'DD-MON-YYYY HH:MI:SS AM') 
FROM AC_LOGICAL_FILES 
WHERE FSRC_TYPE_ID in ('NTI','APLX','SMS') and  (system_rcv_date > sysdate - 10)
GROUP BY FSRC_SENSOR_ID
HAVING MAX(system_rcv_date) < sysdate - (?/24) --$self->{hours_behind}/24) 
UNION 
SELECT FSRC_SENSOR_ID, 
       TO_CHAR(MAX(system_rcv_date), 'DD-MON-YYYY HH:MI:SS AM') 
FROM AC_LOGICAL_FILES 
WHERE FSRC_TYPE_ID in ('QIS','AAA','PMG') and  (system_rcv_date > sysdate - 10)
GROUP BY FSRC_SENSOR_ID 
HAVING MAX(NEW_TIME(system_rcv_date,'GMT',?)) < sysdate - (?/24)
--                                        #tzstring        #hours_behind 