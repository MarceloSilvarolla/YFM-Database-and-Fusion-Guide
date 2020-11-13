DROP VIEW IF EXISTS StarterRates;
CREATE VIEW StarterRates AS
SELECT StarterPools.StarterPoolID, StarterPools.StarterPoolName, StarterPools.SampleSize, CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM StarterPoolSamplingRates
NATURAL JOIN StarterPools
JOIN Cards
ON   Cards.CardID = StarterPoolSamplingRates.CardID
WHERE Prob > 0;