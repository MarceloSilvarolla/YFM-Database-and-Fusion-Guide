-- Test Cockroach Knight fusions
--[Insect] + [Warrior]      = Cockroach Knight (800/900)

DROP TABLE IF EXISTS PredictedFusionsForCockroachKnight;
DROP TABLE IF EXISTS FusionsForCockroachKnight;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCockroachKnight;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCockroachKnightPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForCockroachKnight;

-- Create table with predicted fusions resulting in Cockroach Knight

CREATE TEMPORARY TABLE PredictedFusionsForCockroachKnight AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Insect' AND C2.CardType = 'Warrior' AND
  C1.Attack < 800 AND C2.Attack < 800);

INSERT INTO PredictedFusionsForCockroachKnight
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForCockroachKnight;

-- Create table with actual fusions for Cockroach Knight

CREATE TEMPORARY TABLE FusionsForCockroachKnight AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Cockroach Knight';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCockroachKnight AS
SELECT * FROM PredictedFusionsForCockroachKnight
EXCEPT 
SELECT * FROM FusionsForCockroachKnight;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCockroachKnightPlus AS
SELECT IncorrectPredictedFusionsForCockroachKnight.Material1Name,
IncorrectPredictedFusionsForCockroachKnight.Material1Type,
IncorrectPredictedFusionsForCockroachKnight.Material1SecTypes,
IncorrectPredictedFusionsForCockroachKnight.Material1Attack,
IncorrectPredictedFusionsForCockroachKnight.Material2Name,
IncorrectPredictedFusionsForCockroachKnight.Material2Type,
IncorrectPredictedFusionsForCockroachKnight.Material2SecTypes,
IncorrectPredictedFusionsForCockroachKnight.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForCockroachKnight
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForCockroachKnight.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForCockroachKnight.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForCockroachKnight AS
SELECT * FROM FusionsForCockroachKnight
EXCEPT 
SELECT * FROM PredictedFusionsForCockroachKnight;