DROP VIEW IF EXISTS DropRates;
CREATE VIEW DropRates AS
SELECT DuelistName, DuelistPoolType as "Rank", CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM DuelistPoolSamplingRates
NATURAL JOIN DuelistPoolTypes
NATURAL JOIN Cards
NATURAL JOIN Duelists
WHERE DuelistPoolType <> 'Deck' AND Prob > 0; 
 
DROP VIEW IF EXISTS DuelistDecks;
CREATE VIEW DuelistDecks AS
SELECT DuelistName, CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM DuelistPoolSamplingRates
NATURAL JOIN Duelists
NATURAL JOIN DuelistPoolTypes
NATURAL JOIN Cards
WHERE Prob > 0 AND DuelistPoolType = 'Deck'; 
 
DROP VIEW IF EXISTS EquippingPlus;

CREATE VIEW EquippingPlus AS
SELECT C1.CardName AS EquipName, C2.CardName AS EquippedName, 
 	   C2.GuardianStar1 AS EquippedGuardianStar1, C2.GuardianStar2 AS EquippedGuardianStar2,
 	   C2.CardType AS EquippedType, C2.Attack AS EquippedAttack, C2.Defense AS EquippedDefense
FROM Equipping AS E
JOIN Cards AS C1
ON   EquipID = C1.CardID
JOIN Cards AS C2
ON   EquippedID = C2.CardID;
 
 
DROP VIEW IF EXISTS FusionsPlus;
CREATE VIEW FusionsPlus AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
       Result.CardName AS ResultName, Result.CardType AS ResultType, Result.CardSecTypes AS ResultSecTypes, Result.Attack AS ResultAttack
FROM Fusions, Cards AS C1, Cards AS C2, Cards AS Result
WHERE Material1 = C1.CardID AND Material2 = C2.CardID AND Result = Result.CardID; 
 
DROP VIEW IF EXISTS StarterRates;
CREATE VIEW StarterRates AS
SELECT StarterPools.StarterPoolID, StarterPools.StarterPoolName, StarterPools.SampleSize, CardName, GuardianStar1, GuardianStar2, CardType, Attack, Defense, Prob
FROM StarterPoolSamplingRates
NATURAL JOIN StarterPools
JOIN Cards
ON   Cards.CardID = StarterPoolSamplingRates.CardID
WHERE Prob > 0; 
 
