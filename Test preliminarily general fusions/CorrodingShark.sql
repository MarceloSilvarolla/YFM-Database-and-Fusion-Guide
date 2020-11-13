-- Test Corroding Shark fusions
--[Fish] + [Zombie] = Corroding Shark (1100/700)

DROP TABLE IF EXISTS PredictedFusionsForCorrodingShark;
DROP TABLE IF EXISTS FusionsForCorrodingShark;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCorrodingShark;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCorrodingSharkPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForCorrodingShark;

-- Create table with predicted fusions resulting in Corroding Shark

CREATE TEMPORARY TABLE PredictedFusionsForCorrodingShark AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fish' AND C2.CardType = 'Zombie' AND
  C1.Attack < 1100 AND C2.Attack < 1100);

INSERT INTO PredictedFusionsForCorrodingShark
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForCorrodingShark;

-- Create table with actual fusions for Corroding Shark

CREATE TEMPORARY TABLE FusionsForCorrodingShark AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Corroding Shark';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCorrodingShark AS
SELECT * FROM PredictedFusionsForCorrodingShark
EXCEPT 
SELECT * FROM FusionsForCorrodingShark;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCorrodingSharkPlus AS
SELECT IncorrectPredictedFusionsForCorrodingShark.Material1Name,
IncorrectPredictedFusionsForCorrodingShark.Material1Type,
IncorrectPredictedFusionsForCorrodingShark.Material1SecTypes,
IncorrectPredictedFusionsForCorrodingShark.Material1Attack,
IncorrectPredictedFusionsForCorrodingShark.Material2Name,
IncorrectPredictedFusionsForCorrodingShark.Material2Type,
IncorrectPredictedFusionsForCorrodingShark.Material2SecTypes,
IncorrectPredictedFusionsForCorrodingShark.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForCorrodingShark
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForCorrodingShark.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForCorrodingShark.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForCorrodingShark AS
SELECT * FROM FusionsForCorrodingShark
EXCEPT 
SELECT * FROM PredictedFusionsForCorrodingShark;