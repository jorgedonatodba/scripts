SELECT /*+ GATHER_PLAN_STATISTICS */ p.prod_name, SUM(s.quantity_sold)
FROM         sales s, products p
WHERE      s.prod_id =p.prod_id
AND            p.prod_desc = 'Envoy Ambassador'
GROUP By p.prod_name ;


SELECT *
FROM table(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'ALLSTATS LAST'));