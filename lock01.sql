set lines 1000
column sess format A20
SELECT s.sql_id, s.prev_sql_id,s.logon_time,SUBSTR(l.sess,1,20) as sess, s.inst_id, SUBSTR(s.username,1,15) as username, id1, id2, lmode, request, l.type,s.module,s.program, s.client_identifier, s.client_info
FROM GV$SESSION s,( SELECT substr(DECODE(request,0,'HOLDER: ','Waiter: ')||sid,1,12) sess,
                    id1, id2, lmode, request, type, sid, inst_id
                    FROM GV$LOCK
                    WHERE (id1, id2, type) IN
                       (SELECT id1, id2, type FROM GV$LOCK WHERE request>0)
                         ORDER BY id1, request) l
WHERE s.sid     = l.sid
AND   s.inst_id = l.inst_id ;