SELECT pizza_name, price, pizzeria.name AS pizzeria_name, person_visits.visit_date FROM person
JOIN person_visits on person.id = person_visits.person_id
JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
JOIN pizzeria on pizzeria.id = menu.pizzeria_id
WHERE person.name = 'Kate' AND price BETWEEN '800' AND '1000'
ORDER BY pizza_name, price, pizzeria_name;