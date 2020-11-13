-- Test Soul Hunter fusions
--[Reptile] + Clown Zombie = Soul Hunter (2200/1800)
--[Reptile] + Crass Clown = Soul Hunter (2200/1800)

DROP TABLE IF EXISTS PredictedFusionsForSoulHunter;
DROP TABLE IF EXISTS FusionsForSoulHunter;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSoulHunter;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSoulHunterPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForSoulHunter;

-- Create table with predicted fusions resulting in Soul Hunter

CREATE TEMPORARY TABLE PredictedFusionsForSoulHunter AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Reptile' AND 
   C2.CardName IN ('Clown Zombie', 'Crass Clown') AND
   C1.Attack < 2200 AND C2.Attack < 2200);

INSERT INTO PredictedFusionsForSoulHunter
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForSoulHunter;

-- Create table with actual fusions for Soul Hunter

CREATE TEMPORARY TABLE FusionsForSoulHunter AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Soul Hunter';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSoulHunter AS
SELECT * FROM PredictedFusionsForSoulHunter
EXCEPT 
SELECT * FROM FusionsForSoulHunter;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSoulHunterPlus AS
SELECT IncorrectPredictedFusionsForSoulHunter.Material1Name,
IncorrectPredictedFusionsForSoulHunter.Material1Type,
IncorrectPredictedFusionsForSoulHunter.Material1SecTypes,
IncorrectPredictedFusionsForSoulHunter.Material1Attack,
IncorrectPredictedFusionsForSoulHunter.Material2Name,
IncorrectPredictedFusionsForSoulHunter.Material2Type,
IncorrectPredictedFusionsForSoulHunter.Material2SecTypes,
IncorrectPredictedFusionsForSoulHunter.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForSoulHunter
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForSoulHunter.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForSoulHunter.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForSoulHunter AS
SELECT * FROM FusionsForSoulHunter
EXCEPT 
SELECT * FROM PredictedFusionsForSoulHunter;