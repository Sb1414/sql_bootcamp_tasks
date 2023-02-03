CREATE VIEW v_price_with_discount AS

WITH table_dis_pr AS (SELECT price, round(price - price*0.1) AS discount_price FROM menu)

SELECT name, pizza_name, menu.price, (SELECT DISTINCT discount_price
FROM table_dis_pr WHERE menu.price = table_dis_pr.price) FROM person
JOIN person_order on person.id = person_order.person_id
JOIN menu on menu.id = person_order.menu_id
ORDER BY name, pizza_name;