UPDATE menu
SET price = price - (price / 10)
WHERE pizza_name = 'greek pizza';
