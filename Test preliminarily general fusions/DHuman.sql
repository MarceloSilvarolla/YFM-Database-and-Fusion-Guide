-- Test D. Human fusions
--[Dragon] + [Warrior]      = Dragon Statue (1100/900)
--                          = Dragoness the Wicked Knight (1200/900)
--                              < Flame Swordsman (1800/1600)
--                          = D. Human (1300/1100)
--                          = Sword Arm of Dragon (1750/2030)
--                              < Skelgon (1700/1900),
--                                Flame Swordsman (1800/1600),
--                                Dark Elf (2000/800)
DROP TABLE IF EXISTS PredictedFusionsForDHuman;
DROP TABLE IF EXISTS FusionsForDHuman;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDHuman;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDHumanPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDHuman;

-- Create table with predicted fusions resulting in D. Human

CREATE TEMPORARY TABLE PredictedFusionsForDHuman AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1300 AND C2.Attack < 1300 AND
  (C1.Attack >= 1200 OR C2.Attack >= 1200);

INSERT INTO PredictedFusionsForDHuman
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDHuman;

-- Create table with actual fusions for D. Human

CREATE TEMPORARY TABLE FusionsForDHuman AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'D. Human';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDHuman AS
SELECT * FROM PredictedFusionsForDHuman
EXCEPT 
SELECT * FROM FusionsForDHuman;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDHumanPlus AS
SELECT IncorrectPredictedFusionsForDHuman.Material1Name,
IncorrectPredictedFusionsForDHuman.Material1Type,
IncorrectPredictedFusionsForDHuman.Material1SecTypes,
IncorrectPredictedFusionsForDHuman.Material1Attack,
IncorrectPredictedFusionsForDHuman.Material2Name,
IncorrectPredictedFusionsForDHuman.Material2Type,
IncorrectPredictedFusionsForDHuman.Material2SecTypes,
IncorrectPredictedFusionsForDHuman.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDHuman
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDHuman.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDHuman.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDHuman AS
SELECT * FROM FusionsForDHuman
EXCEPT 
SELECT * FROM PredictedFusionsForDHuman;








