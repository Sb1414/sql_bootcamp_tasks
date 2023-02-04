create table routes
(
    city_1 varchar not null,
    city_2 varchar not null,
    cost   integer not null
);

INSERT INTO public.routes (city_1, city_2, cost) VALUES ('a', 'b', 10);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('a', 'c', 15);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('a', 'd', 20);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('b', 'a', 10);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('b', 'c', 35);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('b', 'd', 25);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('c', 'a', 15);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('c', 'b', 35);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('c', 'd', 30);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('d', 'a', 20);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('d', 'b', 25);
INSERT INTO public.routes (city_1, city_2, cost) VALUES ('d', 'c', 30);

-- SELECT city_1 AS begin_tour, city_1, city_2, cost, cost
--     AS sum_cost, 1 AS iter FROM routes WHERE city_1 = 'a'

WITH first_point AS (SELECT city_1 AS c11, city_2 AS c12, cost AS cost1 FROM routes),
     second_point AS (SELECT city_1 AS c21, city_2 AS c22, cost AS cost2 FROM routes),
     third_point AS (SELECT city_1 AS c31, city_2 AS c32, cost AS cost3 FROM routes),
     f_and_s AS (SELECT c11, (SELECT DISTINCT c21 FROM second_point
                WHERE c12 = c21) AS c21_
                FROM first_point
                JOIN second_point on c21 = first_point.c12),
     costes AS (SELECT city_1 AS city_c_1, city_2 AS city_c_2, cost AS cost_full FROM routes),
     f_s_cost AS (SELECT DISTINCT c11, c21_, (SELECT DISTINCT cost_full AS cost_f_s FROM costes
                WHERE city_c_1 = c11 AND city_c_2 = c21_)
                FROM f_and_s)

-- SELECT c11, c21_, (SELECT DISTINCT c31 FROM third_point WHERE NOT(c31 = c21_)
--                                                           AND NOT (c11 = c31)) , cost_f_s
-- FROM f_s_cost;
SELECT DISTINCT c11, c21_, c31, (SELECT cost_full FROM costes WHERE city_c_1 = c11 AND city_c_2 = c21_) +
                (SELECT cost_full FROM costes WHERE city_c_1 = c21_ AND city_c_2 = c31)

FROM f_s_cost
JOIN third_point on NOT(third_point.c31 = c11) AND NOT(c21_ = third_point.c31)
ORDER BY c11, c21_, c31
;


-- SELECT generate_series(c11, c21_,
--     (SELECT DISTINCT c31 FROM third_point WHERE NOT(c31 = c21_) AND NOT (c11 = c31)), '2')
-- FROM f_s_cost;

-- c11      c12
-- c21      c22
-- c31      c32
-- c41      c42