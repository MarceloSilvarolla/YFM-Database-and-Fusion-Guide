-- Test Queen of Autumn Leaves fusions
--[Female] + [Plant] = Queen of Autumn Leaves (1800/1500)

DROP TABLE IF EXISTS PredictedFusionsForQueenofAutumnLeaves;
DROP TABLE IF EXISTS FusionsForQueenofAutumnLeaves;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForQueenofAutumnLeaves;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForQueenofAutumnLeavesPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForQueenofAutumnLeaves;

-- Create table with predicted fusions resulting in Queen of Autumn Leaves

CREATE TEMPORARY TABLE PredictedFusionsForQueenofAutumnLeaves AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsFemale = 1 AND C2.CardType = 'Plant' AND
  C1.Attack < 1800 AND C2.Attack < 1800);

INSERT INTO PredictedFusionsForQueenofAutumnLeaves
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForQueenofAutumnLeaves;

-- Create table with actual fusions for Queen of Autumn Leaves

CREATE TEMPORARY TABLE FusionsForQueenofAutumnLeaves AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Queen of Autumn Leaves';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForQueenofAutumnLeaves AS
SELECT * FROM PredictedFusionsForQueenofAutumnLeaves
EXCEPT 
SELECT * FROM FusionsForQueenofAutumnLeaves;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForQueenofAutumnLeavesPlus AS
SELECT IncorrectPredictedFusionsForQueenofAutumnLeaves.Material1Name,
IncorrectPredictedFusionsForQueenofAutumnLeaves.Material1Type,
IncorrectPredictedFusionsForQueenofAutumnLeaves.Material1SecTypes,
IncorrectPredictedFusionsForQueenofAutumnLeaves.Material1Attack,
IncorrectPredictedFusionsForQueenofAutumnLeaves.Material2Name,
IncorrectPredictedFusionsForQueenofAutumnLeaves.Material2Type,
IncorrectPredictedFusionsForQueenofAutumnLeaves.Material2SecTypes,
IncorrectPredictedFusionsForQueenofAutumnLeaves.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForQueenofAutumnLeaves
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForQueenofAutumnLeaves.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForQueenofAutumnLeaves.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForQueenofAutumnLeaves AS
SELECT * FROM FusionsForQueenofAutumnLeaves
EXCEPT 
SELECT * FROM PredictedFusionsForQueenofAutumnLeaves;