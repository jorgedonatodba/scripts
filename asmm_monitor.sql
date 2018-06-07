https://support.oracle.com/epmos/faces/DocumentDisplay?_afrLoop=225482128770118&id=295626.1&_afrWindowMode=0&_adf.ctrl-state=euykh2ifr_376
select 
   component, 
   oper_type, 
   oper_mode, 
   initial_size/1024/1024 "Initial", 
   TARGET_SIZE/1024/1024  "Target", 
   FINAL_SIZE/1024/1024   "Final", 
   status,
   start_time
from 
   v$sga_resize_ops;
   
select component, current_size, min_size, user_specified_size from v$sga_dynamic_components;   

select 
   component, 
   current_size/1024/1024 "CURRENT_SIZE", 
   min_size/1024/1024 "MIN_SIZE",
   user_specified_size/1024/1024 "USER_SPECIFIED_SIZE", 
   last_oper_type "TYPE" 
from 
   v$sga_dynamic_components;
   
set lines 10000
 column component format a20
 select component , round(current_size/1024/1024,2) size_mb, 
  LAST_OPER_TYPE, OPER_COUNT, MIN_SIZE, MAX_SIZE
  from v$sga_dynamic_components
  where component like '%pool' 
  OR component ='DEFAULT buffer cache';   
   
SELECT POOL,NAME, ROUND(BYTES/(1024*1024),2) FREE_MB 
FROM V$SGASTAT WHERE
--POOL='shared pool' AND
NAME='free memory'
ORDER BY BYTES DESC;   

SELECT POOL,NAME, ROUND(BYTES/(1024*1024),2) FREE_MB 
FROM V$SGASTAT WHERE
--POOL='shared pool' AND
NAME='free memory'
ORDER BY BYTES DESC; 

col BYTES for 99999999999999999999999
select * from v$sgainfo;

--gc buffer busy acquire
--direct path read
--library cache: mutex X
--latch free

V$PGASTAT

Select * from  v$memory_target_advice
order by memory_size;

select component, oper_type, oper_mode,  parameter, initial_size, final_size, 
to_char(start_time,'dd/mm/yyyy  hh24:mi:ss') start_time, to_char(end_time,'dd/mm/yyyy  hh24:mi:ss') end_time
from v$memory_resize_ops;

SELECT  round(PGA_TARGET_FOR_ESTIMATE/1024/1024)  target_mb,
ESTD_PGA_CACHE_HIT_PERCENTAGE  cache_hit_perc,
ESTD_OVERALLOC_COUNT
FROM  V$PGA_TARGET_ADVICE;