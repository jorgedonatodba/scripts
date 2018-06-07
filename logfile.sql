col      member   format a50
col      archived format a10
col      bytes    format 9999999999
select   t1.group#
,        t1.status
,        t2.member
,        bytes 
,        t1.archived
from     v$log       t1
,        v$logfile   t2
where    t1.group# = t2.group#
order    by t1.group#;
cl col