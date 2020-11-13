-- Test Turtle Tiger fusions
--[Beast] + [Turtle]        = Turtle Tiger (1000/1500)

DROP TABLE IF EXISTS PredictedFusionsForTurtleTiger;
DROP TABLE IF EXISTS FusionsForTurtleTiger;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTurtleTiger;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTurtleTigerPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForTurtleTiger;

-- Create table with predicted fusions resulting in Turtle Tiger

CREATE TEMPORARY TABLE PredictedFusionsForTurtleTiger AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Beast' AND C2.IsTurtle = 1 AND
  C1.Attack < 1000 AND C2.Attack < 1000;

INSERT INTO PredictedFusionsForTurtleTiger
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForTurtleTiger;

-- Create table with actual fusions for Turtle Tiger

CREATE TEMPORARY TABLE FusionsForTurtleTiger AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Turtle Tiger';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTurtleTiger AS
SELECT * FROM PredictedFusionsForTurtleTiger
EXCEPT 
SELECT * FROM FusionsForTurtleTiger;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTurtleTigerPlus AS
SELECT IncorrectPredictedFusionsForTurtleTiger.Material1Name,
IncorrectPredictedFusionsForTurtleTiger.Material1Type,
IncorrectPredictedFusionsForTurtleTiger.Material1SecTypes,
IncorrectPredictedFusionsForTurtleTiger.Material1Attack,
IncorrectPredictedFusionsForTurtleTiger.Material2Name,
IncorrectPredictedFusionsForTurtleTiger.Material2Type,
IncorrectPredictedFusionsForTurtleTiger.Material2SecTypes,
IncorrectPredictedFusionsForTurtleTiger.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForTurtleTiger
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForTurtleTiger.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForTurtleTiger.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForTurtleTiger AS
SELECT * FROM FusionsForTurtleTiger
EXCEPT 
SELECT * FROM PredictedFusionsForTurtleTiger;