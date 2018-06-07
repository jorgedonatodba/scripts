select owner,substr(object_name,1,35) nome,object_type,created,last_ddl_time from dba_objects
where owner not in ('SYS','SYSTEM','SUPORTE','PUBLIC','CTXSYS','OWF_MGR','ORDSYS','ORDPLUGINS','PERFSTAT') and
 object_type in ('PROCEDURE','FUNCTION','PACKAGE','PACKAGE BODY','VIEW','TRIGGER') AND STATUS <> 'VALID'
 order by owner,object_type,object_name;