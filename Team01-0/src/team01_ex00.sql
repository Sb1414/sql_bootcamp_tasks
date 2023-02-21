WITH cte1 AS (SELECT COALESCE(us.name, 'not defined') AS name, COALESCE(us.lastname, 'not defined') AS lastname,
                    balance.type AS type, sum(balance.money) AS volume, balance.currency_id
             FROM "user" AS us
                      FULL JOIN balance ON us.id = balance.user_id
             GROUP BY balance.type, COALESCE(us.lastname, 'not defined'), COALESCE(us.name, 'not defined'), currency_id),
     t_r_u AS (SELECT currency.id, name, rate_to_usd, lastdate
             FROM (SELECT id, MAX(updated) AS lastdate FROM currency
                   GROUP BY id) t
                      LEFT JOIN currency ON t.lastdate = currency.updated AND t.id = currency.id)

SELECT cte1.name, lastname, type, volume, COALESCE(t_r_u.name, 'not defined') AS currency_name,
       COALESCE(rate_to_usd, 1) AS last_rate_to_usd, volume * COALESCE(rate_to_usd, 1) AS total_volume_in_usd
FROM cte1
FULL JOIN t_r_u ON t_r_u.id = cte1.currency_id
ORDER BY name DESC, lastname ASC , type ASC;