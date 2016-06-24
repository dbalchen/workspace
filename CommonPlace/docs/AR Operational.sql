   - Checks to see if all payment files have been processed.(*PRDCUST*)

: select  identifier, nxt_pgm_name, file_status, file_format, file_name, file_path,  a.* 
:  from ac1_control a
:  where nxt_pgm_name like 'AR1PYM%'

:  --and file_name like '%_181_%'
:  and file_status <> 'CO'
:  order by sys_creation_date desc 
   - Gateway Listener (*PRDCUST*)
: select * from ar3_gwls_file_status 
:  where sys_creation_date > (sysdate -6)
:  and file_process_state <> 'CO' 
:  order by sys_creation_date desc
   - More General stuff (*PRDCUST*)
: select  trunc(sys_creation_date), period_key, record_type , 
:  decode(record_type, 'PNR' , 'DONE' , 'LNR' , 'IN PROGRESS', 'NNR', 'PENDING') status  
:  ,count(*) from ar1_jgl_control 
: where financial_activity_type is null  
:  and sys_creation_date > to_date('20150826','yyyymmdd')
:  group by  trunc(sys_creation_date), period_key , record_type
:  order by 1, 2, 3  
   - Query for Batch Payments
: select count(1),sum(amount),trunc(sys_creation_date),deposit_date,payment_source_id,
:  file_seq_no from ar1_payment_details
: where payment_source_id in ( 'LOCKBOX', 'AGTCASH', 'IMPCOL', 'IMPEFT', 'IMPPAY'
:  ,'CERLBX') and sys_creation_date like '05-AUG-15%'
:  and payment_type='P'
: group by  trunc(sys_creation_date), deposit_date, payment_source_id, file_seq_no
: order by  trunc(sys_creation_date), deposit_date, payment_source_id, file_seq_no
