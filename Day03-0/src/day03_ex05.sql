WITH andr AS (SELECT id FROM person WHERE name = 'Andrey'),
     andr_visit AS (SELECT pizzeria.name AS pizzeria_name FROM person_visits
         JOIN pizzeria on person_visits.pizzeria_id = pizzeria.id
        JOIN andr on person_visits.person_id = andr.id),
     andr_order AS (SELECT pizzeria.name AS pizzeria_name FROM person_order
         JOIN menu m on person_order.menu_id = m.id
        JOIN pizzeria on pizzeria.id = m.pizzeria_id
        JOIN andr on person_order.person_id = andr.id)
SELECT pizzeria_name FROM andr_visit
EXCEPT
SELECT pizzeria_name FROM andr_order;