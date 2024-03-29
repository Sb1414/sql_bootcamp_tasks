SELECT DISTINCT pizza_name, count(person_order.order_date) AS order_count FROM pizzeria
JOIN menu ON
menu.pizzeria_id = pizzeria.id
JOIN person_order ON
menu.id = person_order.menu_id
GROUP BY pizza_name
ORDER BY order_count DESC;

-- SELECT  pizza_name AS pizza_name FROM menu
-- UNION
-- SELECT  pizza_name FROM menu ORDER BY pizza_name DESC;
