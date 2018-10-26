select srcidentifier
        from MPS_USAGE_MOVE_AUDIT
        where file_status = 'CO'
        and FILE_PROCESS_DATE > SYSDATE - ?/24 

