-- Test Wood Remains fusions
--[Plant] + [Zombie]        = Wood Remains (1000/900)
--                          = Pumpking the King of Ghosts (1800/2000)

DROP TABLE IF EXISTS PredictedFusionsForWoodRemains;
DROP TABLE IF EXISTS FusionsForWoodRemains;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForWoodRemains;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForWoodRemainsPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForWoodRemains;

-- Create table with predicted fusions resulting in Wood Remains

CREATE TEMPORARY TABLE PredictedFusionsForWoodRemains AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Plant' AND C2.CardType = 'Zombie' AND
  C1.Attack < 1000 AND C2.Attack < 1000);

INSERT INTO PredictedFusionsForWoodRemains
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForWoodRemains;

-- Create table with actual fusions for Wood Remains

CREATE TEMPORARY TABLE FusionsForWoodRemains AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Wood Remains';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForWoodRemains AS
SELECT * FROM PredictedFusionsForWoodRemains
EXCEPT 
SELECT * FROM FusionsForWoodRemains;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForWoodRemainsPlus AS
SELECT IncorrectPredictedFusionsForWoodRemains.Material1Name,
IncorrectPredictedFusionsForWoodRemains.Material1Type,
IncorrectPredictedFusionsForWoodRemains.Material1SecTypes,
IncorrectPredictedFusionsForWoodRemains.Material1Attack,
IncorrectPredictedFusionsForWoodRemains.Material2Name,
IncorrectPredictedFusionsForWoodRemains.Material2Type,
IncorrectPredictedFusionsForWoodRemains.Material2SecTypes,
IncorrectPredictedFusionsForWoodRemains.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForWoodRemains
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForWoodRemains.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForWoodRemains.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForWoodRemains AS
SELECT * FROM FusionsForWoodRemains
EXCEPT 
SELECT * FROM PredictedFusionsForWoodRemains;