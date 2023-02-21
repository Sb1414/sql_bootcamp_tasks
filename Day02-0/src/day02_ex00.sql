-- SELECT name, rating FROM pizzeria
-- WHERE name NOT IN (SELECT name FROM pizzeria
-- JOIN person_visits pv on pizzeria.id = pv.pizzeria_id);

SELECT name, rating FROM pizzeria
LEFT JOIN person_visits  on pizzeria.id = pizzeria_id
WHERE pizzeria_id is NULL;
