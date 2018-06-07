set term off
store set %temp%\sqlenv replace
set term on
set lines 1000
COL OPNAME FORMAT A50
COL MESSAGE FORMAT A100
col "%_complete" format a10
col "Falta" format a15
col "Executado" format a10
col "Total" format a10
select v$session_longops.sid, v$session_longops.username
,      to_char(trunc((sofar/totalwork)*100, 2), '99D99') "%_complete"
,      opname
,      lpad(trim(to_char(floor((time_remaining)/(3600)), 900)) ||':'|| trim(to_char(floor((((time_remaining)) - (floor(((time_remaining))/(3600))*3600))/60), 900)) ||':'||trim(to_char(mod((((time_remaining)) - (floor(((time_remaining))/(3600))*3600)),60), 900)), 10, ' ') "Falta"
,      lpad(trim(to_char(floor((elapsed_seconds)/(3600)), 900)) ||':'|| trim(to_char(floor((((elapsed_seconds)) - (floor(((elapsed_seconds))/(3600))*3600))/60), 900)) ||':'||trim(to_char(mod((((elapsed_seconds)) - (floor(((elapsed_seconds))/(3600))*3600)),60), 900)), 10, ' ') "Executado"
,      lpad(trim(to_char(floor((time_remaining+elapsed_seconds)/(3600)), 900)) ||':'|| trim(to_char(floor((((time_remaining+elapsed_seconds)) - (floor(((time_remaining+elapsed_seconds))/(3600))*3600))/60), 900)) ||':'||trim(to_char(mod((((time_remaining+elapsed_seconds)) - (floor(((time_remaining+elapsed_seconds))/(3600))*3600)),60), 900)), 10, ' ') "Total"
,      target
,      message
from   v$session_longops
,      v$session
where  (sofar/totalwork)*100 <> 100
and    totalwork <> 0
and    v$session_longops.sid = v$session.sid
order  by username, opname
/
@%temp%\sqlenv.sql
set term on;