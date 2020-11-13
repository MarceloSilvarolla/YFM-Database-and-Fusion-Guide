-- Test Thousand Dragon fusions
--[Dragon] + Time Wizard (500/400) 
--                        = Thousand Dragon (2400/2000)
DROP TABLE IF EXISTS PredictedFusionsForThousandDragon;
DROP TABLE IF EXISTS FusionsForThousandDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForThousandDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForThousandDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForThousandDragon;

-- Create table with predicted fusions resulting in Thousand Dragon

CREATE TEMPORARY TABLE PredictedFusionsForThousandDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardName = 'Time Wizard' AND
  C1.Attack < 2400 AND C2.Attack < 2400;

INSERT INTO PredictedFusionsForThousandDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForThousandDragon;

-- Create table with actual fusions for Thousand Dragon

CREATE TEMPORARY TABLE FusionsForThousandDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Thousand Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForThousandDragon AS
SELECT * FROM PredictedFusionsForThousandDragon
EXCEPT 
SELECT * FROM FusionsForThousandDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForThousandDragonPlus AS
SELECT IncorrectPredictedFusionsForThousandDragon.Material1Name,
IncorrectPredictedFusionsForThousandDragon.Material1Type,
IncorrectPredictedFusionsForThousandDragon.Material1SecTypes,
IncorrectPredictedFusionsForThousandDragon.Material1Attack,
IncorrectPredictedFusionsForThousandDragon.Material2Name,
IncorrectPredictedFusionsForThousandDragon.Material2Type,
IncorrectPredictedFusionsForThousandDragon.Material2SecTypes,
IncorrectPredictedFusionsForThousandDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForThousandDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForThousandDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForThousandDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForThousandDragon AS
SELECT * FROM FusionsForThousandDragon
EXCEPT 
SELECT * FROM PredictedFusionsForThousandDragon;








