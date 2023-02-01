SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN person_visits on pizzeria.id = person_visits.pizzeria_id
JOIN person on person.id = person_visits.person_id
JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
    WHERE menu.price < '800' AND visit_date = '2022-01-08' AND person.name = 'Dmitriy';

-- SELECT pizzeria.name AS pizzeria_name, (SELECT visit_date
--     WHERE person_id = (SELECT id FROM person
--     WHERE person.name = 'Dmitriy'))
-- FROM person_visits
-- JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
-- JOIN pizzeria on pizzeria.id = menu.pizzeria_id
--     WHERE menu.price < '800' AND visit_date = '2022-01-08';