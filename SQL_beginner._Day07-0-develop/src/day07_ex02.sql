WITH order_ AS (SELECT pizzeria.name AS name, count(person_id) AS count, 'order' AS action_type
                FROM person_order
                JOIN menu on menu.id = person_order.menu_id
                JOIN pizzeria on menu.pizzeria_id = pizzeria.id
                GROUP BY name
                ORDER BY action_type ASC, count DESC LIMIT 3),
     visit_ AS (SELECT pizzeria.name AS name, count(person_id) AS count, 'visit' AS action_type
                FROM person_visits
                JOIN pizzeria on person_visits.pizzeria_id = pizzeria.id
                GROUP BY name
                ORDER BY action_type ASC, count DESC LIMIT 3)
SELECT * FROM order_
UNION
SELECT * FROM visit_
ORDER BY action_type ASC, count DESC;