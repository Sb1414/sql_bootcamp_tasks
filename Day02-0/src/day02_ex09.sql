WITH female_cte (name) AS
    (SELECT name FROM person
    JOIN person_order po on person.id = po.person_id
    JOIN menu m on m.id = po.menu_id
    WHERE gender = 'female' AND pizza_name = 'pepperoni pizza' )
SELECT female_cte.name FROM female_cte
    JOIN person on person.name = female_cte.name
JOIN person_order po on person.id = po.person_id
    JOIN menu m on m.id = po.menu_id
WHERE pizza_name = 'cheese pizza'
ORDER BY name;