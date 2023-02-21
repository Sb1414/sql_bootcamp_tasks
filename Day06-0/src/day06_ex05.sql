COMMENT ON TABLE person_discounts IS 'Table of discounts for pizzeria visitors';
COMMENT ON COLUMN person_discounts.id IS 'Discount identification number';
COMMENT ON COLUMN person_discounts.person_id IS 'Person identification number';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Pizzeria identification number';
COMMENT ON COLUMN person_discounts.discount IS 'Discount in the pizzeria per person as a percentage';