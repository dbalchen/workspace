
select cb.ban, cb.ben, c.weight, ba.ba_no, ba.ba_customer_no, ba.ba_account_no, ba.ba_status, ba.perm_printing_cat,
       mi.consolidator,md.invrpt_dest_code, cb.l3_bill_format,ba.sys_update_date as BA_sys_update_date, 
       cc.cycle_code, ba.last_cycle_seq_no, cc.cycle_instance, cc.cycle_year, 
        mi.mabel_bill_format, mi.consolidation_period, ba.*
from bl1_blng_arrangement ba,
     csm_ben cb,
     bl1_cycle_control cc,
     add9_mabel_ids mi,
     mabel_destination md,
     bl1_customer c
where cb.ben = ba.ba_no
  and mi.consolidator = md.consolidator(+)
  and ba.ba_customer_no = c.customer_id
    and ba_account_no in (851442498)
  --and ba_customer_no in (823492224)
  --and ba_no in (850499141)
  --and mi.consolidator in (80379)
  and ba.last_cycle_seq_no = cc.cycle_seq_no(+)
  and ba.perm_printing_cat = mi.mabel_id(+)
order by ba.ba_customer_no, ba.ba_no, cc.cycle_code;


select c.weight, ba.ba_no, ba.ba_customer_no, ba.ba_status, ba.ba_account_no, ba.perm_printing_cat,
       mi.mabel_id, mi.consolidator,cb.l3_bill_format, 
       cc.cycle_code, ba.last_cycle_seq_no, cc.cycle_instance, cc.cycle_year, 
        mi.mabel_bill_format, mi.consolidation_period, ba.*, cb.*
from bl1_blng_arrangement ba,
     csm_ben cb,
     bl1_cycle_control cc,
     add9_mabel_ids mi,
     bl1_customer c
where cb.ben = ba.ba_no
  and ba.ba_customer_no = c.customer_id
  and mi.consolidator in (99101, 99102, 99103, 99014, 99105)
  --and cc.cycle_instance = 4
  --and ba.ba_account_no in (943251136)
  --and cc.cycle_instance = 10
  --and ba_status = 'N'
  --and ba.perm_printing_cat in ('C1ONEOK')
  and ba.last_cycle_seq_no = cc.cycle_seq_no(+)
  and ba.perm_printing_cat = mi.mabel_id(+)
order by mi.mabel_id, cycle_instance, cycle_code, ba.ba_account_no;


1877 700 8722,,630 745 7585
