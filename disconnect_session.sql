Alter session set nls_date_format= 'DD/MM/YYYY HH24:MI:SS';
set lines 200
set pages 500

col USERNAME for a10
col TERMINAL for a10
col PROGRAM for a40
col SQL_ID for a10

SELECT 'alter system disconnect session '''|| sid ||','|| serial# ||''' immediate;'
  From v$session
 WHERE
   --STATUS='ACTIVE' AND
   USERNAME IS NOT NULL
   AND TRUNC(LAST_CALL_ET/3600)  >= 4; -- horas
   
Alter session set nls_date_format= 'DD/MM/YYYY HH24:MI:SS';
set lines 200
set pages 500

col USERNAME for a10
col TERMINAL for a10
col PROGRAM for a40
col SQL_ID for a10

SELECT 'alter system disconnect session '''|| sid ||','|| serial# ||',@'||inst_id||''' immediate;' 
  From gv$session
 WHERE
   --STATUS='ACTIVE' AND
   USERNAME IS NOT NULL
   AND TRUNC(LAST_CALL_ET/3600)  >= 1; -- horas