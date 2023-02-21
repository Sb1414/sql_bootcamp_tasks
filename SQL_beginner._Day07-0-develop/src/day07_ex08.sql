SELECT address, pizzeria.name AS name, count(person_order.person_id) AS count_of_orders
FROM person_order
JOIN menu on menu.id = person_order.menu_id
JOIN person on person.id = person_order.person_id
JOIN pizzeria on menu.pizzeria_id = pizzeria.id
GROUP BY address, pizzeria.name
ORDER BY address,name;