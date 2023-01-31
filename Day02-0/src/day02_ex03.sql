WITH TABLE_CTE (visit_date, person_id)
AS (SELECT visit_date, person_id FROM person_visits)
SELECT visit_date AS missing_date
FROM TABLE_CTE
WHERE visit_date BETWEEN '2022-01-01' AND '2022-01-10' AND visit_date NOT IN  (SELECT visit_date
FROM person_visits WHERE (person_id = 1 OR person_id = 2))
GROUP BY missing_date;