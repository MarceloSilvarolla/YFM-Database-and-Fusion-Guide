-- Test Hyosube fusions
--[Aqua] + Kappa Avenger    = Hyosube (1500/900 Neptune/Venus)
--[Aqua] + Psychic Kappa    = Hyosube (1500/900 Neptune/Venus)

DROP TABLE IF EXISTS PredictedFusionsForHyosube;
DROP TABLE IF EXISTS FusionsForHyosube;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForHyosube;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForHyosubePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForHyosube;

-- Create table with predicted fusions resulting in Hyosube

CREATE TEMPORARY TABLE PredictedFusionsForHyosube AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Aqua' AND C2.CardName IN('Kappa Avenger', 'Psychic Kappa') AND
  C1.Attack < 1500 AND C2.Attack < 1500;


INSERT INTO PredictedFusionsForHyosube
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForHyosube;

-- Create table with actual fusions for Hyosube

CREATE TEMPORARY TABLE FusionsForHyosube AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Hyosube';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForHyosube AS
SELECT * FROM PredictedFusionsForHyosube
EXCEPT 
SELECT * FROM FusionsForHyosube;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForHyosubePlus AS
SELECT IncorrectPredictedFusionsForHyosube.Material1Name,
IncorrectPredictedFusionsForHyosube.Material1Type,
IncorrectPredictedFusionsForHyosube.Material1SecTypes,
IncorrectPredictedFusionsForHyosube.Material1Attack,
IncorrectPredictedFusionsForHyosube.Material2Name,
IncorrectPredictedFusionsForHyosube.Material2Type,
IncorrectPredictedFusionsForHyosube.Material2SecTypes,
IncorrectPredictedFusionsForHyosube.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForHyosube
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForHyosube.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForHyosube.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForHyosube AS
SELECT * FROM FusionsForHyosube
EXCEPT 
SELECT * FROM PredictedFusionsForHyosube;