CREATE INDEX idx_menu_unique ON menu(pizzeria_id, pizza_name);

SET enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT * FROM menu
WHERE pizza_name = 'cheese pizza';