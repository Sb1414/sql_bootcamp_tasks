SELECT person_order.order_date AS action_date, concat(person.name, ' (age:', age , ')') AS person_information
FROM person_order
NATURAL JOIN (SELECT id AS person_id, age, name FROM person) person
ORDER BY action_date, person_information ;