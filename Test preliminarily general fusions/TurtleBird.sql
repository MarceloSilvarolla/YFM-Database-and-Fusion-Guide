-- Test Turtle Bird fusions
--[Turtle] + [Winged Beast] = Turtle Bird (1900/1700)

DROP TABLE IF EXISTS PredictedFusionsForTurtleBird;
DROP TABLE IF EXISTS FusionsForTurtleBird;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTurtleBird;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTurtleBirdPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForTurtleBird;

-- Create table with predicted fusions resulting in Turtle Bird

CREATE TEMPORARY TABLE PredictedFusionsForTurtleBird AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsTurtle = 1 AND C2.CardType = 'Winged Beast' AND
  C1.Attack < 1900 AND C2.Attack < 1900);

INSERT INTO PredictedFusionsForTurtleBird
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForTurtleBird;

-- Create table with actual fusions for Turtle Bird

CREATE TEMPORARY TABLE FusionsForTurtleBird AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Turtle Bird';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTurtleBird AS
SELECT * FROM PredictedFusionsForTurtleBird
EXCEPT 
SELECT * FROM FusionsForTurtleBird;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTurtleBirdPlus AS
SELECT IncorrectPredictedFusionsForTurtleBird.Material1Name,
IncorrectPredictedFusionsForTurtleBird.Material1Type,
IncorrectPredictedFusionsForTurtleBird.Material1SecTypes,
IncorrectPredictedFusionsForTurtleBird.Material1Attack,
IncorrectPredictedFusionsForTurtleBird.Material2Name,
IncorrectPredictedFusionsForTurtleBird.Material2Type,
IncorrectPredictedFusionsForTurtleBird.Material2SecTypes,
IncorrectPredictedFusionsForTurtleBird.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForTurtleBird
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForTurtleBird.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForTurtleBird.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForTurtleBird AS
SELECT * FROM FusionsForTurtleBird
EXCEPT 
SELECT * FROM PredictedFusionsForTurtleBird;