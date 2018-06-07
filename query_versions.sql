SELECT versions_starttime stime,
       versions_endtime endtime,
       versions_xid xid,
       CASE
          WHEN versions_operation = 'I' THEN 'INSERT'
          WHEN versions_operation = 'U' THEN 'UPDATE'
          WHEN versions_operation = 'D' THEN 'DELETE'
       END
          AS operation,
       id_inquerito
  FROM ebop.SINQ_INQUERITO versions between timestamp minvalue and maxvalue
 where id_inquerito = 221081
 order by stime;


SELECT xid, operation, start_scn, commit_scn, logon_user, undo_sql
FROM flashback_transaction_query
WHERE xid = HEXTORAW('08000800B0754C00');