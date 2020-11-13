-- Test Fire Kraken fusions
--[Pyro] + Fiend Kraken     = Fire Kraken (1600/1500)

DROP TABLE IF EXISTS PredictedFusionsForFireKraken;
DROP TABLE IF EXISTS FusionsForFireKraken;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFireKraken;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFireKrakenPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForFireKraken;

-- Create table with predicted fusions resulting in Fire Kraken

CREATE TEMPORARY TABLE PredictedFusionsForFireKraken AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.CardName = 'Fiend Kraken' AND
  C1.Attack < 1600 AND C2.Attack < 1600);

INSERT INTO PredictedFusionsForFireKraken
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForFireKraken;

-- Create table with actual fusions for Fire Kraken

CREATE TEMPORARY TABLE FusionsForFireKraken AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Fire Kraken';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFireKraken AS
SELECT * FROM PredictedFusionsForFireKraken
EXCEPT 
SELECT * FROM FusionsForFireKraken;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFireKrakenPlus AS
SELECT IncorrectPredictedFusionsForFireKraken.Material1Name,
IncorrectPredictedFusionsForFireKraken.Material1Type,
IncorrectPredictedFusionsForFireKraken.Material1SecTypes,
IncorrectPredictedFusionsForFireKraken.Material1Attack,
IncorrectPredictedFusionsForFireKraken.Material2Name,
IncorrectPredictedFusionsForFireKraken.Material2Type,
IncorrectPredictedFusionsForFireKraken.Material2SecTypes,
IncorrectPredictedFusionsForFireKraken.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForFireKraken
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForFireKraken.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForFireKraken.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForFireKraken AS
SELECT * FROM FusionsForFireKraken
EXCEPT 
SELECT * FROM PredictedFusionsForFireKraken;