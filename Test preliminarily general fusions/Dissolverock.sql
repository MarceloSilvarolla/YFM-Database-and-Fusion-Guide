-- Test Dissolverock fusions
--[Pyro] + [Rock]           = Dissolverock (900/1000)

DROP TABLE IF EXISTS PredictedFusionsForDissolverock;
DROP TABLE IF EXISTS FusionsForDissolverock;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDissolverock;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDissolverockPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDissolverock;

-- Create table with predicted fusions resulting in Dissolverock

CREATE TEMPORARY TABLE PredictedFusionsForDissolverock AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.CardType = 'Rock' AND
  C1.Attack < 900 AND C2.Attack < 900);

INSERT INTO PredictedFusionsForDissolverock
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDissolverock;

-- Create table with actual fusions for Dissolverock

CREATE TEMPORARY TABLE FusionsForDissolverock AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Dissolverock';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDissolverock AS
SELECT * FROM PredictedFusionsForDissolverock
EXCEPT 
SELECT * FROM FusionsForDissolverock;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDissolverockPlus AS
SELECT IncorrectPredictedFusionsForDissolverock.Material1Name,
IncorrectPredictedFusionsForDissolverock.Material1Type,
IncorrectPredictedFusionsForDissolverock.Material1SecTypes,
IncorrectPredictedFusionsForDissolverock.Material1Attack,
IncorrectPredictedFusionsForDissolverock.Material2Name,
IncorrectPredictedFusionsForDissolverock.Material2Type,
IncorrectPredictedFusionsForDissolverock.Material2SecTypes,
IncorrectPredictedFusionsForDissolverock.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDissolverock
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDissolverock.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDissolverock.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDissolverock AS
SELECT * FROM FusionsForDissolverock
EXCEPT 
SELECT * FROM PredictedFusionsForDissolverock;