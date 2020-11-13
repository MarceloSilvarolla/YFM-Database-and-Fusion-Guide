-- Test Marine Beast fusions
--[Beast] + [Fish]          = Tatsunootoshigo (1350/1600)
--                              < Nekogal #2 (1900/2000)
--                          = Rare Fish (1500/1200)
--                          = Marine Beast (1700/1600)
--                              < Nekogal #2 (1900/2000)

DROP TABLE IF EXISTS PredictedFusionsForMarineBeast;
DROP TABLE IF EXISTS FusionsForMarineBeast;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMarineBeast;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMarineBeastPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMarineBeast;

-- Create table with predicted fusions resulting in Marine Beast

CREATE TEMPORARY TABLE PredictedFusionsForMarineBeast AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Beast' AND C2.CardType = 'Fish' AND
  C1.Attack < 1700 AND C2.Attack < 1700 AND
  (C1.Attack >= 1500 OR C2.Attack >= 1500);

INSERT INTO PredictedFusionsForMarineBeast
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMarineBeast;

-- Create table with actual fusions for Marine Beast

CREATE TEMPORARY TABLE FusionsForMarineBeast AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Marine Beast';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMarineBeast AS
SELECT * FROM PredictedFusionsForMarineBeast
EXCEPT 
SELECT * FROM FusionsForMarineBeast;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMarineBeastPlus AS
SELECT IncorrectPredictedFusionsForMarineBeast.Material1Name,
IncorrectPredictedFusionsForMarineBeast.Material1Type,
IncorrectPredictedFusionsForMarineBeast.Material1SecTypes,
IncorrectPredictedFusionsForMarineBeast.Material1Attack,
IncorrectPredictedFusionsForMarineBeast.Material2Name,
IncorrectPredictedFusionsForMarineBeast.Material2Type,
IncorrectPredictedFusionsForMarineBeast.Material2SecTypes,
IncorrectPredictedFusionsForMarineBeast.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMarineBeast
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMarineBeast.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMarineBeast.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMarineBeast AS
SELECT * FROM FusionsForMarineBeast
EXCEPT 
SELECT * FROM PredictedFusionsForMarineBeast;