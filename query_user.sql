alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select substr(s.username,1,15) as username, l.DISK_READS, l.DIRECT_WRITES, l.BUFFER_GETS, s.EVENT,substr(s.module,1,20) as module ,substr(s.program,1,30),s.inst_id,s.logon_time,substr(s.sid,1,8) as sid,substr(s.serial#,1,8) as serial,s.status
, l.SQL_TEXT 
from gv$session s, gv$sql l
where s.username like upper('%&username%')
and s.sql_hash_value = l.hash_value
and s.sql_address    = l.address
and s.inst_id        = l.inst_id
order by MODULE,SUBSTR(s.PROGRAM,1,30);