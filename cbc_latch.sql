select file#, block#,
decode(class#,
    1,'data block',
    2,'sort block',
    3,'save undo block', 
    4,'segment header',
    5,'save undo header',
    6,'free list',
    7,'extent map',
    8,'1st level bmb',
    9,'2nd level bmb',
    10,'3rd level bmb', 
    11,'bitmap block',
    12,'bitmap index block',
    13,'file header block',
    14,'unused',
    15,'system undo header',
    16,'system undo block', 
    17,'undo header',
    18,'undo block') 
        class_type, 
    status
from v$bh
where objd = 99360
order by 1,2,3
/


select dbarfil, dbablk, tch
from x$bh
where hladdr = '00000002D5A4FB60'; 

select hladdr
from x$bh
where dbarfil = 6
and dbablk = 220;

select latch# from v$latch
where name = 'cache buffers chains';

select count(1) cnt from v$latch_children where latch# = 203; 
