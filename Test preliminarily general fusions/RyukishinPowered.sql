-- Test Ryu-kishin Powered fusions
--[MercurySpellcaster] + Ryu-kishin 
--                          = Ryu-kishin Powered (1600/1200)

DROP TABLE IF EXISTS PredictedFusionsForRyukishinPowered;
DROP TABLE IF EXISTS FusionsForRyukishinPowered;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForRyukishinPowered;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForRyukishinPoweredPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForRyukishinPowered;

-- Create table with predicted fusions resulting in Ryu-kishin Powered

CREATE TEMPORARY TABLE PredictedFusionsForRyukishinPowered AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsMercurySpellcaster = 1 AND C2.CardName = 'Ryu-kishin' AND
  C1.Attack < 1600 AND C2.Attack < 1600;

INSERT INTO PredictedFusionsForRyukishinPowered
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForRyukishinPowered;

-- Create table with actual fusions for Ryu-kishin Powered

CREATE TEMPORARY TABLE FusionsForRyukishinPowered AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Ryu-kishin Powered';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForRyukishinPowered AS
SELECT * FROM PredictedFusionsForRyukishinPowered
EXCEPT 
SELECT * FROM FusionsForRyukishinPowered;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForRyukishinPoweredPlus AS
SELECT IncorrectPredictedFusionsForRyukishinPowered.Material1Name,
IncorrectPredictedFusionsForRyukishinPowered.Material1Type,
IncorrectPredictedFusionsForRyukishinPowered.Material1SecTypes,
IncorrectPredictedFusionsForRyukishinPowered.Material1Attack,
IncorrectPredictedFusionsForRyukishinPowered.Material2Name,
IncorrectPredictedFusionsForRyukishinPowered.Material2Type,
IncorrectPredictedFusionsForRyukishinPowered.Material2SecTypes,
IncorrectPredictedFusionsForRyukishinPowered.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForRyukishinPowered
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForRyukishinPowered.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForRyukishinPowered.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForRyukishinPowered AS
SELECT * FROM FusionsForRyukishinPowered
EXCEPT 
SELECT * FROM PredictedFusionsForRyukishinPowered;