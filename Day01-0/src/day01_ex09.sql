SELECT name FROM pizzeria
WHERE name NOT IN (SELECT name FROM pizzeria
JOIN person_visits pv on pizzeria.id = pv.pizzeria_id);

SELECT name FROM pizzeria
WHERE NOT EXISTS (SELECT pizzeria_id FROM person_visits
WHERE pizzeria.id = pizzeria_id);