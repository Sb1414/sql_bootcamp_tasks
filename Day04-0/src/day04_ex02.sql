CREATE VIEW v_generated_dates AS
SELECT v_generated_dates::date
from generate_series('2022-01-01', '2022-01-31', interval '1 day') AS v_generated_dates;