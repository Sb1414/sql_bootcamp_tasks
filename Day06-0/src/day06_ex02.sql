SELECT person.name AS name, pizza_name, price, (price - price * discount / 100)
    AS discount_price, pizzeria.name AS pizzeria_name
FROM person_discounts
JOIN person on person.id = person_discounts.person_id
JOIN person_order on person.id = person_order.person_id
JOIN menu on person_order.menu_id = menu.id
JOIN pizzeria on pizzeria.id = person_discounts.pizzeria_id
ORDER BY name, pizza_name;