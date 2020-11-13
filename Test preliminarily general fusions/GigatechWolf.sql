-- Test Giga-tech Wolf fusions
--[UsableBeast] + [Machine] = Giga-tech Wolf (1200/1400 Jupiter/Uranus)
--                              < Flame Cerebrus (2100/1800)
--                          = Dice Armadillo (1650/1800 Jupiter/Pluto)
--                              < Flame Cerebrus (2100/1800)
DROP TABLE IF EXISTS PredictedFusionsForGigatechWolf;
DROP TABLE IF EXISTS FusionsForGigatechWolf;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForGigatechWolf;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForGigatechWolfPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForGigatechWolf;

-- Create table with predicted fusions resulting in Giga-tech Wolf

CREATE TEMPORARY TABLE PredictedFusionsForGigatechWolf AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  (C1.IsUsableBeast = 1 AND C2.CardType = 'Machine' AND
  C1.Attack < 1200 AND C2.Attack < 1200);

INSERT INTO PredictedFusionsForGigatechWolf
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForGigatechWolf;

-- Create table with actual fusions for Giga-tech Wolf

CREATE TEMPORARY TABLE FusionsForGigatechWolf AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Giga-tech Wolf';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForGigatechWolf AS
SELECT * FROM PredictedFusionsForGigatechWolf
EXCEPT 
SELECT * FROM FusionsForGigatechWolf;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForGigatechWolfPlus AS
SELECT IncorrectPredictedFusionsForGigatechWolf.Material1Name,
IncorrectPredictedFusionsForGigatechWolf.Material1Type,
IncorrectPredictedFusionsForGigatechWolf.Material1SecTypes,
IncorrectPredictedFusionsForGigatechWolf.Material1Attack,
IncorrectPredictedFusionsForGigatechWolf.Material2Name,
IncorrectPredictedFusionsForGigatechWolf.Material2Type,
IncorrectPredictedFusionsForGigatechWolf.Material2SecTypes,
IncorrectPredictedFusionsForGigatechWolf.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForGigatechWolf
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForGigatechWolf.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForGigatechWolf.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForGigatechWolf AS
SELECT * FROM FusionsForGigatechWolf
EXCEPT 
SELECT * FROM PredictedFusionsForGigatechWolf;
