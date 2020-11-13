-- Test Misairuzame fusions
--[Fish] + [Machine]        = Misairuzame (1400/1600)
--                          = Metal Fish (1600/1900)

DROP TABLE IF EXISTS PredictedFusionsForMisairuzame;
DROP TABLE IF EXISTS FusionsForMisairuzame;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMisairuzame;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMisairuzamePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMisairuzame;

-- Create table with predicted fusions resulting in Misairuzame

CREATE TEMPORARY TABLE PredictedFusionsForMisairuzame AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fish' AND C2.CardType = 'Machine' AND
  C1.Attack < 1400 AND C2.Attack < 1400);

INSERT INTO PredictedFusionsForMisairuzame
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMisairuzame;

-- Create table with actual fusions for Misairuzame

CREATE TEMPORARY TABLE FusionsForMisairuzame AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Misairuzame';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMisairuzame AS
SELECT * FROM PredictedFusionsForMisairuzame
EXCEPT 
SELECT * FROM FusionsForMisairuzame;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMisairuzamePlus AS
SELECT IncorrectPredictedFusionsForMisairuzame.Material1Name,
IncorrectPredictedFusionsForMisairuzame.Material1Type,
IncorrectPredictedFusionsForMisairuzame.Material1SecTypes,
IncorrectPredictedFusionsForMisairuzame.Material1Attack,
IncorrectPredictedFusionsForMisairuzame.Material2Name,
IncorrectPredictedFusionsForMisairuzame.Material2Type,
IncorrectPredictedFusionsForMisairuzame.Material2SecTypes,
IncorrectPredictedFusionsForMisairuzame.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMisairuzame
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMisairuzame.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMisairuzame.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMisairuzame AS
SELECT * FROM FusionsForMisairuzame
EXCEPT 
SELECT * FROM PredictedFusionsForMisairuzame;