col window_name format a17
col RESOURCE_PLAN format a25
col LAST_START_DATE format a50
col duration format a15
col enabled format a5
select window_name, RESOURCE_PLAN, LAST_START_DATE, DURATION, enabled from DBA_SCHEDULER_WINDOWS;