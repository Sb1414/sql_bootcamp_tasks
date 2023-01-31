SELECT menu.pizza_name AS Pizza_name, pizzeria.name AS pizzeria_name FROM menu
JOIN person_order on menu.id = person_order.menu_id
JOIN person on person.id = person_order.person_id
JOIN pizzeria on pizzeria.id = menu.pizzeria_id
WHERE (person.name = 'Denis' OR person.name = 'Anna')
ORDER BY pizza_name, pizzeria_name;