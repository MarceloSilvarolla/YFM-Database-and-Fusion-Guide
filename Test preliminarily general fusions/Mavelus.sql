-- Test Mavelus fusions
--[Pyro] + [Winged Beast]   = Mavelus (1300/900)
--                          = Crimson Sunbird (2300/1800)
--                              < Flame Swordsman (1800/1600),
--                                Vermillion Sparrow (1900/1500),
--                                Queen of Autumn Leaves (1800/1500),
--                                Harpie's Pet Dragon (2000/2500),
--                                Mystical Sand (2100/1700)

DROP TABLE IF EXISTS PredictedFusionsForMavelus;
DROP TABLE IF EXISTS FusionsForMavelus;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMavelus;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMavelusPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMavelus;

-- Create table with predicted fusions resulting in Mavelus

CREATE TEMPORARY TABLE PredictedFusionsForMavelus AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.CardType = 'Winged Beast' AND
  C1.Attack < 1300 AND C2.Attack < 1300);

INSERT INTO PredictedFusionsForMavelus
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMavelus;

-- Create table with actual fusions for Mavelus

CREATE TEMPORARY TABLE FusionsForMavelus AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Mavelus';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMavelus AS
SELECT * FROM PredictedFusionsForMavelus
EXCEPT 
SELECT * FROM FusionsForMavelus;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMavelusPlus AS
SELECT IncorrectPredictedFusionsForMavelus.Material1Name,
IncorrectPredictedFusionsForMavelus.Material1Type,
IncorrectPredictedFusionsForMavelus.Material1SecTypes,
IncorrectPredictedFusionsForMavelus.Material1Attack,
IncorrectPredictedFusionsForMavelus.Material2Name,
IncorrectPredictedFusionsForMavelus.Material2Type,
IncorrectPredictedFusionsForMavelus.Material2SecTypes,
IncorrectPredictedFusionsForMavelus.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMavelus
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMavelus.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMavelus.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMavelus AS
SELECT * FROM FusionsForMavelus
EXCEPT 
SELECT * FROM PredictedFusionsForMavelus;