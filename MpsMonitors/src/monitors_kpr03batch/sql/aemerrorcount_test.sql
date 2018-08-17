--#-----------------------------------------------------------------------------
--# Description   : AEM Error Count SQL
--# Author        : Steven M Roehl
--# Date          : Wed Jan 15 2014 13:42:00 CDT
--#-----------------------------------------------------------------------------
select * from (
select to_date('05081989','MMDDYYYY'),'10040',10,ora_database_name from dual
union
select to_date('05081989','MMDDYYYY'),'10040',100,ora_database_name from dual
union
select to_date('05091989','MMDDYYYY'),'10040',732,ora_database_name from dual
union
select to_date('05091989','MMDDYYYY'),'30218',732,ora_database_name from dual
union
select to_date('05091989','MMDDYYYY'),'30218',99732,ora_database_name from dual
)
