SELECT DISTINCT person_order.order_date AS action_date, person.name AS person_name
FROM person_order
INNER JOIN person_visits ON person_order.person_id = person_visits.person_id
INNER JOIN person ON person.id = person_visits.person_id
ORDER BY action_date, person_name DESC ;