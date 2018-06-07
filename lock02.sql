SELECT substr(se.module,1,20), substr(se.program,1,20), DECODE (lk.BLOCK, 0, 'No', 1, 'Yes', 2, 'Global') BLOCK, substr(ob.object_name,1,25) objeto, se.lockwait, 
se.inst_id, lk.SID, substr(se.username,1,15) username, se.osuser, se.machine,se.client_identifier,se.client_info,
       DECODE (lk.TYPE,
               'TX', 'Transaction',
               'TM', 'DML',
               'UL', 'PL/SQL User Lock',
               lk.TYPE
              ) lock_type,
       DECODE (lk.lmode,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.lmode)
              ) mode_held,
       DECODE (lk.request,
               0, 'None',
               1, 'Null',
               2, 'Row-S (SS)',
               3, 'Row-X (SX)',
               4, 'Share',
               5, 'S/Row-X (SSX)',
               6, 'Exclusive',
               TO_CHAR (lk.request)
              ) mode_requested,
       TO_CHAR (lk.id1) lock_id1, TO_CHAR (lk.id2) lock_id2, ob.owner,
       ob.object_type 
  FROM gv$lock lk, dba_objects ob, gv$session se
 WHERE lk.SID = se.SID
   AND lk.id1 = ob.object_id(+)
   AND (lk.inst_id = se.inst_id)
   and lk.request>0
order by BLOCK;