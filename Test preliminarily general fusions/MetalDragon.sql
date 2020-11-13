-- Test Metal Dragon fusions
--[Dragon] + [Machine]      = Metal Dragon (1850/1700)
--                              < Cyber Saurus (1800/1400),
--                                Cyber Soldier (1500/1700),
--                                Flame Swordsman (1800/1600)

DROP TABLE IF EXISTS PredictedFusionsForMetalDragon;
DROP TABLE IF EXISTS FusionsForMetalDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMetalDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMetalDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMetalDragon;

-- Create table with predicted fusions resulting in Metal Dragon

CREATE TEMPORARY TABLE PredictedFusionsForMetalDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsDragon = 1 AND C2.CardType = 'Machine' AND
  C1.Attack < 1850 AND C2.Attack < 1850;

INSERT INTO PredictedFusionsForMetalDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMetalDragon;

-- Create table with actual fusions for Metal Dragon

CREATE TEMPORARY TABLE FusionsForMetalDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Metal Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMetalDragon AS
SELECT * FROM PredictedFusionsForMetalDragon
EXCEPT 
SELECT * FROM FusionsForMetalDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMetalDragonPlus AS
SELECT IncorrectPredictedFusionsForMetalDragon.Material1Name,
IncorrectPredictedFusionsForMetalDragon.Material1Type,
IncorrectPredictedFusionsForMetalDragon.Material1SecTypes,
IncorrectPredictedFusionsForMetalDragon.Material1Attack,
IncorrectPredictedFusionsForMetalDragon.Material2Name,
IncorrectPredictedFusionsForMetalDragon.Material2Type,
IncorrectPredictedFusionsForMetalDragon.Material2SecTypes,
IncorrectPredictedFusionsForMetalDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMetalDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMetalDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMetalDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMetalDragon AS
SELECT * FROM FusionsForMetalDragon
EXCEPT 
SELECT * FROM PredictedFusionsForMetalDragon;