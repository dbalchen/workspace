--#-----------------------------------------------------------------------------
--# Description   : AEM Error Count SQL
--# Author        : Steven M Roehl
--# Date          : Wed Jan 15 2014 13:42:00 CDT
--#-----------------------------------------------------------------------------
select trunc(sys_creation_date),error_id,count(*)
from ape1_rejected_event where processing_status not in ('CO','FI')
and sys_creation_date > sysdate-60
group by trunc(sys_creation_date),error_id
order by error_id desc, trunc(sys_creation_date) desc
