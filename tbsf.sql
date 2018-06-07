alter session set nls_numeric_characters=', .';
SET LINESIZE  200
SET PAGESIZE  9999
SET VERIFY    off

break on report on tablespace_name

compute sum label "Grand Total: " of Usado Alocado on report

select f.tablespace_name,  round(s2.ocupado,2) Usado, round((sum(f.bytes/1024/1024) - s2.ocupado),2) Livre, round(sum(f.bytes/1024/1024),2) Alocado, round(((round((s2.ocupado),2)/round(sum(f.bytes/1024/1024),2))*100),2) "% USADO"
from dba_data_files f,
( select s.tablespace_name, sum(s.bytes/1024/1024) Ocupado
  from dba_segments s
  group by s.tablespace_name) s2
where f.tablespace_name = s2.tablespace_name (+)
group by f.tablespace_name, s2.ocupado
order by 5 desc nulls last;
