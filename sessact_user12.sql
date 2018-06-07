alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select con_id, substr(username,1,15) as username,lockwait,substr(EVENT,1,50) as event,substr(STATE,1,20) as state,LAST_CALL_ET, wait_time,seconds_in_wait,	substr(module,1,30) as module ,substr(program,1,30),inst_id,logon_time,substr(sid,1,8) as sid,substr(serial#,1,8) as serial,status 
from gv$session
where username like upper('%&login%')
and type = 'USER'
and status = 'ACTIVE'
and username not in ('ACNDBA')
order by LAST_CALL_ET desc;