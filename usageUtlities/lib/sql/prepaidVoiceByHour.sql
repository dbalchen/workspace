   SELECT /*+ Parallel (T1,16) */
     TO_CHAR (TRUNC (start_time), 'Yyyymmddhh')"Date", COUNT (*)
    FROM ape1_rated_event
   WHERE     start_time >= '19-JAN-2020'
         AND start_time < '20-JAN-2020'
         AND event_type_id = 62
         AND l9_is_online = 'Y'
GROUP BY TO_CHAR (TRUNC (start_time), 'Yyyymmddhh')
order by TO_CHAR (TRUNC (start_time), 'Yyyymmddhh')
