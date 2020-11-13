-- Test Disk Magician fusions
--[MercurySpellcaster] + [Machine]
--                          = Disk Magician (1350/1000)

DROP TABLE IF EXISTS PredictedFusionsForDiskMagician;
DROP TABLE IF EXISTS FusionsForDiskMagician;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDiskMagician;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDiskMagicianPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDiskMagician;

-- Create table with predicted fusions resulting in Disk Magician

CREATE TEMPORARY TABLE PredictedFusionsForDiskMagician AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsMercurySpellcaster = 1 AND C2.CardType = 'Machine' AND
  C1.Attack < 1350 AND C2.Attack < 1350;

INSERT INTO PredictedFusionsForDiskMagician
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDiskMagician;

-- Create table with actual fusions for Disk Magician

CREATE TEMPORARY TABLE FusionsForDiskMagician AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Disk Magician';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDiskMagician AS
SELECT * FROM PredictedFusionsForDiskMagician
EXCEPT 
SELECT * FROM FusionsForDiskMagician;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDiskMagicianPlus AS
SELECT IncorrectPredictedFusionsForDiskMagician.Material1Name,
IncorrectPredictedFusionsForDiskMagician.Material1Type,
IncorrectPredictedFusionsForDiskMagician.Material1SecTypes,
IncorrectPredictedFusionsForDiskMagician.Material1Attack,
IncorrectPredictedFusionsForDiskMagician.Material2Name,
IncorrectPredictedFusionsForDiskMagician.Material2Type,
IncorrectPredictedFusionsForDiskMagician.Material2SecTypes,
IncorrectPredictedFusionsForDiskMagician.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDiskMagician
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDiskMagician.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDiskMagician.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDiskMagician AS
SELECT * FROM FusionsForDiskMagician
EXCEPT 
SELECT * FROM PredictedFusionsForDiskMagician;