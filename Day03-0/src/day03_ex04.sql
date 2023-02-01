SELECT DISTINCT pizzeria.name AS pizzeria_name FROM pizzeria
JOIN menu on pizzeria.id = menu.pizzeria_id
JOIN person_order on menu.id = person_order.menu_id
WHERE menu.id IN (SELECT person_id FROM person_visits
JOIN person on person_visits.person_id = person.id
WHERE person.gender = 'female')
UNION
SELECT DISTINCT pizzeria.name AS pizzeria_name FROM pizzeria
JOIN menu on pizzeria.id = menu.pizzeria_id
JOIN person_order on menu.id = person_order.menu_id
WHERE menu.id IN (SELECT person_id FROM person_visits
JOIN person on person_visits.person_id = person.id
WHERE person.gender = 'male')
ORDER BY pizzeria_name;
