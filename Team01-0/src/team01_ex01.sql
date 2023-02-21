-- insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
-- insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');

WITH cur_bal AS (SELECT balance.user_id, balance.money, balance.updated, currency.name AS currency_name,
                    currency.rate_to_usd AS cur_rate, currency.updated AS cur_updated
                    FROM balance
                    JOIN currency ON balance.currency_id = currency.id),
     min_ AS (SELECT cur_bal.user_id AS id, currency_name, money, updated, min(updated - cur_updated) AS diff
                    FROM cur_bal
                    WHERE updated >= cur_updated
                    GROUP BY id, currency_name, money, updated),
     max_ AS (SELECT cur_bal.user_id AS id, currency_name,  money, updated, max(updated - cur_updated) AS diff
                    FROM cur_bal
                    WHERE updated <= cur_updated
                    GROUP BY id, currency_name,  money, updated),
     all_ AS (SELECT max_.id, max_.currency_name, max_.money, max_.updated, COALESCE(min_.diff, max_.diff) new_diff
                    FROM min_
                    FULL JOIN max_ ON min_.id = max_.id AND min_.currency_name = max_.currency_name
                            AND min_.money = max_.money AND min_.updated = max_.updated)

SELECT COALESCE(u.name, 'not defined') AS name, COALESCE(u.lastname, 'not defined') AS lastname,
       currency_name, all_.money * cu.rate_to_usd AS currency_in_usd
FROM all_
         LEFT JOIN "user" u ON all_.id = u.id
         LEFT JOIN currency cu ON all_.new_diff = (all_.updated - cu.updated) AND all_.currency_name = cu.name
ORDER BY name DESC, lastname ASC, currency_name ASC;
