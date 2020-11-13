-- Test Snakeyashi fusions
--[Reptile] + [Plant] = Snakeyashi (1000/1200)

DROP TABLE IF EXISTS PredictedFusionsForSnakeyashi;
DROP TABLE IF EXISTS FusionsForSnakeyashi;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSnakeyashi;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSnakeyashiPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForSnakeyashi;

-- Create table with predicted fusions resulting in Snakeyashi

CREATE TEMPORARY TABLE PredictedFusionsForSnakeyashi AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Reptile' AND C2.CardType = 'Plant' AND
  C1.Attack < 1000 AND C2.Attack < 1000);

INSERT INTO PredictedFusionsForSnakeyashi
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForSnakeyashi;

-- Create table with actual fusions for Snakeyashi

CREATE TEMPORARY TABLE FusionsForSnakeyashi AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Snakeyashi';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSnakeyashi AS
SELECT * FROM PredictedFusionsForSnakeyashi
EXCEPT 
SELECT * FROM FusionsForSnakeyashi;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSnakeyashiPlus AS
SELECT IncorrectPredictedFusionsForSnakeyashi.Material1Name,
IncorrectPredictedFusionsForSnakeyashi.Material1Type,
IncorrectPredictedFusionsForSnakeyashi.Material1SecTypes,
IncorrectPredictedFusionsForSnakeyashi.Material1Attack,
IncorrectPredictedFusionsForSnakeyashi.Material2Name,
IncorrectPredictedFusionsForSnakeyashi.Material2Type,
IncorrectPredictedFusionsForSnakeyashi.Material2SecTypes,
IncorrectPredictedFusionsForSnakeyashi.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForSnakeyashi
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForSnakeyashi.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForSnakeyashi.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForSnakeyashi AS
SELECT * FROM FusionsForSnakeyashi
EXCEPT 
SELECT * FROM PredictedFusionsForSnakeyashi;