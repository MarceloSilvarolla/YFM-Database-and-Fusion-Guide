-- Test Great Mammoth of Goldfine fusions
--[Zombie] + Mammoth Graveyard 
--                           = Great Mammoth of Goldfine (2200/1800)

DROP TABLE IF EXISTS PredictedFusionsForGreatMammothofGoldfine;
DROP TABLE IF EXISTS FusionsForGreatMammothofGoldfine;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForGreatMammothofGoldfine;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForGreatMammothofGoldfinePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForGreatMammothofGoldfine;

-- Create table with predicted fusions resulting in Great Mammoth of Goldfine

CREATE TEMPORARY TABLE PredictedFusionsForGreatMammothofGoldfine AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Zombie' AND C2.CardName = 'Mammoth Graveyard' AND
  C1.Attack < 2200 AND C2.Attack < 2200);

INSERT INTO PredictedFusionsForGreatMammothofGoldfine
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForGreatMammothofGoldfine;

-- Create table with actual fusions for Great Mammoth of Goldfine

CREATE TEMPORARY TABLE FusionsForGreatMammothofGoldfine AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Great Mammoth of Goldfine';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForGreatMammothofGoldfine AS
SELECT * FROM PredictedFusionsForGreatMammothofGoldfine
EXCEPT 
SELECT * FROM FusionsForGreatMammothofGoldfine;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForGreatMammothofGoldfinePlus AS
SELECT IncorrectPredictedFusionsForGreatMammothofGoldfine.Material1Name,
IncorrectPredictedFusionsForGreatMammothofGoldfine.Material1Type,
IncorrectPredictedFusionsForGreatMammothofGoldfine.Material1SecTypes,
IncorrectPredictedFusionsForGreatMammothofGoldfine.Material1Attack,
IncorrectPredictedFusionsForGreatMammothofGoldfine.Material2Name,
IncorrectPredictedFusionsForGreatMammothofGoldfine.Material2Type,
IncorrectPredictedFusionsForGreatMammothofGoldfine.Material2SecTypes,
IncorrectPredictedFusionsForGreatMammothofGoldfine.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForGreatMammothofGoldfine
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForGreatMammothofGoldfine.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForGreatMammothofGoldfine.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForGreatMammothofGoldfine AS
SELECT * FROM FusionsForGreatMammothofGoldfine
EXCEPT 
SELECT * FROM PredictedFusionsForGreatMammothofGoldfine;