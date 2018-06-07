alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

select sample_time,module, program, session_id, session_state, event, seq#, sql_id, '0' || trim(to_char(p1,'XXXXXXXXXXXXXXXXX')) "p1raw", p3
from v$active_session_history
where
sample_time >= to_date('01-06-2016 00:00:00','dd-mm-yyyy hh24:mi:ss')
and sample_time <= to_date('02-06-2016 00:00:00','dd-mm-yyyy hh24:mi:ss')
and event like '%checkpoint%'
order by sample_time desc
/

select sample_time,module, program, session_id, session_state, event, seq#, sql_id, '0' || trim(to_char(p1,'XXXXXXXXXXXXXXXXX')) "p1raw", p3
from DBA_HIST_ACTIVE_SESS_HISTORY
where
sample_time >= to_date('16-06-2016 06:30:00','dd-mm-yyyy hh24:mi:ss')
and sample_time <= to_date('16-06-2016 07:05:00','dd-mm-yyyy hh24:mi:ss')
and event like '%Latch%'
order by sample_time desc
