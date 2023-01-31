SELECT person_order.order_date AS action_date, concat(person.name, ' (age:', age , ')') AS person_information
FROM person_order
INNER JOIN person ON person.id = person_order.person_id
ORDER BY action_date, person_information ;