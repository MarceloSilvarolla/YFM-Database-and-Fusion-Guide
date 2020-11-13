-- Test Boulder Tortoise fusions
--[Rock] + [Turtle] = Boulder Tortoise (1450/2200)

DROP TABLE IF EXISTS PredictedFusionsForBoulderTortoise;
DROP TABLE IF EXISTS FusionsForBoulderTortoise;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBoulderTortoise;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBoulderTortoisePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForBoulderTortoise;

-- Create table with predicted fusions resulting in Boulder Tortoise

CREATE TEMPORARY TABLE PredictedFusionsForBoulderTortoise AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Rock' AND C2.IsTurtle = 1 AND
  C1.Attack < 1450 AND C2.Attack < 1450);

INSERT INTO PredictedFusionsForBoulderTortoise
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForBoulderTortoise;

-- Create table with actual fusions for Boulder Tortoise

CREATE TEMPORARY TABLE FusionsForBoulderTortoise AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Boulder Tortoise';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBoulderTortoise AS
SELECT * FROM PredictedFusionsForBoulderTortoise
EXCEPT 
SELECT * FROM FusionsForBoulderTortoise;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBoulderTortoisePlus AS
SELECT IncorrectPredictedFusionsForBoulderTortoise.Material1Name,
IncorrectPredictedFusionsForBoulderTortoise.Material1Type,
IncorrectPredictedFusionsForBoulderTortoise.Material1SecTypes,
IncorrectPredictedFusionsForBoulderTortoise.Material1Attack,
IncorrectPredictedFusionsForBoulderTortoise.Material2Name,
IncorrectPredictedFusionsForBoulderTortoise.Material2Type,
IncorrectPredictedFusionsForBoulderTortoise.Material2SecTypes,
IncorrectPredictedFusionsForBoulderTortoise.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForBoulderTortoise
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForBoulderTortoise.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForBoulderTortoise.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForBoulderTortoise AS
SELECT * FROM FusionsForBoulderTortoise
EXCEPT 
SELECT * FROM PredictedFusionsForBoulderTortoise;