SELECT COMANDO FROM 
  (select GRANTEE, 'grant '|| PRIVILEGE || ' on '||owner||'.'||TABLE_NAME||' to '||GRANTEE||(case GRANTABLE when 'YES' then ' WITH GRANT OPTION' end)||';' "COMANDO"
  from dba_tab_privs
  UNION ALL
  select GRANTEE, 'grant '|| PRIVILEGE || ' to '||GRANTEE||(case ADMIN_OPTION when 'YES' then ' WITH ADMIN OPTION' end)||';' "COMANDO"
  from dba_sys_privs
  UNION ALL
  select GRANTEE, 'grant '|| GRANTED_ROLE || ' to '||GRANTEE||(case ADMIN_OPTION when 'YES' then ' WITH ADMIN OPTION' end)||';' "COMANDO"
  from dba_role_privs)
where grantee like upper('&1')
ORDER BY GRANTEE;