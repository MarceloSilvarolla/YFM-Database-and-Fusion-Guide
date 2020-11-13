-- Test Marine Beast fusions
--[Dragon] + [Rock]         = Stone D. (2000/2300)
DROP TABLE IF EXISTS PredictedFusionsForStoneD;
DROP TABLE IF EXISTS FusionsForStoneD;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForStoneD;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForStoneDPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForStoneD;

-- Create table with predicted fusions resulting in Stone D.

CREATE TEMPORARY TABLE PredictedFusionsForStoneD AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Rock' AND
  C1.Attack < 2000 AND C2.Attack < 2000;

INSERT INTO PredictedFusionsForStoneD
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForStoneD;

-- Create table with actual fusions for Stone D.

CREATE TEMPORARY TABLE FusionsForStoneD AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Stone D.';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForStoneD AS
SELECT * FROM PredictedFusionsForStoneD
EXCEPT 
SELECT * FROM FusionsForStoneD;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForStoneDPlus AS
SELECT IncorrectPredictedFusionsForStoneD.Material1Name,
IncorrectPredictedFusionsForStoneD.Material1Type,
IncorrectPredictedFusionsForStoneD.Material1SecTypes,
IncorrectPredictedFusionsForStoneD.Material1Attack,
IncorrectPredictedFusionsForStoneD.Material2Name,
IncorrectPredictedFusionsForStoneD.Material2Type,
IncorrectPredictedFusionsForStoneD.Material2SecTypes,
IncorrectPredictedFusionsForStoneD.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForStoneD
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForStoneD.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForStoneD.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForStoneD AS
SELECT * FROM FusionsForStoneD
EXCEPT 
SELECT * FROM PredictedFusionsForStoneD;








