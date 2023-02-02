insert into person_order values (
    (SELECT max(id) + 1 FROM person_order),
        (SELECT DISTINCT person_id FROM person_visits WHERE person_id = (SELECT DISTINCT id FROM person
        WHERE name = 'Denis')),
        (SELECT DISTINCT id FROM menu WHERE pizza_name = 'sicilian pizza'), '2022-02-24') ,
    ((SELECT max(id) + 2 FROM person_order),
        (SELECT DISTINCT person_id FROM person_order WHERE person_id = (SELECT DISTINCT id FROM person
        WHERE name = 'Irina')),
        (SELECT DISTINCT id FROM menu WHERE pizza_name = 'sicilian pizza'), '2022-02-24');