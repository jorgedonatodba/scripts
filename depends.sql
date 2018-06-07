column c1 heading "object|level"         format a16
column c2 heading "object|name"          format a50
column c3 heading "referencing|object"   format a45

select
   lpad (' ', 2 * (level - 1)) || to_char (level, '999') as c1,
   referenced_owner || '.' || referenced_name || ' (' || referenced_type || ')' as c3,
   owner || '.' || name || ' (' || type || ')' as c2   
from 
   dba_dependencies
start with
   referenced_owner = upper('&objowner')
and   
   referenced_name = upper('&obj')
connect by prior 
    owner = referenced_owner
and prior 
    name = referenced_name
and prior 
    type= referenced_type;