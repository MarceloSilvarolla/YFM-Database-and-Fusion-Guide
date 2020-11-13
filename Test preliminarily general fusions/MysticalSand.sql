-- Test Mystical Sand fusions
--[Female] + [Rock] = Mystical Sand (2100/1700)

DROP TABLE IF EXISTS PredictedFusionsForMysticalSand;
DROP TABLE IF EXISTS FusionsForMysticalSand;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMysticalSand;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMysticalSandPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMysticalSand;

-- Create table with predicted fusions resulting in Mystical Sand

CREATE TEMPORARY TABLE PredictedFusionsForMysticalSand AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsFemale = 1 AND C2.CardType = 'Rock' AND
  C1.Attack < 2100 AND C2.Attack < 2100);

INSERT INTO PredictedFusionsForMysticalSand
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMysticalSand;

-- Create table with actual fusions for Mystical Sand

CREATE TEMPORARY TABLE FusionsForMysticalSand AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Mystical Sand';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMysticalSand AS
SELECT * FROM PredictedFusionsForMysticalSand
EXCEPT 
SELECT * FROM FusionsForMysticalSand;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMysticalSandPlus AS
SELECT IncorrectPredictedFusionsForMysticalSand.Material1Name,
IncorrectPredictedFusionsForMysticalSand.Material1Type,
IncorrectPredictedFusionsForMysticalSand.Material1SecTypes,
IncorrectPredictedFusionsForMysticalSand.Material1Attack,
IncorrectPredictedFusionsForMysticalSand.Material2Name,
IncorrectPredictedFusionsForMysticalSand.Material2Type,
IncorrectPredictedFusionsForMysticalSand.Material2SecTypes,
IncorrectPredictedFusionsForMysticalSand.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMysticalSand
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMysticalSand.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMysticalSand.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMysticalSand AS
SELECT * FROM FusionsForMysticalSand
EXCEPT 
SELECT * FROM PredictedFusionsForMysticalSand;