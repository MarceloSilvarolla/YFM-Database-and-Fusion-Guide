DROP TABLE IF EXISTS SimpleCards;

CREATE TEMPORARY TABLE SimpleCards AS
SELECT CardName, CardType, CardSecTypes, GuardianStar1, GuardianStar2, Attack, Defense
FROM Cards;