COLUMN sid                  FORMAT a8
COLUMN serial             	FORMAT a8
COLUMN username             FORMAT a15
COLUMN event                FORMAT a50
COLUMN state                FORMAT a20
COLUMN LAST_CALL_ET         FORMAT 9,999
COLUMN module               FORMAT a30
COLUMN program              FORMAT a30   

alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select inst_id,substr(sid,1,8) as sid,substr(serial#,1,8) as serial, substr(username,1,15) as username,sql_id,lockwait,substr(EVENT,1,50) as event,substr(STATE,1,20) as state,LAST_CALL_ET, wait_time,seconds_in_wait,	substr(module,1,30) as module ,substr(program,1,30),logon_time,status, client_identifier, client_info
from gv$session
where type = 'USER'
and event not in ('SQL*Net message from client') 
and status = 'ACTIVE'
and username not in ('ACNDBA','DBACSI','SYS','DBSNMP')
order by LAST_CALL_ET desc;