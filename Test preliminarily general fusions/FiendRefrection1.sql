-- Test Fiend Refrection #1 fusions
--[Winged Beast] + [Mirror]  = Fiend Refrection #1 (1300/1400)      

DROP TABLE IF EXISTS PredictedFusionsForFiendRefrection1;
DROP TABLE IF EXISTS FusionsForFiendRefrection1;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFiendRefrection1;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFiendRefrection1Plus;
DROP TABLE IF EXISTS MissingPredictedFusionsForFiendRefrection1;

-- Create table with predicted fusions resulting in Fiend Refrection #1

CREATE TEMPORARY TABLE PredictedFusionsForFiendRefrection1 AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Winged Beast' AND C2.IsMirror = 1 AND
  C1.Attack < 1300 AND C2.Attack < 1300);

INSERT INTO PredictedFusionsForFiendRefrection1
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForFiendRefrection1;

-- Create table with actual fusions for Fiend Refrection #1

CREATE TEMPORARY TABLE FusionsForFiendRefrection1 AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Fiend Refrection #1';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFiendRefrection1 AS
SELECT * FROM PredictedFusionsForFiendRefrection1
EXCEPT 
SELECT * FROM FusionsForFiendRefrection1;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFiendRefrection1Plus AS
SELECT IncorrectPredictedFusionsForFiendRefrection1.Material1Name,
IncorrectPredictedFusionsForFiendRefrection1.Material1Type,
IncorrectPredictedFusionsForFiendRefrection1.Material1SecTypes,
IncorrectPredictedFusionsForFiendRefrection1.Material1Attack,
IncorrectPredictedFusionsForFiendRefrection1.Material2Name,
IncorrectPredictedFusionsForFiendRefrection1.Material2Type,
IncorrectPredictedFusionsForFiendRefrection1.Material2SecTypes,
IncorrectPredictedFusionsForFiendRefrection1.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForFiendRefrection1
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForFiendRefrection1.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForFiendRefrection1.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForFiendRefrection1 AS
SELECT * FROM FusionsForFiendRefrection1
EXCEPT 
SELECT * FROM PredictedFusionsForFiendRefrection1;