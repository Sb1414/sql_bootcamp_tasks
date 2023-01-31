SELECT DISTINCT visit_date AS missing_date FROM person_visits
WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-10' AND visit_date NOT IN (SELECT visit_date FROM person_visits
WHERE (person_id = 1 OR person_id = 2));