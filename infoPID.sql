SET VERIFY OFF
SET HEAD ON
CLEAR COL
COL   COMMAND  FORMAT A90
accept PID1 char prompt 'Informe o PID: '
SELECT
         'Matar a sessão    :  ALTER SYSTEM KILL SESSION ' || CHR(39) || SID ||','||V$SESSION.SERIAL# || CHR(39) || ';'        || chr(10) ||
         'Trace ON          :  EXEC SYS.DBMS_SYSTEM.SET_SQL_TRACE_IN_SESSION ('|| SID ||', '||V$SESSION.SERIAL# ||', TRUE)'    || chr(10) ||
         'Trace OFF         :  EXEC SYS.DBMS_SYSTEM.SET_SQL_TRACE_IN_SESSION ('|| SID ||', '||V$SESSION.SERIAL# ||', FALSE)'   COMMAND
FROM     V$SESSION, V$PROCESS
WHERE    ADDR = PADDR
AND      V$PROCESS.SPID = '&PID1'
UNION
SELECT   'Session ID        : '||SID                  || chr(10) ||
         'Process ID (Unix) : '||SPID                 || '       ( ps -ef|grep '||spid||'|grep -v grep )' || chr(10) ||
         'User SO           : '||OSUSER               || chr(10) ||
         'User Oracle       : '||V$SESSION.USERNAME   || chr(10) ||
         'Status            : '||STATUS               || chr(10) ||
         'Schema            : '||SCHEMANAME           || chr(10) ||
         'Program           : '||V$SESSION.PROGRAM    || chr(10) ||
         'Tempo conexão     : '||lpad(floor(((sysdate-logon_time)*86400)/(3600)) ||':'|| lpad(floor((((sysdate-logon_time)*86400) - (floor(((sysdate-logon_time)*86400)/(3600))*3600))/60), 2, '0') ||':'||lpad(mod((((sysdate-logon_time)*86400) - (floor(((sysdate-logon_time)*86400)/(3600))*3600)),60), 2, '0'), 10, ' ')  COMMAND
FROM     V$SESSION, V$PROCESS
WHERE    ADDR = PADDR
AND      V$PROCESS.SPID = '&PID1'
/
cl col
UNDEF SID1
SET HEAD ON
SET VERIFY ON;