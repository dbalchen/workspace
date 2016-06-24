*** Email List for Revenue Accounting
:        Tabano-lucero Glayn <Glayn.Tabano-lucero@uscellular.com>; 
:        Rizwan, Muhammad <Muhammad.Rizwan@uscellular.com>; 
:        Vann, John <John.Vann@uscellular.com>;
:        Revenue Accounting <RevenueAccounting@uscellular.com>
*** Revenue Not confirmed for cycles 24,26 and 28
:        select sum(amount),bcc.cycle_year,bcc.cycle_instance,bcc.cycle_code
:         from bl1_inv_charge_rel bicr 
:          inner join bl1_cycle_control bcc on bicr.cycle_seq_no=bcc.cycle_seq_no 
:          inner join bl1_cyc_payer_pop bcpp on bcpp.period_key=bicr.period_key 
:          and bcpp.customer_key=bicr.customer_key and bcpp.ba_no=bicr.ba_no
:        where bcpp.status<>'CN' and bicr.period_key=20 and bcc.cycle_year=2015 
:         and bcc.cycle_instance=8 and bcc.cycle_code in (24,26,28)
:         group by bcc.cycle_year,bcc.cycle_instance,bcc.cycle_code
:         order by bcc.cycle_year,bcc.cycle_instance,bcc.cycle_code;
*** Null GeoCodes
:        select s_customer_id, s_fa_id, contact_id, cust.*, fa_rl.*, fa.*,con.*
:         from sa.table_customer cust
:          inner join sa.table_con_fin_accnt_role fa_rl 
:                on fa_rl.fa_role2customer = cust.objid
:          inner join sa.table_fin_accnt fa on fa_rl.fin_accnt_role2fin_accnt=fa.objid
:          inner join sa.table_contact con on fa_rl.con_accnt_role2contact=con.objid
:         where s_fa_id='851316127';