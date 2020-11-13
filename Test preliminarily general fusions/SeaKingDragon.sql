-- Test Sea King Dragon fusions
--[Turtle] + [Dragon]       = Sea King Dragon (2000/1700 Neptune/Mercury)
--                              < Spike Seadra (1600/1300),
--                                Kairyu-shin (1800/1500)

DROP TABLE IF EXISTS PredictedFusionsForSeaKingDragon;
DROP TABLE IF EXISTS FusionsForSeaKingDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSeaKingDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSeaKingDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForSeaKingDragon;

-- Create table with predicted fusions resulting in Sea King Dragon

CREATE TEMPORARY TABLE PredictedFusionsForSeaKingDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsTurtle = 1 AND C2.IsDragon = 1 AND
  C1.Attack < 2000 AND C2.Attack < 2000;

INSERT INTO PredictedFusionsForSeaKingDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForSeaKingDragon;

-- Create table with actual fusions for Sea King Dragon

CREATE TEMPORARY TABLE FusionsForSeaKingDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Sea King Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSeaKingDragon AS
SELECT * FROM PredictedFusionsForSeaKingDragon
EXCEPT 
SELECT * FROM FusionsForSeaKingDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSeaKingDragonPlus AS
SELECT IncorrectPredictedFusionsForSeaKingDragon.Material1Name,
IncorrectPredictedFusionsForSeaKingDragon.Material1Type,
IncorrectPredictedFusionsForSeaKingDragon.Material1SecTypes,
IncorrectPredictedFusionsForSeaKingDragon.Material1Attack,
IncorrectPredictedFusionsForSeaKingDragon.Material2Name,
IncorrectPredictedFusionsForSeaKingDragon.Material2Type,
IncorrectPredictedFusionsForSeaKingDragon.Material2SecTypes,
IncorrectPredictedFusionsForSeaKingDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForSeaKingDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForSeaKingDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForSeaKingDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForSeaKingDragon AS
SELECT * FROM FusionsForSeaKingDragon
EXCEPT 
SELECT * FROM PredictedFusionsForSeaKingDragon;