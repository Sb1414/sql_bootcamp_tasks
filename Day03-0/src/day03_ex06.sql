WITH t1 AS (SELECT DISTINCT pizzeria.id AS id, pizzeria.name AS pizzeria_name_1,
	        menu.pizza_name AS pizza_name, price AS price FROM menu
            JOIN pizzeria ON pizzeria.id = menu.pizzeria_id),
     t2 AS (SELECT DISTINCT pizzeria.id AS id, pizzeria.name AS pizzeria_name_2,
	        menu.pizza_name AS pizza_name, price AS price FROM menu
            JOIN pizzeria ON pizzeria.id = menu.pizzeria_id)

SELECT DISTINCT t1.pizza_name, t1.pizzeria_name_1, t2.pizzeria_name_2, t1.price FROM t1
JOIN t2 on t1.pizza_name = t2.pizza_name AND t1.price = t2.price AND t1.id > t2.id;