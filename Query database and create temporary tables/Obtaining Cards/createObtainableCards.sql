DROP TABLE IF EXISTS ObtainableCards;

CREATE TEMPORARY TABLE ObtainableCards AS
SELECT CardName, CardType, CardSecTypes, GuardianStar1, GuardianStar2, Attack, Defense, Startability, Droppability, Fusability, StarchipCost
FROM Cards
WHERE Droppability > 0 or Fusability > 0 or StarchipCost <= 1900;