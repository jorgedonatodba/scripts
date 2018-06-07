alter session set nls_date_format='dd/mm/yyyy';
col owner format a15
col table_name FORMAT a30
 SELECT OWNER,TABLE_NAME, LAST_ANALYZED FROM DBA_TABLES WHERE OWNER NOT IN ('SYS','SYSTEM') 
and table_name like upper('%&tab%')
 ORDER BY OWNER,TABLE_NAME ;