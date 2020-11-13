-- Test Kairyu-shin fusions
--[Aqua] + [Dragon]         = Spike Seadra (1600/1300 Pluto/Mercury)
--                          = Kairyu-shin (1800/1500 Neptune/Mars)
--                              < Flame Swordsman (1800/1600)
DROP TABLE IF EXISTS PredictedFusionsForKairyushin;
DROP TABLE IF EXISTS FusionsForKairyushin;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKairyushin;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKairyushinPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForKairyushin;

-- Create table with predicted fusions resulting in Kairyu-shin

CREATE TEMPORARY TABLE PredictedFusionsForKairyushin AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Aqua' AND C2.IsDragon = 1 AND
  C1.Attack < 1800 AND C2.Attack < 1800 AND
  (C1.Attack >= 1600 OR C2.Attack >= 1600);

INSERT INTO PredictedFusionsForKairyushin
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForKairyushin;

-- Create table with actual fusions for Kairyu-shin

CREATE TEMPORARY TABLE FusionsForKairyushin AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Kairyu-shin';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKairyushin AS
SELECT * FROM PredictedFusionsForKairyushin
EXCEPT 
SELECT * FROM FusionsForKairyushin;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKairyushinPlus AS
SELECT IncorrectPredictedFusionsForKairyushin.Material1Name,
IncorrectPredictedFusionsForKairyushin.Material1Type,
IncorrectPredictedFusionsForKairyushin.Material1SecTypes,
IncorrectPredictedFusionsForKairyushin.Material1Attack,
IncorrectPredictedFusionsForKairyushin.Material2Name,
IncorrectPredictedFusionsForKairyushin.Material2Type,
IncorrectPredictedFusionsForKairyushin.Material2SecTypes,
IncorrectPredictedFusionsForKairyushin.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForKairyushin
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForKairyushin.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForKairyushin.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForKairyushin AS
SELECT * FROM FusionsForKairyushin
EXCEPT 
SELECT * FROM PredictedFusionsForKairyushin;