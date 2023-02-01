SELECT person.name FROM person
JOIN person_order po on person.id = po.person_id
JOIN menu m on m.id = po.menu_id
WHERE (address = 'Moscow' OR address = 'Samara') AND gender = 'male'
  AND ((m.pizza_name = 'pepperoni pizza' OR m.pizza_name = 'mushroom pizza')
           OR (m.pizza_name = 'pepperoni pizza' AND m.pizza_name = 'mushroom pizza'))
ORDER BY name DESC;