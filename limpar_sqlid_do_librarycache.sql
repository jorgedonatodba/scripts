select INST_ID,ADDRESS, HASH_VALUE from GV$SQLAREA where SQL_ID like '9q6cgaq62t44x' order by INST_ID ;

exec sys.dbms_shared_pool.purge('00000002908B12E0, 2369857802','C');

exec sys.dbms_shared_pool.purge('00000002AB254300, 2369857802','C');

   INST_ID ADDRESS          HASH_VALUE
---------- ---------------- ----------
         1 00000002A31079D8 3927642334
         2 0000000286DB00B8 3927642334
		 
1   786    25653 INQUERIT  JDBC Thin  DED  ecops    27M  9q6cgaq62t44x SEL 416s  ACT  CPU  User I/O    db file sequential re   2m
1   121    30801 INQUERIT  JDBC Thin  DED  ecops    10M  9q6cgaq62t44x SEL 116s  ACT  CPU  User I/O    db file sequential re   1m
