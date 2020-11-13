-- Test Metal Fish fusions
--[Fish] + [Machine]        = Misairuzame (1400/1600)
--                          = Metal Fish (1600/1900)

DROP TABLE IF EXISTS PredictedFusionsForMetalFish;
DROP TABLE IF EXISTS FusionsForMetalFish;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMetalFish;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMetalFishPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMetalFish;

-- Create table with predicted fusions resulting in Metal Fish

CREATE TEMPORARY TABLE PredictedFusionsForMetalFish AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fish' AND C2.CardType = 'Machine' AND
  C1.Attack < 1600 AND C2.Attack < 1600) AND
  (C1.Attack >= 1400 OR C2.Attack >= 1400);

INSERT INTO PredictedFusionsForMetalFish
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMetalFish;

-- Create table with actual fusions for Metal Fish

CREATE TEMPORARY TABLE FusionsForMetalFish AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Metal Fish';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMetalFish AS
SELECT * FROM PredictedFusionsForMetalFish
EXCEPT 
SELECT * FROM FusionsForMetalFish;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMetalFishPlus AS
SELECT IncorrectPredictedFusionsForMetalFish.Material1Name,
IncorrectPredictedFusionsForMetalFish.Material1Type,
IncorrectPredictedFusionsForMetalFish.Material1SecTypes,
IncorrectPredictedFusionsForMetalFish.Material1Attack,
IncorrectPredictedFusionsForMetalFish.Material2Name,
IncorrectPredictedFusionsForMetalFish.Material2Type,
IncorrectPredictedFusionsForMetalFish.Material2SecTypes,
IncorrectPredictedFusionsForMetalFish.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMetalFish
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMetalFish.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMetalFish.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMetalFish AS
SELECT * FROM FusionsForMetalFish
EXCEPT 
SELECT * FROM PredictedFusionsForMetalFish;