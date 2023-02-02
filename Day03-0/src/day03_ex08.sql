insert into menu values ((SELECT max(id) + 1 FROM menu), (SELECT DISTINCT pizzeria_id FROM menu
WHERE pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'Dominos')), 'sicilian pizza', 900);