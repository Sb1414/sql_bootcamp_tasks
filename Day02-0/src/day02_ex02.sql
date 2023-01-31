SELECT COALESCE(person.name, '-') AS name_person, visit_date, COALESCE(pizzeria.name, '-') AS name_pizzeria
FROM person
FULL JOIN (SELECT * FROM person_visits WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-03')
    AS person_visits
    on (person.id = person_visits.person_id)
FULL JOIN pizzeria on (pizzeria.id = person_visits.pizzeria_id)
ORDER BY name_person, visit_date, name_pizzeria;