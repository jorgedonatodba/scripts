COLUMN sid                  FORMAT a8
COLUMN serial              FORMAT a8
COLUMN username             FORMAT a15
COLUMN event                FORMAT a50
COLUMN state                FORMAT a20
COLUMN LAST_CALL_ET         FORMAT 9,999
COLUMN module               FORMAT a30
COLUMN program              FORMAT a30
COLUMN COMANDO              FORMAT a30
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
select inst_id,substr(sid,1,8) as sid,substr(serial#,1,8) as serial, substr(username,1,15) as username,
DECODE(COMMAND, 
  1,'CREATE TABLE' , 2,'INSERT',
  3,'SELECT' , 6,'UPDATE',
  7,'DELETE' , 9,'CREATE INDEX',
  10,'DROP INDEX' ,11,'ALTER INDEX',
  12,'DROP TABLE' ,13,'CREATE SEQ',
  14,'ALTER SEQUENCE' ,15,'ALTER TABLE',
  16,'DROP SEQU.' ,17,'GRANT',
  19,'CREATE SYN.' ,20,'DROP SYNONYM',
  21,'CREATE VIEW' ,22,'DROP VIEW',
  23,'VALIDATE INDEX' ,24,'CREATE PROCEDURE',
  25,'ALTER PROCEDURE' ,26,'LOCK TABLE', 
  42,'ALTER SESSION' ,44,'COMMIT',
  45,'ROLLBACK' ,46,'SAVEPOINT',
  47,'PL/SQL EXEC' ,48,'SET TRANSACTION',
  60,'ALTER TRIGGER' ,62,'ANALYZE TABLE',
  63,'ANALYZE INDEX' ,71,'CREATE SNAPSHOT LOG',
  72,'ALTER SNAPSHOT LOG' ,73,'DROP SNAPSHOT LOG',
  74,'CREATE SNAPSHOT' ,75,'ALTER SNAPSHOT',
  76,'DROP SNAPSHOT' ,85,'TRUNCATE TABLE',
  0,'NO COMMAND', '? : '||COMMAND) COMANDO,
PREV_SQL_ID,sql_id,lockwait,substr(EVENT,1,50) as event,substr(STATE,1,20) as state,LAST_CALL_ET, wait_time,seconds_in_wait, WAIT_TIME_MICRO, substr(machine,1,30),  substr(module,1,30) as module ,substr(program,1,30),logon_time,status, client_identifier, client_info
from gv$session
where type = 'USER'
and event not in ('SQL*Net message from client')
and status = 'ACTIVE'
and username not in ('ACNDBA','DBACSI','SYS','DBSNMP')
--and machine = 'joaquina.sesp.es.gov.br.local'
--and last_call_et > 0
order by LAST_CALL_ET desc;