select srcidentifier
        from MPS_USAGE_MOVE_AUDIT
        where file_status = 'CO'
        and file_process_date between sysDate - ?/24 and sysDate - ?/24
