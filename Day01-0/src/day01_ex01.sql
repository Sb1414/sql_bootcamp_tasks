SELECT * FROM (SELECT name AS object_name FROM person
UNION
SELECT pizza_name AS object_name FROM menu) AS data
ORDER BY object_name;