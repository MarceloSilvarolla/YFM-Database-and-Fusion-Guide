-- Test Darkworld Thorns fusions
--[Fiend] + Fungi of the Musk (400/300) = Darkworld Thorns (1200/900)

DROP TABLE IF EXISTS PredictedFusionsForDarkworldThorns;
DROP TABLE IF EXISTS FusionsForDarkworldThorns;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDarkworldThorns;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDarkworldThornsPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDarkworldThorns;

-- Create table with predicted fusions resulting in Darkworld Thorns

CREATE TEMPORARY TABLE PredictedFusionsForDarkworldThorns AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fiend' AND C2.CardName = 'Fungi of the Musk' AND
  C1.Attack < 1200 AND C2.Attack < 1200);

INSERT INTO PredictedFusionsForDarkworldThorns
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDarkworldThorns;

-- Create table with actual fusions for Darkworld Thorns

CREATE TEMPORARY TABLE FusionsForDarkworldThorns AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Darkworld Thorns';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDarkworldThorns AS
SELECT * FROM PredictedFusionsForDarkworldThorns
EXCEPT 
SELECT * FROM FusionsForDarkworldThorns;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDarkworldThornsPlus AS
SELECT IncorrectPredictedFusionsForDarkworldThorns.Material1Name,
IncorrectPredictedFusionsForDarkworldThorns.Material1Type,
IncorrectPredictedFusionsForDarkworldThorns.Material1SecTypes,
IncorrectPredictedFusionsForDarkworldThorns.Material1Attack,
IncorrectPredictedFusionsForDarkworldThorns.Material2Name,
IncorrectPredictedFusionsForDarkworldThorns.Material2Type,
IncorrectPredictedFusionsForDarkworldThorns.Material2SecTypes,
IncorrectPredictedFusionsForDarkworldThorns.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDarkworldThorns
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDarkworldThorns.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDarkworldThorns.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDarkworldThorns AS
SELECT * FROM FusionsForDarkworldThorns
EXCEPT 
SELECT * FROM PredictedFusionsForDarkworldThorns;