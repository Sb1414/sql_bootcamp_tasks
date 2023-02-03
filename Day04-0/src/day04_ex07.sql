WITH table_pizza AS (SELECT pizzeria.id FROM pizzeria
                    JOIN menu on pizzeria.id = menu.pizzeria_id
                    WHERE menu.price < '800'),
     table_visits AS (SELECT pizzeria.id FROM person_visits
					   JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
					   JOIN person on person_visits.person_id = person.id
					   WHERE visit_date = '2022-01-08' AND person.name = 'Dmitriy')

INSERT INTO person_visits VALUES ((SELECT max(id) + 1 AS id FROM person_visits),
                                  (SELECT DISTINCT person_id FROM person_visits
                                      JOIN person on person_visits.person_id = person.id
                                  WHERE name = 'Dmitriy'),
                                  (SELECT * FROM table_pizza WHERE id NOT IN (SELECT * FROM table_visits) LIMIT 1),
                                  '2022-01-08');
DROP VIEW mv_dmitriy_visits_and_eats;
CREATE VIEW mv_dmitriy_visits_and_eats AS
    SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN person_visits on pizzeria.id = person_visits.pizzeria_id
JOIN person on person.id = person_visits.person_id
JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
    WHERE menu.price < '800' AND visit_date = '2022-01-08' AND person.name = 'Dmitriy';

-- REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;
-- SELECT * FROM mv_dmitriy_visits_and_eats;