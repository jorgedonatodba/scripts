set lines 155
col execs for 999,999,999
col min_etime for 999,999.99
col max_etime for 999,999.99
col avg_etime for 999,999.999
col sql_text for a80
break on sql_text skip 1
select a.sql_id,
substr(dbms_lob.substr(sql_text,3999,1),1,80) sql_text, b.execs, min_etime, max_etime, norm_stddev
from dba_hist_sqltext a, (
select sql_id, sum(execs) execs, min(avg_etime) min_etime, max(avg_etime) max_etime, stddev_etime/min(avg_etime) norm_stddev
from (
select sql_id, plan_hash_value, execs, avg_etime,
stddev(avg_etime) over (partition by sql_id) stddev_etime
from (
select sql_id, plan_hash_value,
sum(nvl(executions_delta,0)) execs,
(sum(elapsed_time_delta)/decode(sum(nvl(executions_delta,0)),0,1,sum(executions_delta))/1000000) avg_etime
-- sum((buffer_gets_delta/decode(nvl(buffer_gets_delta,0),0,1,executions_delta))) avg_lio
from DBA_HIST_SQLSTAT S, DBA_HIST_SNAPSHOT SS
where ss.snap_id = S.snap_id
and ss.instance_number = S.instance_number
and executions_delta > 0
and elapsed_time_delta > 0
group by sql_id, plan_hash_value
)
)
group by sql_id, stddev_etime
) b
where norm_stddev > nvl(to_number('&min_stddev'),2)
and max_etime > nvl(to_number('&min_etime'),.1)
and substr(dbms_lob.substr(sql_text,3999,1),1,80) like nvl('&sql_text',substr(dbms_lob.substr(sql_text,3999,1),1,80))
and a.sql_id = b.sql_id
order by 2
/