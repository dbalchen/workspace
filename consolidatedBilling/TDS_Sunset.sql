----- Query #1

select mi.DESCRIPTION, cb.ban, c.weight, ba.ba_no, ba.ba_customer_no, ba.ba_account_no, ba.ba_status, ba.perm_printing_cat, mi.consolidator,md.invrpt_dest_code, cb.l3_bill_format,ba.sys_update_date as BA_sys_update_date, 
       cc.cycle_code, ba.last_cycle_seq_no, cc.cycle_instance, cc.cycle_year, 
        mi.mabel_bill_format, mi.consolidation_period
from bl1_blng_arrangement ba,
     csm_ben cb,
     bl1_cycle_control cc,
     add9_mabel_ids mi,
     mabel_destination md,
     bl1_customer c
where cb.ben = ba.ba_no
  and mi.consolidator = md.consolidator(+)
  and ba.ba_customer_no = c.customer_id
  and mi.consolidator in (
  2300, 74000, 75600, 76200, 77700, 78000, 78500, 79400, 79500, 79900, 80020, 80022, 80049, 80101, 80119, 80124, 80126, 80134, 80141,
80160, 80166, 80174, 80178, 80201, 80213, 80235, 80237, 80242, 80260, 80273, 80276, 80280, 80287, 80295, 80303, 80314, 80359, 80363,
80365, 80403, 80434, 80446, 80453, 80455, 80466, 80480, 80524, 80531, 80561, 80562, 80564, 80566, 80601, 80602, 80603, 80604, 80605,
80606, 80607, 80609, 80610, 80612, 80613, 80614, 80615, 80616, 80617, 80618, 80619, 80620, 80621, 80622, 80623, 81001, 81002, 81003,
81004, 81005, 81100, 81200, 81300, 81500, 83700, 85500, 85600, 86800, 87401, 87900, 89100, 89400, 89800, 89801, 89900, 90093, 90094,
91000, 91011, 96900, 97700
  )
  and ba.last_cycle_seq_no = cc.cycle_seq_no(+)
  and ba.perm_printing_cat = mi.mabel_id(+)
  group by mi.DESCRIPTION, cb.ban, c.weight, ba.ba_no, ba.ba_customer_no, ba.ba_account_no, ba.ba_status, ba.perm_printing_cat, mi.consolidator,md.invrpt_dest_code, cb.l3_bill_format,ba.sys_update_date, 
       cc.cycle_code, ba.last_cycle_seq_no, cc.cycle_instance, cc.cycle_year, 
        mi.mabel_bill_format, mi.consolidation_period
order by mi.DESCRIPTION,ba.ba_customer_no, ba.ba_no, cc.cycle_code;


---- Query #2
select t2.*,count(unique(t1.account_no)) number_accounts,t1.cycle_code from mabel_control t1,
(select description,mabel_id,Consolidator, mabel_bill_format from add9_mabel_ids where CONSOLIDATOR in (
72300, 74000, 75600, 76200, 77700, 78000, 78500, 79400, 79500, 79900, 80020, 80022, 80049, 80101, 80119, 80124, 80126, 80134, 80141,
80160, 80166, 80174, 80178, 80201, 80213, 80235, 80237, 80242, 80260, 80273, 80276, 80280, 80287, 80295, 80303, 80314, 80359, 80363,
80365, 80403, 80434, 80446, 80453, 80455, 80466, 80480, 80524, 80531, 80561, 80562, 80564, 80566, 80601, 80602, 80603, 80604, 80605,
80606, 80607, 80609, 80610, 80612, 80613, 80614, 80615, 80616, 80617, 80618, 80619, 80620, 80621, 80622, 80623, 81001, 81002, 81003,
81004, 81005, 81100, 81200, 81300, 81500, 83700, 85500, 85600, 86800, 87401, 87900, 89100, 89400, 89800, 89801, 89900, 90093, 90094,
91000, 91011, 96900, 97700) and effective_date <= sysdate and (expiration_date <= sysdate or expiration_date is null)
group by description,Mabel_Id,Consolidator,mabel_bill_format) t2
where t2.mabel_id = t1.mabel_id
group by  t2.consolidator, t2.description,t2.mabel_id,t2.mabel_bill_format,t1.cycle_code
order by t2.consolidator, t2.description,t2.mabel_id,t2.mabel_bill_format,t1.cycle_code

 

----- Query #3

select c.weight, ba.ba_no, ba.ba_customer_no, ba.ba_status, ba.ba_account_no, ba.perm_printing_cat, mi.mabel_id, mi.consolidator,cb.l3_bill_format, 
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



select * from Bl1_document 


select t1.BA_NO,t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD'),t1.doc_produce_ind,t2.BA_STATUS 
from Bl1_Document t1,  Bl1_Blng_Arrangement t2 
where t1.bill_date >= '01-JUN-2018' and t1.ACCOUNT_NO = t2.BA_ACCOUNT_NO 
group by  t1.BA_NO, t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD'),t1.doc_produce_ind, t2.BA_STATUS 
order by t1.BA_NO ,t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD') desc, t1.doc_produce_ind



select * from  Mabel_Audit t1,  Add9_Mabel_Ids t2 where t1.CONSOLIDATOR = t2.CONSOLIDATOR 
and t1.SYS_CREATION_DATE in (

select account_no, CONSOLIDATOR, max(sys_creation_date) from Mabel_Audit group by account_no,CONSOLIDATOR

select t1.BA_NO,t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD') "Bill Date",mabel.MABEL_ID,mabel.DESCRIPTION,mabel.CONS,t1.doc_produce_ind,t2.BA_STATUS 
from Bl1_Document t1,  Bl1_Blng_Arrangement t2,
 (select t2.A_NO aact_no,t1.MABEL_ID,t1.Description,t1.MABEL_BILL_FORMAT mabel_format,t2.cons from Add9_Mabel_Ids t1,
(select account_no a_no, CONSOLIDATOR cons, max(sys_creation_date) mydate from Mabel_Audit group by account_no,CONSOLIDATOR) t2
where t2.cons = t1.CONSOLIDATOR) mabel
where t1.bill_date >= '01-May-2018' and t1.ACCOUNT_NO = t2.BA_ACCOUNT_NO 
and t1.ACCOUNT_NO = mabel.AACT_NO
group by  t1.BA_NO, t1.customer_no,t1.account_no,to_char(t1.bill_date,'YYYYMMDD'),t1.doc_produce_ind, t2.BA_STATUS,mabel.MABEL_ID,mabel.DESCRIPTION,mabel.CONS 
order by t1.BA_NO ,t1.customer_no,t1.account_no,mabel.MABEL_ID,to_char(t1.bill_date,'YYYYMMDD') desc, t1.doc_produce_ind



