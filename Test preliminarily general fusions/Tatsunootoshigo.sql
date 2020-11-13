-- Test Tatsunootoshigo fusions
--[Beast] + [Fish]          = Tatsunootoshigo (1350/1600)
--                              < Nekogal #2 (1900/2000)
--                          = Rare Fish (1500/1200)
--                          = Marine Beast (1700/1600)
--                              < Nekogal #2 (1900/2000)

DROP TABLE IF EXISTS PredictedFusionsForTatsunootoshigo;
DROP TABLE IF EXISTS FusionsForTatsunootoshigo;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTatsunootoshigo;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTatsunootoshigoPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForTatsunootoshigo;

-- Create table with predicted fusions resulting in Tatsunootoshigo

CREATE TEMPORARY TABLE PredictedFusionsForTatsunootoshigo AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Beast' AND C2.CardType = 'Fish' AND
  C1.Attack < 1350 AND C2.Attack < 1350;


INSERT INTO PredictedFusionsForTatsunootoshigo
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForTatsunootoshigo;

-- Create table with actual fusions for Tatsunootoshigo

CREATE TEMPORARY TABLE FusionsForTatsunootoshigo AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Tatsunootoshigo';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTatsunootoshigo AS
SELECT * FROM PredictedFusionsForTatsunootoshigo
EXCEPT 
SELECT * FROM FusionsForTatsunootoshigo;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTatsunootoshigoPlus AS
SELECT IncorrectPredictedFusionsForTatsunootoshigo.Material1Name,
IncorrectPredictedFusionsForTatsunootoshigo.Material1Type,
IncorrectPredictedFusionsForTatsunootoshigo.Material1SecTypes,
IncorrectPredictedFusionsForTatsunootoshigo.Material1Attack,
IncorrectPredictedFusionsForTatsunootoshigo.Material2Name,
IncorrectPredictedFusionsForTatsunootoshigo.Material2Type,
IncorrectPredictedFusionsForTatsunootoshigo.Material2SecTypes,
IncorrectPredictedFusionsForTatsunootoshigo.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForTatsunootoshigo
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForTatsunootoshigo.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForTatsunootoshigo.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForTatsunootoshigo AS
SELECT * FROM FusionsForTatsunootoshigo
EXCEPT 
SELECT * FROM PredictedFusionsForTatsunootoshigo;