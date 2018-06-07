select value
  from v$parameter
  where name='_optim_peek_user_binds';

select	sum(case when max_cnt > 2 then 1 else 0 end) histograms,
        sum(case when max_cnt <= 2 then 1 else 0 end) no_histograms
      from (
        select table_name, max(cnt) max_cnt
          from (
                  select table_name, column_name, count(*) cnt
                  from dba_tab_histograms
                  group by table_name, column_name
                ) group by table_name
            );