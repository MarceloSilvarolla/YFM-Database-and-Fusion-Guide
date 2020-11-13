-- Test Mystical Sheep #1 fusions
--[FiendOrGS1Moon] + Mystical Sheep #2 
--                          = Mystical Sheep #1 (1150/900)
--                              < Nekogal #2 (1900/2000)
--                                Flame Cerebrus (2100/1800)
--                                Giga-tech Wolf (1200/1400)
--                                Tiger Axe (1300/1100)
--                                Flower Wolf (1800/1400)

DROP TABLE IF EXISTS PredictedFusionsForMysticalSheep1;
DROP TABLE IF EXISTS FusionsForMysticalSheep1;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMysticalSheep1;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMysticalSheep1Plus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMysticalSheep1;

-- Create table with predicted fusions resulting in Mystical Sheep #1

CREATE TEMPORARY TABLE PredictedFusionsForMysticalSheep1 AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fiend' OR C1.GuardianStar1 = 'Moon') AND
   C2.CardName = 'Mystical Sheep #2' AND 
  C1.Attack < 1150 AND C2.Attack < 1150;

INSERT INTO PredictedFusionsForMysticalSheep1
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMysticalSheep1;

-- Create table with actual fusions for Mystical Sheep #1

CREATE TEMPORARY TABLE FusionsForMysticalSheep1 AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Mystical Sheep #1';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMysticalSheep1 AS
SELECT * FROM PredictedFusionsForMysticalSheep1
EXCEPT 
SELECT * FROM FusionsForMysticalSheep1;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMysticalSheep1Plus AS
SELECT IncorrectPredictedFusionsForMysticalSheep1.Material1Name,
IncorrectPredictedFusionsForMysticalSheep1.Material1Type,
IncorrectPredictedFusionsForMysticalSheep1.Material1SecTypes,
IncorrectPredictedFusionsForMysticalSheep1.Material1Attack,
IncorrectPredictedFusionsForMysticalSheep1.Material2Name,
IncorrectPredictedFusionsForMysticalSheep1.Material2Type,
IncorrectPredictedFusionsForMysticalSheep1.Material2SecTypes,
IncorrectPredictedFusionsForMysticalSheep1.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMysticalSheep1
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMysticalSheep1.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMysticalSheep1.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMysticalSheep1 AS
SELECT * FROM FusionsForMysticalSheep1
EXCEPT 
SELECT * FROM PredictedFusionsForMysticalSheep1;