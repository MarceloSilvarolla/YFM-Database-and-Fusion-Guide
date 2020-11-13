-- Test Flame Cerebrus fusions
-- [UsableBeast] + [Pyro] = Flame Cerebrus (2100/1800)
DROP TABLE IF EXISTS PredictedFusionsForFlameCerebrus;
DROP TABLE IF EXISTS FusionsForFlameCerebrus;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFlameCerebrus;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFlameCerebrusPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForFlameCerebrus;

-- Create table with predicted fusions resulting in Flame Cerebrus

CREATE TEMPORARY TABLE PredictedFusionsForFlameCerebrus AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsUsableBeast = 1 AND C2.IsPyro = 1 AND
  C1.Attack < 2100 AND C2.Attack < 2100;

INSERT INTO PredictedFusionsForFlameCerebrus
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForFlameCerebrus;

-- Create table with actual fusions for Flame Cerebrus

CREATE TEMPORARY TABLE FusionsForFlameCerebrus AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Flame Cerebrus';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFlameCerebrus AS
SELECT * FROM PredictedFusionsForFlameCerebrus
EXCEPT 
SELECT * FROM FusionsForFlameCerebrus;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFlameCerebrusPlus AS
SELECT IncorrectPredictedFusionsForFlameCerebrus.Material1Name,
IncorrectPredictedFusionsForFlameCerebrus.Material1Type,
IncorrectPredictedFusionsForFlameCerebrus.Material1SecTypes,
IncorrectPredictedFusionsForFlameCerebrus.Material1Attack,
IncorrectPredictedFusionsForFlameCerebrus.Material2Name,
IncorrectPredictedFusionsForFlameCerebrus.Material2Type,
IncorrectPredictedFusionsForFlameCerebrus.Material2SecTypes,
IncorrectPredictedFusionsForFlameCerebrus.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForFlameCerebrus
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForFlameCerebrus.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForFlameCerebrus.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForFlameCerebrus AS
SELECT * FROM FusionsForFlameCerebrus
EXCEPT 
SELECT * FROM PredictedFusionsForFlameCerebrus;








