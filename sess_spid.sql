alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select p.spid, substr(s.username,1,15) as username, s.EVENT,s.STATE,substr(s.module,1,20) as module ,substr(s.program,1,30),s.inst_id,s.logon_time,substr(s.sid,1,8) as sid,substr(s.serial#,1,8) as serial,status,SQL_ID, s.lockwait,substr(s.EVENT,1,50) as event,substr(s.STATE,1,20) as state,s.LAST_CALL_ET, s.wait_time,s.seconds_in_wait 
from gv$session s, gv$process p
where s.inst_id = p.inst_id
and s.PADDR = p.ADDR
and p.spid like ('%&spid%')
order by p.spid, s.username, s.EVENT, s.MODULE,SUBSTR(s.PROGRAM,1,30);