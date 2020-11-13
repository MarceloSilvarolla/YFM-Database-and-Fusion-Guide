-- Test Firegrass fusions
--[Plant] + [Pyro]          = Firegrass (700/600)

DROP TABLE IF EXISTS PredictedFusionsForFiregrass;
DROP TABLE IF EXISTS FusionsForFiregrass;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFiregrass;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFiregrassPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForFiregrass;

-- Create table with predicted fusions resulting in Firegrass

CREATE TEMPORARY TABLE PredictedFusionsForFiregrass AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Plant' AND C2.IsPyro = 1 AND
  C1.Attack < 700 AND C2.Attack < 700);

INSERT INTO PredictedFusionsForFiregrass
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForFiregrass;

-- Create table with actual fusions for Firegrass

CREATE TEMPORARY TABLE FusionsForFiregrass AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Firegrass';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFiregrass AS
SELECT * FROM PredictedFusionsForFiregrass
EXCEPT 
SELECT * FROM FusionsForFiregrass;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFiregrassPlus AS
SELECT IncorrectPredictedFusionsForFiregrass.Material1Name,
IncorrectPredictedFusionsForFiregrass.Material1Type,
IncorrectPredictedFusionsForFiregrass.Material1SecTypes,
IncorrectPredictedFusionsForFiregrass.Material1Attack,
IncorrectPredictedFusionsForFiregrass.Material2Name,
IncorrectPredictedFusionsForFiregrass.Material2Type,
IncorrectPredictedFusionsForFiregrass.Material2SecTypes,
IncorrectPredictedFusionsForFiregrass.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForFiregrass
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForFiregrass.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForFiregrass.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForFiregrass AS
SELECT * FROM FusionsForFiregrass
EXCEPT 
SELECT * FROM PredictedFusionsForFiregrass;