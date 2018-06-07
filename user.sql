select username,substr(account_status,1,15) STATUS,created, DEFAULT_TABLESPACE "DEFAULT", substr(TEMPORARY_TABLESPACE,1,10) "TEMPORARY", substr(PROFILE,1,10) PROFILE, PASSWORD, EXPIRY_DATE
from dba_users
where username like upper('%&login%');