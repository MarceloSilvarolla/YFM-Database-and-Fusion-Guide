DROP TABLE IF EXISTS DesiredCards;

CREATE TEMPORARY TABLE DesiredCards AS
SELECT CardName
FROM Cards
WHERE 
CardType = 'Winged Beast';
--IsPyro = 1;