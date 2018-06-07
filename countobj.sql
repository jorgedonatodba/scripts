set term off
store set &__DIR_TEMP.\sqlenv replace
set term on
set ver off
set feed off

col owner for a30
col object_type for a20
select owner,object_type,count(*)
from dba_objects
where owner not in ('SYS','SYSTEM','OUTLN','DBSNMP','AURORA$JIS$UTILITY$','TRACESVR',
                    'OSE$HTTP$ADMIN','AURORA$ORB$UNAUTHENTICATED','PERFSTAT',
                    'CTXSYS','MDSYS','ORDPLUGINS','ORDSYS','PUBLIC','WMSYS',
                    'EXFSYS','SYSMAN','TSMSYS','XDB','ORACLE_OCM','DMSYS',
                    'SI_INFORMTN_SCHEMA','OLAPSYS','WKSYS','WK_TEST','APEX_030200','APPQOSSYS','FLOWS_FILES',
                    'ORDDATA','LBACSYS','GSMADMIN_INTERNAL','OJVMSYS','DVSYS','DVF','APEX_040200','AUDSYS')
group by owner,object_type
order by owner,object_type;

@&__DIR_TEMP.\sqlenv
set term on
