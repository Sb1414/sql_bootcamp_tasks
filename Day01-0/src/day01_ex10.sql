SELECT person.name AS person_name, menu.pizza_name AS pizza_name, pizzeria.name AS pizzeria
FROM person
JOIN person_order p on person.id = p.person_id
JOIN menu on p.menu_id = menu.id
JOIN pizzeria on menu.pizzeria_id = pizzeria.id
ORDER BY person_name, pizza_name, pizzeria;