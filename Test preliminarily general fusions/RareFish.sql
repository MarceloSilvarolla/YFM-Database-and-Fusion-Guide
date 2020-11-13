-- Test Rare Fish fusions
--[Beast] + [Fish]          = Tatsunootoshigo (1350/1600)
--                              < Nekogal #2 (1900/2000)
--                          = Rare Fish (1500/1200)
--                          = Marine Beast (1700/1600)
--                              < Nekogal #2 (1900/2000)

DROP TABLE IF EXISTS PredictedFusionsForRareFish;
DROP TABLE IF EXISTS FusionsForRareFish;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForRareFish;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForRareFishPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForRareFish;

-- Create table with predicted fusions resulting in Rare Fish

CREATE TEMPORARY TABLE PredictedFusionsForRareFish AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Beast' AND C2.CardType = 'Fish' AND
  C1.Attack < 1500 AND C2.Attack < 1500 AND
  (C1.Attack >= 1350 OR C2.Attack >= 1350);

INSERT INTO PredictedFusionsForRareFish
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForRareFish;

-- Create table with actual fusions for Rare Fish

CREATE TEMPORARY TABLE FusionsForRareFish AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Rare Fish';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForRareFish AS
SELECT * FROM PredictedFusionsForRareFish
EXCEPT 
SELECT * FROM FusionsForRareFish;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForRareFishPlus AS
SELECT IncorrectPredictedFusionsForRareFish.Material1Name,
IncorrectPredictedFusionsForRareFish.Material1Type,
IncorrectPredictedFusionsForRareFish.Material1SecTypes,
IncorrectPredictedFusionsForRareFish.Material1Attack,
IncorrectPredictedFusionsForRareFish.Material2Name,
IncorrectPredictedFusionsForRareFish.Material2Type,
IncorrectPredictedFusionsForRareFish.Material2SecTypes,
IncorrectPredictedFusionsForRareFish.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForRareFish
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForRareFish.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForRareFish.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForRareFish AS
SELECT * FROM FusionsForRareFish
EXCEPT 
SELECT * FROM PredictedFusionsForRareFish;