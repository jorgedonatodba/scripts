-- +----------------------------------------------------------------------------+
-- |                          Jeffrey M. Hunter                                 |
-- |                      jhunter@idevelopment.info                             |
-- |                         www.idevelopment.info                              |
-- |----------------------------------------------------------------------------|
-- |      Copyright (c) 1998-2009 Jeffrey M. Hunter. All rights reserved.       |
-- |----------------------------------------------------------------------------|
-- | DATABASE : Oracle                                                          |
-- | FILE     : asm_diskgroups.sql                                              |
-- | CLASS    : Automatic Storage Management                                    |
-- | PURPOSE  : Provide a summary report of all disk groups.                    |
-- | NOTE     : As with any code, ensure to test this script in a development   |
-- |            environment before attempting to run it in production.          |
-- +----------------------------------------------------------------------------+

SET LINESIZE  145
SET PAGESIZE  9999
SET VERIFY    off

COLUMN group_name             	FORMAT a20           HEAD 'Disk Group|Name'
COLUMN sector_size            	FORMAT 99,999        HEAD 'Sector|Size'
COLUMN block_size             	FORMAT 99,999        HEAD 'Block|Size'
COLUMN allocation_unit_size   	FORMAT 999,999,999   HEAD 'Allocation|Unit Size'
COLUMN state                  	FORMAT a11           HEAD 'State'
COLUMN type                   	FORMAT a6            HEAD 'Type'
COLUMN total_mb               	FORMAT 999,999,999   HEAD 'Total Size (MB)'
COLUMN used_mb                	FORMAT 999,999,999   HEAD 'Used Size (MB)'
COLUMN pct_used               	FORMAT 999.99        HEAD 'Pct. Used'
COLUMN USABLE_FILE_MB         	FORMAT 999,999,999   HEAD 'USABLE FILE (MB)'
COLUMN REQUIRED_MIRROR_FREE_MB  FORMAT 999,999,999   HEAD 'REQUIRED MIRROR FREE (MB)'

break on report on disk_group_name skip 1

compute sum label "Grand Total: " of total_mb used_mb on report

SELECT
    name                                     group_name
  , sector_size                              sector_size
  , block_size                               block_size
  , allocation_unit_size                     allocation_unit_size
  , state                                    state
  , type                                     type
  , USABLE_FILE_MB							 USABLE_FILE_MB
  , REQUIRED_MIRROR_FREE_MB					 REQUIRED_MIRROR_FREE_MB
  , total_mb                                 total_mb
  , (total_mb - free_mb)                     used_mb
  , ROUND((1- (free_mb / total_mb))*100, 2)  pct_used
FROM
    v$asm_diskgroup
WHERE
    total_mb != 0
ORDER BY
    name
/

