SELECT DISTINCT visit_date AS missing_date FROM person_visits
WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-10' AND visit_date NOT IN (SELECT visit_date FROM person_visits
WHERE (person_id = 1 OR person_id = 2));

-- SELECT CAST(missing_date AS DATE)
-- FROM generate_series('2022-01-01', '2022-01-10', interval '1 day') missing_date
-- FULL JOIN (SELECT visit_date FROM person_visits
-- WHERE (person_id = 1 OR person_id = 2) AND visit_date BETWEEN '2022-01-01' AND '2022-01-10') AS t
-- ON missing_date = t.visit_date WHERE t.visit_date IS  NULL
-- ORDER BY missing_date;
