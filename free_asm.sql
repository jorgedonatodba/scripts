select
  group_number "Group",
  name "Group Name",
  state "State",
  type "Type",
  total_mb "Total MB",
  free_mb "Free MB",
  100-((free_mb/total_mb)*100) as "Percentual Ocupado"
from
  v$asm_diskgroup
/
