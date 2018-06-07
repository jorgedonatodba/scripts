set lines 150 pages 1000
col STATUS format a25
col hrs format 999.99
select SESSION_KEY, INPUT_TYPE, STATUS,
 to_char(START_TIME,'dd/mm/yyyy hh24:mi') start_time,
 to_char(END_TIME,'dd/mm/yyyy hh24:mi') end_time,
 elapsed_seconds/3600 hrs
 from V$RMAN_BACKUP_JOB_DETAILS
 where END_TIME >= sysdate -7
 order by session_key;