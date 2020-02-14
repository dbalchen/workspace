select a.customer_id,
       a.resource_value,
       a.sys_creation_date,
       a.l9_system_service,
       a.l3_duration,
       a.l3_rounded_unit,
       a.l3_charge_amount,
       a.l3_call_direction,
       a.l9_roaming_ind,
       a.l9_calling_number,
       a.l9_called_number,
       a.service_filter,
       a.l9_dialed_digits,
       a.l9_toll_duration,
       a.l9_balance_amount,
       a.l9_daily_surcharge_ind,
       a.l3_offer_id,
       b.soc_name
  from ape1_rated_event a, csm_offer b
 where     1 = 1
       and b.soc_cd = a.l3_offer_id
       and a.event_type_id = 62
       and a.l3_duration > 3600
       and a.l9_session_identifier like 'RO_CTS%'
       and a.sys_creation_date > sysdate - 1
       and a.service_filter not like 'SPL%'