alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select substr(username,1,15) as username,EVENT,STATE,substr(module,1,20) as module ,substr(program,1,30),inst_id,logon_time,substr(sid,1,8) as sid,substr(serial#,1,8) as serial,status 
from gv$session
where event like '%&event%'
and type = 'USER'
order by username,EVENT, MODULE,SUBSTR(PROGRAM,1,30);