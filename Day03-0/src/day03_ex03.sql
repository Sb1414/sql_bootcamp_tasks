SELECT DISTINCT pizzeria.name AS pizzeria_name FROM pizzeria
JOIN person_visits on pizzeria.id = person_visits.pizzeria_id
WHERE person_visits.pizzeria_id IN (SELECT person_id FROM person_visits
JOIN person on person_visits.person_id = person.id
WHERE person.gender = 'female')
UNION ALL
SELECT DISTINCT pizzeria.name AS pizzeria_name FROM pizzeria
JOIN person_visits on pizzeria.id = person_visits.pizzeria_id
WHERE person_visits.pizzeria_id IN (SELECT person_id FROM person_visits
JOIN person on person_visits.person_id = person.id
WHERE person.gender = 'male')
ORDER BY pizzeria_name;
