set term off
store set %temp%\sqlenv replace
set term on
SET VERIFY OFF
SET HEAD ON
CLEAR COL
COL   COMMAND  FORMAT A120
accept SID1 char prompt 'Informe o SID: '
SELECT
         'Matar a sessão    :  ALTER SYSTEM KILL SESSION ' || CHR(39) || SID ||','||SERIAL# || CHR(39) || ';'        || chr(10) ||
         'Matar a sessão    :  ALTER SYSTEM DISCONNECT SESSION ' || CHR(39) || SID ||','||SERIAL# || CHR(39) || ' IMMEDIATE;'        || chr(10) ||
         'Trace ON (10046)  :  EXEC SYS.DBMS_SYSTEM.SET_EV('||SID||', '||SERIAL#||', 10046, 12, '''');' || chr(10) ||
         'Trace ON          :  EXEC SYS.DBMS_SYSTEM.SET_SQL_TRACE_IN_SESSION ('|| SID ||', '||SERIAL# ||', TRUE)'    || chr(10) ||
         'Trace OFF         :  EXEC SYS.DBMS_SYSTEM.SET_SQL_TRACE_IN_SESSION ('|| SID ||', '||SERIAL# ||', FALSE)'   || chr(10) ||
         'Explain           :  select * from table(dbms_xplan.display_cursor('||chr(39)||SQL_HASH_VALUE||chr(39)||',null,'||chr(39)||'ADVANCED'||chr(39)||'));' COMMAND
FROM     GV$SESSION
WHERE    GV$SESSION.SID = &SID1
UNION
SELECT   'Instance ID       : '||inst_id             || chr(10) ||
		 'Session ID        : '||SID                  || chr(10) ||
         'Process ID (Unix) : '||SPID                 || '       ( ps -ef|grep '||chr(34)||' '||spid||' '||chr(34)||'|grep -v grep )' || chr(10) ||
         'User SO           : '||OSUSER               || chr(10) ||
         'User Oracle       : '||GV$SESSION.USERNAME   || chr(10) ||
         'Status            : '||STATUS               || chr(10) ||
         'Schema            : '||SCHEMANAME           || chr(10) ||
         'Program           : '||GV$SESSION.PROGRAM    || chr(10) ||
         'Start Session     : '||GV$SESSION.logon_time || chr(10) ||
         'Tempo conexão     : '||lpad(floor(((sysdate-logon_time)*86400)/(3600)) ||':'|| lpad(floor((((sysdate-logon_time)*86400) - (floor(((sysdate-logon_time)*86400)/(3600))*3600))/60), 2, '0') ||':'||lpad(mod((((sysdate-logon_time)*86400) - (floor(((sysdate-logon_time)*86400)/(3600))*3600)),60), 2, '0'), 10, ' ')  || chr(10) ||
         'Idle Time         : '||lpad(trim(to_char(floor(last_call_et/(3600)),9000)||':'||trim(to_char(floor((last_call_et - (floor(last_call_et/(3600))*3600))/60),900))||':'||trim(to_char(mod((last_call_et - (floor(last_call_et/(3600))*3600)),60),900))), 10, ' ') COMMAND
FROM   GV$SESSION, V$PROCESS
WHERE  ADDR = PADDR
AND    GV$SESSION.SID = &SID1
/
cl col
UNDEF SID1
SET HEAD ON
SET VERIFY ON;
@%temp%\sqlenv.sql
set term on;