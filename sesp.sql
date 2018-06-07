set feed off
set time on

---
col HOST_NAME format a35
---

conn DBACSI/fee9uf1yue@&1

alter session set NLS_DATE_FORMAT = 'dd/mm/yyyy HH24:mi:ss';

set feed on
set lines 1000

SELECT * FROM V$INSTANCE;

undef 1