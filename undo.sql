SELECT  t.inst_id,  r.segment_name, r.tablespace_name, s.sid, s.serial#, s.username, s.machine, t.status, t.cr_get, /*consistent gets*/ t.phy_io, /*physical io*/ t.used_ublk, /*Undo blocks used*/ t.noundo, /*Is a noundo transaction*/ substr(s.program, 1, 78) "COMMAND", s.USERNAME  "DB User", t.start_time, s.sql_address "Address", s.sql_hash_value "Sql Hash" FROM sys.gv_$session s, sys.gv_$transaction t, sys.dba_rollback_segs  r WHERE (t.inst_id = s.inst_id) and (t.addr = s.taddr) and (t.xidusn = r.segment_id) ORDER BY t.start_time;