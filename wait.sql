col kill format a50
col "Evento" format a35
col "SQLID" format a13
select a.INST_ID,
       a.P1,
       a.P2,
       substr(b.username,1,10)        "User",
       substr(a.sid,1,4)              "Sid",
       substr(c.spid,1,9)             "OS Pid",
       nvl(b.sql_id,'XXXXXXXXXXXXX')  "SQLID",
       substr(a.event,1,29)           "Evento",
       a.P1RAW  "ADDR",
       a.seconds_in_wait              "Secs",
       substr(b.status,1,4)           "Status",
       b.logon_time                   "Start Session",
       substr(b.program,1,30)          "Programa",
       'ALTER SYSTEM DISCONNECT SESSION ' || CHR(39) || a.SID ||','||b.SERIAL# || CHR(39) || ';' kill,
	   'alter system kill session '''|| b.sid ||','|| b.serial# ||',@'||b.inst_id||''';' killrac
	   --'alter system kill session '''|| b.sid ||','|| b.serial# ||',@'||b.inst_id||''' immediate;' killrac
from gv$session_wait a, gv$session b, gv$process c
where a.event not in ('SQL*Net message from client','SQL*Net message to client') 
and b.username is not null
and a.sid = b.sid
and decode(nvl(c.background, 0), 0, ' ', 'B') <> 'B'
and c.addr=b.paddr (+)
and c.spid is not null;