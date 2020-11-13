-- Test Flower Wolf fusions
--[UsableBeast] + [Plant]   = Flower Wolf (1800/1400 Jupiter/Sun)
--                              < Nekogal #2 (1900/2000),
--                                Flame Cerebrus (2100/1800)
DROP TABLE IF EXISTS PredictedFusionsForFlowerWolf;
DROP TABLE IF EXISTS FusionsForFlowerWolf;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFlowerWolf;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFlowerWolfPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForFlowerWolf;

-- Create table with predicted fusions resulting in Flower Wolf

CREATE TEMPORARY TABLE PredictedFusionsForFlowerWolf AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsUsableBeast = 1 AND C2.CardType = 'Plant' AND
  C1.Attack < 1800 AND C2.Attack < 1800;

INSERT INTO PredictedFusionsForFlowerWolf
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForFlowerWolf;

-- Create table with actual fusions for Flower Wolf

CREATE TEMPORARY TABLE FusionsForFlowerWolf AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Flower Wolf';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFlowerWolf AS
SELECT * FROM PredictedFusionsForFlowerWolf
EXCEPT 
SELECT * FROM FusionsForFlowerWolf;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFlowerWolfPlus AS
SELECT IncorrectPredictedFusionsForFlowerWolf.Material1Name,
IncorrectPredictedFusionsForFlowerWolf.Material1Type,
IncorrectPredictedFusionsForFlowerWolf.Material1SecTypes,
IncorrectPredictedFusionsForFlowerWolf.Material1Attack,
IncorrectPredictedFusionsForFlowerWolf.Material2Name,
IncorrectPredictedFusionsForFlowerWolf.Material2Type,
IncorrectPredictedFusionsForFlowerWolf.Material2SecTypes,
IncorrectPredictedFusionsForFlowerWolf.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForFlowerWolf
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForFlowerWolf.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForFlowerWolf.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForFlowerWolf AS
SELECT * FROM FusionsForFlowerWolf
EXCEPT 
SELECT * FROM PredictedFusionsForFlowerWolf;














