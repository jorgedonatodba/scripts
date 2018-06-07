SET SERVEROUT ON
SET PAGESIZE 1000
SET LONG 2000000
SET LINESIZE 400

BEGIN
  DBMS_SQLTUNE.CREATE_SQLSET(sqlset_name => 'STS_2dtrsuzsp4c7z');
END;
/



DECLARE
  cur sys_refcursor;
BEGIN
open cur for
 select value(p) from table(dbms_sqltune.select_workload_repository(
      begin_snap => 63804,
      end_snap => 63811,
      basic_filter => 'sql_id IN (''2dtrsuzsp4c7z'') AND plan_hash_value = ''736138582''')) p;
    dbms_sqltune.load_sqlset('STS_2dtrsuzsp4c7z', cur);
  close cur;
END;
/



/*
 select value(p) from table(dbms_sqltune.select_workload_repository(
      begin_snap => 63804,
      end_snap => 12301,
      basic_filter => 'sql_id IN (''2dtrsuzsp4c7z'') AND plan_hash_value = ''736138582''')) p;
*/


SELECT *
--INTO stmt_count
FROM dba_sqlset
WHERE name = 'STS_2dtrsuzsp4c7z';

DECLARE
 my_plans PLS_INTEGER;
BEGIN
 my_plans := DBMS_SPM.LOAD_PLANS_FROM_SQLSET(
   sqlset_name => 'STS_2dtrsuzsp4c7z',
    fixed => 'YES');
END;
/



declare
my_int pls_integer;
begin
my_int := dbms_spm.load_plans_from_sqlset (
sqlset_name => 'STS_2dtrsuzsp4c7z',
basic_filter => 'plan_hash_value=''736138582''',
sqlset_owner => 'DBACSI',
fixed => 'YES',
enabled => 'YES');
DBMS_OUTPUT.PUT_line(my_int);
end;
/