INSERT INTO person_order VALUES (generate_series((SELECT max(id) + 1 AS fuck FROM person_order)
    , (SELECT (max(id) + (SELECT(count(DISTINCT person_id)) FROM person_order)) AS fuck FROM person_order), '1'),
    generate_series((SELECT min(person_id) AS fuck FROM person_order)
    , (SELECT max(person_id) AS fuck FROM person_order),
    '1'), (SELECT id FROM menu WHERE pizza_name = 'greek pizza'), '2022-02-25');
