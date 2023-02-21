CREATE OR REPLACE FUNCTION fnc_fibonacci(in pstop integer DEFAULT 10) RETURNS SETOF INTEGER AS $$
    WITH RECURSIVE fib(a,b) AS (
        VALUES(1,1)
    UNION ALL
        SELECT b, a + b FROM fib
        WHERE b < pstop
   )
    SELECT a FROM fib;
$$ LANGUAGE SQL;

select * from fnc_fibonacci(100);
select * from fnc_fibonacci();

