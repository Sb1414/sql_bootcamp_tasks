WITH name1 (name, address, id) AS (
    SELECT name, address, id FROM person
), name2 (name, address, id) AS (
    SELECT name, address, id FROM person
)

SELECT name1.name AS person_name1, name2.name AS person_name2, name1.address AS common_address
FROM name1
INNER JOIN name2 on name2.address = name1.address
    WHERE NOT (name1.name = name2.name) AND name1.id > name2.id
ORDER BY person_name1, person_name2, common_address;
