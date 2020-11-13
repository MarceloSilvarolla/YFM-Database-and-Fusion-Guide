DROP VIEW IF EXISTS DropRates;
CREATE VIEW DropRates AS
SELECT DuelistName, DuelistPoolType as "Rank", CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM DuelistPoolSamplingRates
NATURAL JOIN DuelistPoolTypes
NATURAL JOIN Cards
NATURAL JOIN Duelists
WHERE DuelistPoolType <> 'Deck' AND Prob > 0;