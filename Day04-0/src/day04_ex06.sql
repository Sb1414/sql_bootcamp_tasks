CREATE VIEW mv_dmitriy_visits_and_eats AS

SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN person_visits on pizzeria.id = person_visits.pizzeria_id
JOIN person on person.id = person_visits.person_id
JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
    WHERE menu.price < '800' AND visit_date = '2022-01-08' AND person.name = 'Dmitriy';