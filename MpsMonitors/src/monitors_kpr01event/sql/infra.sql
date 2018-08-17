SELECT FILE_NAME, NUM_RECORDS 
FROM USCC_USAGE_AUDIT_T 
WHERE ( 
        ( 
            NEXT_PROGRAM_NAME = 'EventLoad' 
            AND FILE_STATUS = 'CO'
        ) 
        OR 
        ( 
             NEXT_PROGRAM_NAME = 'EventRecycle'
             AND FILE_STATUS in('CO','RD')
        )
      ) 
AND FILE_STATUS_DATE > ? - (60*60*3)