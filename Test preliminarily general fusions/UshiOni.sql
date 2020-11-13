-- Test Ushi Oni fusions
--[MercurySpellcaster] + [Jar] = Ushi Oni (2150/1950)
--                              < Mystical Sand (2100/1700) 

DROP TABLE IF EXISTS PredictedFusionsForUshiOni;
DROP TABLE IF EXISTS FusionsForUshiOni;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForUshiOni;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForUshiOniPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForUshiOni;

-- Create table with predicted fusions resulting in Ushi Oni

CREATE TEMPORARY TABLE PredictedFusionsForUshiOni AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsMercurySpellcaster = 1 AND C2.IsJar = 1 AND
  C1.Attack < 2150 AND C2.Attack < 2150;

INSERT INTO PredictedFusionsForUshiOni
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForUshiOni;

-- Create table with actual fusions for Ushi Oni

CREATE TEMPORARY TABLE FusionsForUshiOni AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Ushi Oni';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForUshiOni AS
SELECT * FROM PredictedFusionsForUshiOni
EXCEPT 
SELECT * FROM FusionsForUshiOni;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForUshiOniPlus AS
SELECT IncorrectPredictedFusionsForUshiOni.Material1Name,
IncorrectPredictedFusionsForUshiOni.Material1Type,
IncorrectPredictedFusionsForUshiOni.Material1SecTypes,
IncorrectPredictedFusionsForUshiOni.Material1Attack,
IncorrectPredictedFusionsForUshiOni.Material2Name,
IncorrectPredictedFusionsForUshiOni.Material2Type,
IncorrectPredictedFusionsForUshiOni.Material2SecTypes,
IncorrectPredictedFusionsForUshiOni.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForUshiOni
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForUshiOni.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForUshiOni.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForUshiOni AS
SELECT * FROM FusionsForUshiOni
EXCEPT 
SELECT * FROM PredictedFusionsForUshiOni;