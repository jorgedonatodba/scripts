select hash_value, count(distinct(sql_id))
from   v$sql
group by hash_value
having count(distinct(sql_id)) > 1
order by 2
/