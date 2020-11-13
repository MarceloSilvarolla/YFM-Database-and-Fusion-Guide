-- Test Harpie's Pet Dragon fusions
--[Dragon] + Harpie Lady    = Harpie's Pet Dragon (2000/2500)

DROP TABLE IF EXISTS PredictedFusionsForHarpiesPetDragon;
DROP TABLE IF EXISTS FusionsForHarpiesPetDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForHarpiesPetDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForHarpiesPetDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForHarpiesPetDragon;

-- Create table with predicted fusions resulting in Harpie's Pet Dragon

CREATE TEMPORARY TABLE PredictedFusionsForHarpiesPetDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsDragon = 1 AND C2.CardName = 'Harpie Lady' AND
  C1.Attack < 2000 AND C2.Attack < 2000);

INSERT INTO PredictedFusionsForHarpiesPetDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForHarpiesPetDragon;

-- Create table with actual fusions for Harpie's Pet Dragon

CREATE TEMPORARY TABLE FusionsForHarpiesPetDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = "Harpie's Pet Dragon";

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForHarpiesPetDragon AS
SELECT * FROM PredictedFusionsForHarpiesPetDragon
EXCEPT 
SELECT * FROM FusionsForHarpiesPetDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForHarpiesPetDragonPlus AS
SELECT IncorrectPredictedFusionsForHarpiesPetDragon.Material1Name,
IncorrectPredictedFusionsForHarpiesPetDragon.Material1Type,
IncorrectPredictedFusionsForHarpiesPetDragon.Material1SecTypes,
IncorrectPredictedFusionsForHarpiesPetDragon.Material1Attack,
IncorrectPredictedFusionsForHarpiesPetDragon.Material2Name,
IncorrectPredictedFusionsForHarpiesPetDragon.Material2Type,
IncorrectPredictedFusionsForHarpiesPetDragon.Material2SecTypes,
IncorrectPredictedFusionsForHarpiesPetDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForHarpiesPetDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForHarpiesPetDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForHarpiesPetDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForHarpiesPetDragon AS
SELECT * FROM FusionsForHarpiesPetDragon
EXCEPT 
SELECT * FROM PredictedFusionsForHarpiesPetDragon;