alter table person_discounts add constraint ch_nn_person_id check (person_id IS NOT NULL);
alter table person_discounts add constraint ch_nn_pizzeria_id check (pizzeria_id IS NOT NULL);
alter table person_discounts add constraint ch_nn_discount check (discount IS NOT NULL);
alter table person_discounts alter column discount SET DEFAULT 0;
alter table person_discounts add constraint ch_range_discount check (discount <= 100 AND discount >= 0);