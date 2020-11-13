-- Test Garvas fusions
--[Beast] + [AngelWinged]   = Garvas (2000/1700)
--                              < Dark Witch (1800/1700),
--                                Mon Larvas (1300/1400),
--                                Mystical Sheep #1 (1150/900),
--                                Nekogal #2 (1900/2000),
--                                Winged Egg of New Life (1400/1700)

DROP TABLE IF EXISTS PredictedFusionsForGarvas;
DROP TABLE IF EXISTS FusionsForGarvas;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForGarvas;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForGarvasPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForGarvas;

-- Create table with predicted fusions resulting in Garvas

CREATE TEMPORARY TABLE PredictedFusionsForGarvas AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Beast' AND C2.IsAngelWinged = 1 AND
  C1.Attack < 2000 AND C2.Attack < 2000;

INSERT INTO PredictedFusionsForGarvas
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForGarvas;

-- Create table with actual fusions for Garvas

CREATE TEMPORARY TABLE FusionsForGarvas AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Garvas';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForGarvas AS
SELECT * FROM PredictedFusionsForGarvas
EXCEPT 
SELECT * FROM FusionsForGarvas;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForGarvasPlus AS
SELECT IncorrectPredictedFusionsForGarvas.Material1Name,
IncorrectPredictedFusionsForGarvas.Material1Type,
IncorrectPredictedFusionsForGarvas.Material1SecTypes,
IncorrectPredictedFusionsForGarvas.Material1Attack,
IncorrectPredictedFusionsForGarvas.Material2Name,
IncorrectPredictedFusionsForGarvas.Material2Type,
IncorrectPredictedFusionsForGarvas.Material2SecTypes,
IncorrectPredictedFusionsForGarvas.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForGarvas
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForGarvas.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForGarvas.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForGarvas AS
SELECT * FROM FusionsForGarvas
EXCEPT 
SELECT * FROM PredictedFusionsForGarvas;