WITH order_ AS (SELECT pizzeria.name AS name, count(person_id) AS count
                FROM person_order
                JOIN menu on menu.id = person_order.menu_id
                JOIN pizzeria on menu.pizzeria_id = pizzeria.id
                GROUP BY name
                ORDER BY count DESC),
     visit_ AS (SELECT pizzeria.name AS name, count(person_id) AS count
                FROM person_visits
                JOIN pizzeria on person_visits.pizzeria_id = pizzeria.id
                GROUP BY name
                ORDER BY count DESC),
     all_ AS (SELECT * FROM order_
                UNION
                SELECT * FROM visit_
                ORDER BY count DESC)
SELECT name, sum(count) AS total_count FROM all_
GROUP BY name
ORDER BY total_count DESC, name ASC;
