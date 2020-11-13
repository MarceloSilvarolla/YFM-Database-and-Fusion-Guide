-- Test Crimson Sunbird fusions
--[Pyro] + [Winged Beast]   = Mavelus (1300/900)
--                          = Crimson Sunbird (2300/1800)
--                              < Flame Swordsman (1800/1600),
--                                Vermillion Sparrow (1900/1500),
--                                Queen of Autumn Leaves (1800/1500),
--                                Harpie's Pet Dragon (2000/2500),
--                                Mystical Sand (2100/1700)

DROP TABLE IF EXISTS PredictedFusionsForCrimsonSunbird;
DROP TABLE IF EXISTS FusionsForCrimsonSunbird;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCrimsonSunbird;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCrimsonSunbirdPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForCrimsonSunbird;

-- Create table with predicted fusions resulting in Crimson Sunbird

CREATE TEMPORARY TABLE PredictedFusionsForCrimsonSunbird AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.CardType = 'Winged Beast' AND
  C1.Attack < 2300 AND C2.Attack < 2300) AND
  (C1.Attack >= 1300 OR C2.Attack >= 1300);

INSERT INTO PredictedFusionsForCrimsonSunbird
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForCrimsonSunbird;

-- Create table with actual fusions for Crimson Sunbird

CREATE TEMPORARY TABLE FusionsForCrimsonSunbird AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Crimson Sunbird';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCrimsonSunbird AS
SELECT * FROM PredictedFusionsForCrimsonSunbird
EXCEPT 
SELECT * FROM FusionsForCrimsonSunbird;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCrimsonSunbirdPlus AS
SELECT IncorrectPredictedFusionsForCrimsonSunbird.Material1Name,
IncorrectPredictedFusionsForCrimsonSunbird.Material1Type,
IncorrectPredictedFusionsForCrimsonSunbird.Material1SecTypes,
IncorrectPredictedFusionsForCrimsonSunbird.Material1Attack,
IncorrectPredictedFusionsForCrimsonSunbird.Material2Name,
IncorrectPredictedFusionsForCrimsonSunbird.Material2Type,
IncorrectPredictedFusionsForCrimsonSunbird.Material2SecTypes,
IncorrectPredictedFusionsForCrimsonSunbird.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForCrimsonSunbird
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForCrimsonSunbird.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForCrimsonSunbird.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForCrimsonSunbird AS
SELECT * FROM FusionsForCrimsonSunbird
EXCEPT 
SELECT * FROM PredictedFusionsForCrimsonSunbird;