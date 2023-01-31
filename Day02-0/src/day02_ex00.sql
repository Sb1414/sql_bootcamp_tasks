SELECT name, rating FROM pizzeria
WHERE name NOT IN (SELECT name FROM pizzeria
JOIN person_visits pv on pizzeria.id = pv.pizzeria_id);