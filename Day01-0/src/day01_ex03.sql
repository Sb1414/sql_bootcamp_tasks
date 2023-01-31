SELECT DISTINCT person_order.order_date AS action_date, person_visits.person_id
FROM person_order
INNER JOIN person_visits ON person_order.person_id = person_visits.person_id
ORDER BY order_date, person_id DESC ;