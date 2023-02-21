SELECT name, count(person_id) AS count_of_visits
FROM person_visits
JOIN person on person.id = person_visits.person_id
GROUP BY name
ORDER BY count_of_visits DESC, name ASC LIMIT 4;