insert into person_visits values ((SELECT max(id) + 1 FROM person_visits),
(SELECT DISTINCT person_id FROM person_visits WHERE person_id = (SELECT DISTINCT id FROM person
WHERE name = 'Denis')),
(SELECT DISTINCT pizzeria_id FROM menu
WHERE pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'Dominos')), '2022-02-24') ,
((SELECT max(id) + 2 FROM person_visits), (SELECT DISTINCT person_id FROM person_visits
WHERE person_id = (SELECT id FROM person WHERE name = 'Irina')), (SELECT DISTINCT pizzeria_id FROM menu
WHERE pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'Dominos')), '2022-02-24');