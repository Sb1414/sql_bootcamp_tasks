WITH table_ AS (SELECT address, round(max(age::numeric) - (min(age::numeric) / max(age::numeric)), 2) AS formula,
                       round(avg(age), 2) AS average
                FROM person
                GROUP BY address)
SELECT * , CASE 
                WHEN formula > average THEN 'true'
                ELSE 'false'
            END comparison
FROM table_
ORDER BY address;