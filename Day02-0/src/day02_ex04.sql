WITH TABLE_PIZZA_CTE (id, name)
AS (SELECT id, name FROM pizzeria),
TABLE_MENU_CTE (pizzeria_id, pizza_name, price)
AS (SELECT pizzeria_id, pizza_name, price FROM menu
WHERE pizza_name = 'mushroom pizza' OR pizza_name = 'pepperoni pizza')

SELECT pizza_name AS Pizza_name, name AS pizzeria_name, price
FROM TABLE_PIZZA_CTE
JOIN TABLE_MENU_CTE on pizzeria_id = id
ORDER BY pizza_name, pizzeria_name;