CREATE OR REPLACE FUNCTION func_minimum(VARIADIC arr numeric[]) RETURNS numeric AS $$
    SELECT min(arr[i]) FROM generate_subscripts(arr, 1) g(i);
$$ LANGUAGE SQL;

SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);

-- generate_subscripts — это «функция, возвращающая множество», которая будет возвращать несколько
-- строк при ее вызове. Вот почему его чаще всего помещают в предложение FROM.
--
-- По умолчанию результаты generate_subscripts, которые встроены в Postgres, являются анонимными
-- и автоматически имеют любое имя, которое можно использовать в качестве дескриптора,
-- чтобы ссылаться на него в остальной части запроса. Это и есть g(i); это псевдоним для
-- таблицы (g) и столбца (i), возвращаемый generate_subscripts. Итак, это выражение:
-- FROM generate_subscripts($1, 1) g(i)
--
-- означает: выполнить функцию generate_subscripts и присвоить ее результаты таблице с именем «g»
-- с одним столбцом с именем «i»
--
-- или в форме SQL:
-- CREATE TABLE g ( i integer );
-- INSERT INTO g SELECT * FROM generate_subscripts(some_array, 1);
-- SELECT i FROM g ORDER BY i;
