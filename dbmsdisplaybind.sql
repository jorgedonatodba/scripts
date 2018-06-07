select plan_table_output from table(dbms_xplan.display_cursor('7krjsdb7m5suq',null,'typical +PEEKED_BINDS'));

select plan_table_output from table(dbms_xplan.display_cursor('4q1m3b6s69b0k',null,'all +PEEKED_BINDS'));

select * from table( dbms_xplan.display_cursor(format=>'rowstats last ') );

SELECT *
FROM table(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'ALLSTATS LAST'));

set lines 200
set pages 500

select * from table( dbms_xplan.display_awr('9q6cgaq62t44x') );

set lines 10000
--select * from v$sql_plan where sql_id = '4q1m3b6s69b0k'

select * from V$SQL_BIND_CAPTURE where sql_id = '4q1m3b6s69b0k'