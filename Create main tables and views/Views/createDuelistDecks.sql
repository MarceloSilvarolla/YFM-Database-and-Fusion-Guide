DROP VIEW IF EXISTS DuelistDecks;
CREATE VIEW DuelistDecks AS
SELECT DuelistName, CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM DuelistPoolSamplingRates
NATURAL JOIN Duelists
NATURAL JOIN DuelistPoolTypes
NATURAL JOIN Cards
WHERE Prob > 0 AND DuelistPoolType = 'Deck';