-- Test Mon Larvas fusions
--[Beast] + Larvas          = Mon Larvas (1300/1400)

DROP TABLE IF EXISTS PredictedFusionsForMonLarvas;
DROP TABLE IF EXISTS FusionsForMonLarvas;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMonLarvas;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMonLarvasPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMonLarvas;

-- Create table with predicted fusions resulting in Mon Larvas

CREATE TEMPORARY TABLE PredictedFusionsForMonLarvas AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Beast' AND C2.CardName = 'Larvas' AND
  C1.Attack < 1300 AND C2.Attack < 1300;

INSERT INTO PredictedFusionsForMonLarvas
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMonLarvas;

-- Create table with actual fusions for Mon Larvas

CREATE TEMPORARY TABLE FusionsForMonLarvas AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Mon Larvas';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMonLarvas AS
SELECT * FROM PredictedFusionsForMonLarvas
EXCEPT 
SELECT * FROM FusionsForMonLarvas;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMonLarvasPlus AS
SELECT IncorrectPredictedFusionsForMonLarvas.Material1Name,
IncorrectPredictedFusionsForMonLarvas.Material1Type,
IncorrectPredictedFusionsForMonLarvas.Material1SecTypes,
IncorrectPredictedFusionsForMonLarvas.Material1Attack,
IncorrectPredictedFusionsForMonLarvas.Material2Name,
IncorrectPredictedFusionsForMonLarvas.Material2Type,
IncorrectPredictedFusionsForMonLarvas.Material2SecTypes,
IncorrectPredictedFusionsForMonLarvas.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMonLarvas
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMonLarvas.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMonLarvas.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMonLarvas AS
SELECT * FROM FusionsForMonLarvas
EXCEPT 
SELECT * FROM PredictedFusionsForMonLarvas;