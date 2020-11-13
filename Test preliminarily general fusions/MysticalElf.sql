-- Test Mystical Elf fusions
--[Elf] + [MystElfian]      = Mystical Elf (800/2000)

DROP TABLE IF EXISTS PredictedFusionsForMysticalElf;
DROP TABLE IF EXISTS FusionsForMysticalElf;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMysticalElf;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMysticalElfPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMysticalElf;

-- Create table with predicted fusions resulting in Mystical Elf

CREATE TEMPORARY TABLE PredictedFusionsForMysticalElf AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsElf = 1 AND C2.IsMystElfian = 1 AND
  C1.Attack < 800 AND C2.Attack < 800);

INSERT INTO PredictedFusionsForMysticalElf
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMysticalElf;

-- Create table with actual fusions for Mystical Elf

CREATE TEMPORARY TABLE FusionsForMysticalElf AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Mystical Elf';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMysticalElf AS
SELECT * FROM PredictedFusionsForMysticalElf
EXCEPT 
SELECT * FROM FusionsForMysticalElf;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMysticalElfPlus AS
SELECT IncorrectPredictedFusionsForMysticalElf.Material1Name,
IncorrectPredictedFusionsForMysticalElf.Material1Type,
IncorrectPredictedFusionsForMysticalElf.Material1SecTypes,
IncorrectPredictedFusionsForMysticalElf.Material1Attack,
IncorrectPredictedFusionsForMysticalElf.Material2Name,
IncorrectPredictedFusionsForMysticalElf.Material2Type,
IncorrectPredictedFusionsForMysticalElf.Material2SecTypes,
IncorrectPredictedFusionsForMysticalElf.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMysticalElf
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMysticalElf.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMysticalElf.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMysticalElf AS
SELECT * FROM FusionsForMysticalElf
EXCEPT 
SELECT * FROM PredictedFusionsForMysticalElf;