SELECT RATER_GROUP_PREFIX, 
       NO_OF_RATERS_IN_GROUP 
FROM rater_config 
WHERE cycle_code in ( SELECT cycle_code 
                      FROM cycle_control
                      WHERE cycle_close_date 
                            BETWEEN sysdate-92 
                            AND     sysdate
                      AND cycle_strt_bill_day is null 
                      AND usage_write_lock_ind = 'N' )
ORDER BY RATER_GROUP_PREFIX