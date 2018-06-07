select count(1) from (select TIPO_BOP, count(1) from EBOP.BOP_ENVOLVIDOS_OCORRENCIA_NORM
group by TIPO_BOP);

--10g
set lines 190
col OUTLINE_HINTS for a70
SELECT created, status, sql_attr.attr_val outline_hints
FROM dba_sql_profiles sql_profiles, sys.SQLPROF$ATTR sql_attr
WHERE sql_profiles.signature = sql_attr.signature
AND sql_profiles.name = 'SYS_SQLPROF_02591cd8e4eb0003'
ORDER BY sql_attr.attr# ASC;

--11g
SELECT extractValue(value(h),'.') AS hint
FROM sys.sqlobj$data od, sys.sqlobj$ so,
table(xmlsequence(extract(xmltype(od.comp_data),'/outline_data/hint'))) h
WHERE so.name = 'opt_estimate'
AND so.signature = od.signature
AND so.category = od.category
AND so.obj_type = od.obj_type
AND so.plan_id = od.plan_id;
