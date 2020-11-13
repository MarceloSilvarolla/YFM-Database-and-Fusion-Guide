-- Test Spike Seadra fusions
--[Aqua] + [Dragon]         = Spike Seadra (1600/1300 Pluto/Mercury)
--                          = Kairyu-shin (1800/1500 Neptune/Mars)
--                              < Flame Swordsman (1800/1600)
DROP TABLE IF EXISTS PredictedFusionsForSpikeSeadra;
DROP TABLE IF EXISTS FusionsForSpikeSeadra;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSpikeSeadra;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSpikeSeadraPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForSpikeSeadra;

-- Create table with predicted fusions resulting in Spike Seadra

CREATE TEMPORARY TABLE PredictedFusionsForSpikeSeadra AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Aqua' AND C2.IsDragon = 1 AND
  C1.Attack < 1600 AND C2.Attack < 1600;


INSERT INTO PredictedFusionsForSpikeSeadra
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForSpikeSeadra;

-- Create table with actual fusions for Spike Seadra

CREATE TEMPORARY TABLE FusionsForSpikeSeadra AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Spike Seadra';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSpikeSeadra AS
SELECT * FROM PredictedFusionsForSpikeSeadra
EXCEPT 
SELECT * FROM FusionsForSpikeSeadra;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSpikeSeadraPlus AS
SELECT IncorrectPredictedFusionsForSpikeSeadra.Material1Name,
IncorrectPredictedFusionsForSpikeSeadra.Material1Type,
IncorrectPredictedFusionsForSpikeSeadra.Material1SecTypes,
IncorrectPredictedFusionsForSpikeSeadra.Material1Attack,
IncorrectPredictedFusionsForSpikeSeadra.Material2Name,
IncorrectPredictedFusionsForSpikeSeadra.Material2Type,
IncorrectPredictedFusionsForSpikeSeadra.Material2SecTypes,
IncorrectPredictedFusionsForSpikeSeadra.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForSpikeSeadra
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForSpikeSeadra.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForSpikeSeadra.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForSpikeSeadra AS
SELECT * FROM FusionsForSpikeSeadra
EXCEPT 
SELECT * FROM PredictedFusionsForSpikeSeadra;