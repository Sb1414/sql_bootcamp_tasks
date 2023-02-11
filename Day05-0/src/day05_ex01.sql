SET enable_indexscan = ON;
SET enable_seqscan = OFF; -- для избежания последовательного сканирования
EXPLAIN  ANALYZE
SELECT pizza_name, pizzeria.name AS pizzeria_name
FROM menu
JOIN pizzeria on menu.pizzeria_id = pizzeria.id;