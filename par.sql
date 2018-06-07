col name format a40
col DISPLAY_VALUE format a30
col description format a40
col ISSES_MODIFIABLE format a10
col ISSYS_MODIFIABLE format a10
select name,DISPLAY_VALUE,ISSES_MODIFIABLE "SESSION",ISSYS_MODIFIABLE "SYSTEM" ,description  from v$parameter where name like '%&par%' order by 1 ;

