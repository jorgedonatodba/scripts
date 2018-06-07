col name format A31
col detected format 9999
col samples format 9999
col used format A5
col interval format 9999999

SELECT name,       
       detected_usages detected,
       total_samples   samples,
       currently_used  used,
       to_char(last_sample_date,'MMDDYYYY:HH24:MI') last_sample,
       sample_interval interval
  FROM dba_feature_usage_statistics
 WHERE name = 'Automatic Workload Repository'     OR  name like 'SQL%';