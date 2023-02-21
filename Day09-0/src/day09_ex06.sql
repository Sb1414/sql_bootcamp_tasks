CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date(in pperson varchar default 'Dmitriy',
                                            in pprice bigint default 500, in pdate date default '2022-01-08') RETURNS
    TABLE(name varchar) AS $$
    SELECT DISTINCT pizzeria.name AS pizzeria_name FROM person
    JOIN person_order on person.id = person_order.person_id
    JOIN menu on menu.id = person_order.menu_id
    JOIN pizzeria on menu.pizzeria_id = pizzeria.id
    JOIN person_visits on person.id = person_visits.person_id
    WHERE person.name = pperson AND price < pprice AND order_date = pdate AND visit_date = pdate;
$$ LANGUAGE SQL;


select *
from fnc_person_visits_and_eats_on_date(pprice := 800);

select *
from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
