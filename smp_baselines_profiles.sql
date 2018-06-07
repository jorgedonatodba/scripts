SELECT sql_id,
       sql_handle,
       s.plan_hash_value,
       S.CHILD_NUMBER,
       to_char(force_matching_signature) fms,
       to_char(exact_matching_signature) ems,
       sql_plan_baseline,
       creator,
       dspb.parsing_schema_name,
       created,
       last_modified,
       last_verified,
       last_executed,
       enabled,
       accepted,
       fixed,
       sob.*
  FROM v$sql s, dba_sql_plan_baselines dspb, sys.sqlobj$data sob
 WHERE s.sql_plan_baseline (+)= dspb.plan_name
 AND to_char(exact_matching_signature) = to_char(sob.signature)
 --AND sql_plan_baseline IS NOT NULL
 
    SELECT so.name,
          so.category,
          so.signature,
          st.sql_text,
          ad.created,
          ad.last_modified,
          ad.description,
          DECODE (ad.origin,  1, 'MANUAL',  2, 'AUTO',  'UNKNOWN'),
          DECODE (BITAND (so.flags, 1), 1, 'ENABLED', 'DISABLED'),
          DECODE (BITAND (sq.flags, 1), 1, 'YES', 'NO'),
          DECODE (so.obj_type,  1, 'SQL PROFILE',  2, 'SQL PLAN',  'UNKNOWN'),
          ad.task_id,
          ad.task_exec_name,
          ad.task_obj_id,
          ad.task_fnd_id,
          ad.task_rec_id,
		  sob.*
     FROM sys.sqlobj$ so,
          sys.sqlobj$auxdata ad,
          sys.sql$text st,
          sys.sql$ sq,
		  sys.sqlobj$data sob
    WHERE     so.signature = st.signature
          AND so.signature = ad.signature
          AND so.category = ad.category
          AND so.signature = sq.signature
          AND so.category = sob.category
          AND so.signature = sob.signature
		  AND SO.NAME = 'SYS_SQLPROF_015fb65cbc6c0004'
          --AND so.obj_type = 1
          --AND ad.obj_type = 1
		  ;