CREATE VIEW v_generated_dates AS
SELECT missing_date::date FROM
       generate_series('2022-01-01', '2022-01-31', interval '1 day') AS missing_date
EXCEPT
SELECT visit_date AS missing_date FROM person_visits
ORDER BY missing_date;
