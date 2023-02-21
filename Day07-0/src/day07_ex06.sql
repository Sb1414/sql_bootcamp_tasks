SELECT pizzeria.name AS name, count(person_order.person_id) AS count_of_orders,
       round(avg(price), 2) AS average_price, max(price) AS max_price,
       min(price) AS min_price
FROM person_order
JOIN menu on person_order.menu_id = menu.id
JOIN pizzeria on pizzeria.id = menu.pizzeria_id
GROUP BY name
ORDER BY name;