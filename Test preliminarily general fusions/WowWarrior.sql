-- Test Wow Warrior fusions
--[Fish] + [Warrior] = Wow Warrior (1250/900)

DROP TABLE IF EXISTS PredictedFusionsForWowWarrior;
DROP TABLE IF EXISTS FusionsForWowWarrior;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForWowWarrior;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForWowWarriorPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForWowWarrior;

-- Create table with predicted fusions resulting in Wow Warrior

CREATE TEMPORARY TABLE PredictedFusionsForWowWarrior AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fish' AND C2.CardType = 'Warrior' AND
  C1.Attack < 1250 AND C2.Attack < 1250);

INSERT INTO PredictedFusionsForWowWarrior
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForWowWarrior;

-- Create table with actual fusions for Wow Warrior

CREATE TEMPORARY TABLE FusionsForWowWarrior AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Wow Warrior';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForWowWarrior AS
SELECT * FROM PredictedFusionsForWowWarrior
EXCEPT 
SELECT * FROM FusionsForWowWarrior;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForWowWarriorPlus AS
SELECT IncorrectPredictedFusionsForWowWarrior.Material1Name,
IncorrectPredictedFusionsForWowWarrior.Material1Type,
IncorrectPredictedFusionsForWowWarrior.Material1SecTypes,
IncorrectPredictedFusionsForWowWarrior.Material1Attack,
IncorrectPredictedFusionsForWowWarrior.Material2Name,
IncorrectPredictedFusionsForWowWarrior.Material2Type,
IncorrectPredictedFusionsForWowWarrior.Material2SecTypes,
IncorrectPredictedFusionsForWowWarrior.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForWowWarrior
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForWowWarrior.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForWowWarrior.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForWowWarrior AS
SELECT * FROM FusionsForWowWarrior
EXCEPT 
SELECT * FROM PredictedFusionsForWowWarrior;