CREATE VIEW v_symmetric_union AS
WITH R AS (SELECT * FROM person_visits WHERE visit_date = '2022-01-02'),
     S AS (SELECT * FROM person_visits WHERE visit_date = '2022-01-06')

SELECT ((SELECT person_id FROM R) - (SELECT person_id FROM S)) AS person_id UNION
SELECT ((SELECT person_id FROM S) - (SELECT person_id FROM R)) AS person_id
ORDER BY person_id;

-- (R - S)∪(S - R)
-- U - дизъюнкция - логическое сложение

-- неправильно, так как "-" не значит вычитание, а except