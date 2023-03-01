--  ================== Day 00 ================== 
-- 00
SELECT name, age FROM person WHERE address = 'Kazan';
-- 01
SELECT name, age FROM person WHERE gender = 'female' AND address = 'Kazan' ORDER BY name;
-- 02
SELECT name, rating FROM pizzeria WHERE rating >= '3.5' AND rating <= '5' ORDER BY rating;
SELECT name, rating FROM pizzeria WHERE rating BETWEEN 3.5 AND 5 ORDER BY rating;
-- 03
SELECT DISTINCT person_id
FROM person_visits
WHERE visit_date
    BETWEEN '2022-01-06' AND '2022-01-09' OR pizzeria_id = 2
ORDER BY person_id DESC;
-- 04
SELECT CONCAT(name, ' (age:', age, ',gender:''', gender, ''',address:''', address, ''')')
    AS person_information
FROM person
ORDER BY person_information;
-- 05
SELECT (SELECT name FROM person WHERE person.id = person_order.person_id) AS NAME
FROM person_order WHERE (menu_id = 13 OR menu_id = 14 OR menu_id = 18) AND order_date = '2022-01-07';
-- 06
SELECT (SELECT name FROM person WHERE person.id = person_order.person_id) AS NAME,
        (SELECT name = 'Denis' FROM person WHERE person.id = person_order.person_id) AS check_name
FROM person_order WHERE (menu_id = 13 OR menu_id = 14 OR menu_id = 18) AND order_date = '2022-01-07';
-- 07
SELECT id, name,
       CASE
           WHEN age BETWEEN 10 AND 20 THEN 'interval #1'
           WHEN age BETWEEN 21 AND 23 THEN 'interval #2'
           ELSE 'interval #3'
       END interval_info
FROM person
ORDER BY interval_info;
-- 08
SELECT * FROM person_order WHERE id % 2 = 0
ORDER BY id;
-- 09
SELECT (SELECT name FROM person WHERE person.id = person_id) AS person_name ,
        (SELECT name FROM pizzeria WHERE pizzeria.id = pizzeria_id) AS pizzeria_name
FROM (SELECT person_id, pizzeria_id FROM person_visits WHERE visit_date BETWEEN '2022-01-07' AND '2022-01-09') AS pv
ORDER BY person_name, pizzeria_name DESC;

--  ================== Day 01 ================== 
-- 00
SELECT * FROM (SELECT id AS object_id, name AS object_name FROM person
UNION
SELECT id AS object_id, pizza_name AS object_name FROM menu) AS data
ORDER BY object_id, object_name;
-- 01
SELECT * FROM (SELECT name AS object_name FROM person
UNION
SELECT pizza_name AS object_name FROM menu) AS data
ORDER BY object_name;
-- 02
SELECT DISTINCT pizza_name, count(person_order.order_date) AS order_count FROM pizzeria
JOIN menu ON
menu.pizzeria_id = pizzeria.id
JOIN person_order ON
menu.id = person_order.menu_id
GROUP BY pizza_name
ORDER BY order_count DESC;
-- 03
SELECT DISTINCT person_order.order_date AS action_date, person_visits.person_id
FROM person_order
INNER JOIN person_visits ON person_order.person_id = person_visits.person_id
ORDER BY order_date, person_id DESC ;
-- 04
SELECT person_id AS person_id
FROM person_order
WHERE order_date = '2022-01-07'
EXCEPT ALL
SELECT person_id
FROM person_visits
WHERE visit_date = '2022-01-07'
-- 05
SELECT * FROM person, pizzeria
ORDER BY person.id, pizzeria.id;
-- 06
SELECT DISTINCT person_order.order_date AS action_date, person.name AS person_name
FROM person_order
INNER JOIN person_visits ON person_order.person_id = person_visits.person_id
INNER JOIN person ON person.id = person_visits.person_id
ORDER BY action_date, person_name DESC ;
-- 07
SELECT person_order.order_date AS action_date, concat(person.name, ' (age:', age , ')') AS person_information
FROM person_order
INNER JOIN person ON person.id = person_order.person_id
ORDER BY action_date, person_information ;
-- 08
SELECT person_order.order_date AS action_date, concat(person.name, ' (age:', age , ')') AS person_information
FROM person_order
NATURAL JOIN (SELECT id AS person_id, age, name FROM person) person
ORDER BY action_date, person_information ;
-- 09
SELECT name FROM pizzeria
WHERE name NOT IN (SELECT name FROM pizzeria
JOIN person_visits pv on pizzeria.id = pv.pizzeria_id);

SELECT name FROM pizzeria
WHERE NOT EXISTS (SELECT pizzeria_id FROM person_visits
WHERE pizzeria.id = pizzeria_id);
-- 10
SELECT person.name AS person_name, menu.pizza_name AS pizza_name, pizzeria.name AS pizzeria
FROM person
JOIN person_order p on person.id = p.person_id
JOIN menu on p.menu_id = menu.id
JOIN pizzeria on menu.pizzeria_id = pizzeria.id
ORDER BY person_name, pizza_name, pizzeria;

--  ================== Day 02 ================== 
-- 00
SELECT name, rating FROM pizzeria
LEFT JOIN person_visits  on pizzeria.id = pizzeria_id
WHERE pizzeria_id is NULL;
-- 01
SELECT DISTINCT visit_date AS missing_date FROM person_visits
WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-10' AND visit_date NOT IN (SELECT visit_date FROM person_visits
WHERE (person_id = 1 OR person_id = 2));
-- 02
SELECT COALESCE(person.name, '-') AS name_person, visit_date, COALESCE(pizzeria.name, '-') AS name_pizzeria
FROM person
FULL JOIN (SELECT * FROM person_visits WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03')
    AS person_visits
    on (person.id = person_visits.person_id)
FULL JOIN pizzeria on (pizzeria.id = person_visits.pizzeria_id)
ORDER BY name_person, visit_date, name_pizzeria;
-- 03
WITH TABLE_CTE (visit_date, person_id)
AS (SELECT visit_date, person_id FROM person_visits)
SELECT visit_date AS missing_date
FROM TABLE_CTE
WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-10' AND visit_date NOT IN  (SELECT visit_date
FROM person_visits WHERE (person_id = 1 OR person_id = 2))
GROUP BY missing_date;
-- 04
WITH TABLE_PIZZA_CTE (id, name)
AS (SELECT id, name FROM pizzeria),
TABLE_MENU_CTE (pizzeria_id, pizza_name, price)
AS (SELECT pizzeria_id, pizza_name, price FROM menu
WHERE pizza_name = 'mushroom pizza' OR pizza_name = 'pepperoni pizza')

SELECT pizza_name, name AS pizzeria_name, price
FROM TABLE_PIZZA_CTE
JOIN TABLE_MENU_CTE on pizzeria_id = id
ORDER BY pizza_name, pizzeria_name;
-- 05
SELECT name FROM person WHERE gender = 'female' AND age > 25
ORDER BY name;
-- SELECT menu.pizza_name AS Pizza_name, pizzeria.name AS pizzeria_name FROM menu
JOIN person_order on menu.id = person_order.menu_id
JOIN person on person.id = person_order.person_id
JOIN pizzeria on pizzeria.id = menu.pizzeria_id
WHERE (person.name = 'Denis' OR person.name = 'Anna')
ORDER BY pizza_name, pizzeria_name;
-- 07
SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN person_visits on pizzeria.id = person_visits.pizzeria_id
JOIN person on person.id = person_visits.person_id
JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
    WHERE menu.price < '800' AND visit_date = '2022-01-08' AND person.name = 'Dmitriy';
-- 08
SELECT person.name FROM person
JOIN person_order po on person.id = po.person_id
JOIN menu m on m.id = po.menu_id
WHERE (address = 'Moscow' OR address = 'Samara') AND gender = 'male'
  AND ((m.pizza_name = 'pepperoni pizza' OR m.pizza_name = 'mushroom pizza')
           OR (m.pizza_name = 'pepperoni pizza' AND m.pizza_name = 'mushroom pizza'))
ORDER BY name DESC;
-- 09
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
-- 10
WITH name1 (name, address, id) AS (
            SELECT name, address, id FROM person),
     name2 (name, address, id) AS (
            SELECT name, address, id FROM person)

SELECT name1.name AS person_name1, name2.name AS person_name2, name1.address AS common_address
FROM name1
INNER JOIN name2 on name2.address = name1.address
    WHERE NOT (name1.name = name2.name) AND name1.id > name2.id
ORDER BY person_name1, person_name2, common_address;

--  ================== Day 03 ================== 
-- 00
SELECT pizza_name, price, pizzeria.name AS pizzeria_name, person_visits.visit_date FROM person
JOIN person_visits on person.id = person_visits.person_id
JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
JOIN pizzeria on pizzeria.id = menu.pizzeria_id
WHERE person.name = 'Kate' AND price BETWEEN '800' AND '1000'
ORDER BY pizza_name, price, pizzeria_name;
-- 01
SELECT id AS menu_id FROM menu
    WHERE id NOT IN (SELECT menu_id FROM person_order)
ORDER BY menu_id;
-- 02
SELECT pizza_name, price, name AS pizzeria_name FROM menu
JOIN pizzeria on pizzeria.id = menu.pizzeria_id
    WHERE menu.id NOT IN (SELECT menu_id FROM person_order)
ORDER BY pizza_name, price;
-- 03
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
-- 04
SELECT DISTINCT pizzeria.name AS pizzeria_name FROM pizzeria
JOIN menu on pizzeria.id = menu.pizzeria_id
JOIN person_order on menu.id = person_order.menu_id
WHERE menu.id IN (SELECT person_id FROM person_visits
JOIN person on person_visits.person_id = person.id
WHERE person.gender = 'female')
UNION
SELECT DISTINCT pizzeria.name AS pizzeria_name FROM pizzeria
JOIN menu on pizzeria.id = menu.pizzeria_id
JOIN person_order on menu.id = person_order.menu_id
WHERE menu.id IN (SELECT person_id FROM person_visits
JOIN person on person_visits.person_id = person.id
WHERE person.gender = 'male')
ORDER BY pizzeria_name;
-- 05
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
-- 06
WITH t1 AS (SELECT DISTINCT pizzeria.id AS id, pizzeria.name AS pizzeria_name_1,
	        menu.pizza_name AS pizza_name, price AS price FROM menu
            JOIN pizzeria ON pizzeria.id = menu.pizzeria_id),
     t2 AS (SELECT DISTINCT pizzeria.id AS id, pizzeria.name AS pizzeria_name_2,
	        menu.pizza_name AS pizza_name, price AS price FROM menu
            JOIN pizzeria ON pizzeria.id = menu.pizzeria_id)

SELECT DISTINCT t1.pizza_name, t1.pizzeria_name_1, t2.pizzeria_name_2, t1.price FROM t1
JOIN t2 on t1.pizza_name = t2.pizza_name AND t1.price = t2.price AND t1.id > t2.id;
-- 07
insert into menu values (19, 2, 'greek pizza', 800);
-- 08
insert into menu values ((SELECT max(id) + 1 FROM menu), (SELECT DISTINCT pizzeria_id FROM menu
WHERE pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'Dominos')), 'sicilian pizza', 900);
-- 09
insert into person_visits values ((SELECT max(id) + 1 FROM person_visits),
(SELECT DISTINCT person_id FROM person_visits WHERE person_id = (SELECT DISTINCT id FROM person
WHERE name = 'Denis')),
(SELECT DISTINCT pizzeria_id FROM menu
WHERE pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'Dominos')), '2022-02-24') ,
((SELECT max(id) + 2 FROM person_visits), (SELECT DISTINCT person_id FROM person_visits
WHERE person_id = (SELECT id FROM person WHERE name = 'Irina')), (SELECT DISTINCT pizzeria_id FROM menu
WHERE pizzeria_id = (SELECT id FROM pizzeria WHERE name = 'Dominos')), '2022-02-24');
-- 10
insert into person_order values (
    (SELECT max(id) + 1 FROM person_order),
        (SELECT DISTINCT person_id FROM person_visits WHERE person_id = (SELECT DISTINCT id FROM person
        WHERE name = 'Denis')),
        (SELECT DISTINCT id FROM menu WHERE pizza_name = 'sicilian pizza'), '2022-02-24') ,
    ((SELECT max(id) + 2 FROM person_order),
        (SELECT DISTINCT person_id FROM person_order WHERE person_id = (SELECT DISTINCT id FROM person
        WHERE name = 'Irina')),
        (SELECT DISTINCT id FROM menu WHERE pizza_name = 'sicilian pizza'), '2022-02-24');
-- 11
UPDATE menu
SET price = price - (price / 10)
WHERE pizza_name = 'greek pizza';
-- 12
INSERT INTO person_order VALUES (generate_series((SELECT max(id) + 1 FROM person_order)
    , (SELECT (max(id) + (SELECT(count(DISTINCT person_id)) FROM person_order)) FROM person_order), '1'),
    generate_series((SELECT min(person_id) FROM person_order)
    , (SELECT max(person_id) FROM person_order),
    '1'), (SELECT id FROM menu WHERE pizza_name = 'greek pizza'), '2022-02-25');
-- 13
DELETE FROM person_order WHERE order_date = '2022-02-25';
DELETE FROM menu WHERE pizza_name = 'greek pizza';

--  ================== Day 04 ================== 
-- 00
CREATE VIEW v_persons_female AS
SELECT * FROM person
WHERE gender = 'female';

CREATE VIEW v_persons_male AS
SELECT * FROM person
WHERE gender = 'male';
-- 01
SELECT name FROM v_persons_female
UNION
SELECT name FROM v_persons_male
ORDER BY name;
-- 02
CREATE VIEW v_generated_dates AS
SELECT v_generated_dates::date
from generate_series('2022-01-01', '2022-01-31', interval '1 day') AS v_generated_dates;
-- 03
CREATE VIEW v_generated_dates AS
SELECT missing_date::date FROM
       generate_series('2022-01-01', '2022-01-31', interval '1 day') AS missing_date
EXCEPT
SELECT visit_date AS missing_date FROM person_visits
ORDER BY missing_date;
-- 04
CREATE VIEW v_symmetric_union AS
WITH R AS (SELECT * FROM person_visits WHERE visit_date = '2022-01-02'),
     S AS (SELECT * FROM person_visits WHERE visit_date = '2022-01-06')

SELECT ((SELECT person_id FROM R) - (SELECT person_id FROM S)) AS person_id UNION
SELECT ((SELECT person_id FROM S) - (SELECT person_id FROM R)) AS person_id
ORDER BY person_id;
-- 05
CREATE VIEW mv_dmitriy_visits_and_eats AS

SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN person_visits on pizzeria.id = person_visits.pizzeria_id
JOIN person on person.id = person_visits.person_id
JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
    WHERE menu.price < '800' AND visit_date = '2022-01-08' AND person.name = 'Dmitriy';
-- 06
CREATE VIEW mv_dmitriy_visits_and_eats AS

SELECT pizzeria.name AS pizzeria_name
FROM pizzeria
JOIN person_visits on pizzeria.id = person_visits.pizzeria_id
JOIN person on person.id = person_visits.person_id
JOIN menu on person_visits.pizzeria_id = menu.pizzeria_id
    WHERE menu.price < '800' AND visit_date = '2022-01-08' AND person.name = 'Dmitriy';
-- 07
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
-- 08
DROP VIEW IF EXISTS mv_dmitriy_visits_and_eats,
v_generated_dates, v_price_with_discount, v_persons_female, v_persons_male, v_symmetric_union;