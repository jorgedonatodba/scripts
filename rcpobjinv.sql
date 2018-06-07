set echo off
set feedback off
set pages 0
set lines 100
prompt
prompt ************************************************
prompt Selecting all INVALID objects in the database...
prompt ************************************************
prompt
REM  Start spooling the results into a temporary file
spool /tmp/mk_objinv.tab
select /*+ rule */'alter ' || decode(object_type,'PACKAGE BODY','PACKAGE','UNDEFINED','SNAPSHOT',object_type) ||
' ' || owner || '.' || object_name || ' compile' ||
decode(object_type,'PACKAGE BODY',' body;',';')
from all_objects where status <> 'VALID'and object_type NOT IN ('SYNONYM','JAVA CLASS') and owner not in ('SYS','SYSTEM')
order by created
/
spool off
prompt
prompt
prompt ****************************
prompt Compiling INVALID objects...
prompt ****************************
prompt
@/tmp/mk_objinv.tab
prompt
prompt ****************************************
prompt Compilation of INVALID objects complete.
prompt ****************************************
prompt
set pages 100
set lines 120
--set echo on
set feedback on

