-- Test Dark Elf fusions
--[DarkMagic] + [Elf]      = Dark Elf (2000/800)

DROP TABLE IF EXISTS PredictedFusionsForDarkElf;
DROP TABLE IF EXISTS FusionsForDarkElf;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDarkElf;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDarkElfPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDarkElf;

-- Create table with predicted fusions resulting in Dark Elf

CREATE TEMPORARY TABLE PredictedFusionsForDarkElf AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsMercuryMagicUser = 1 AND C2.IsElf = 1 AND
  C1.Attack < 2000 AND C2.Attack < 2000;

INSERT INTO PredictedFusionsForDarkElf
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDarkElf;

-- Create table with actual fusions for Dark Elf

CREATE TEMPORARY TABLE FusionsForDarkElf AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Dark Elf';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDarkElf AS
SELECT * FROM PredictedFusionsForDarkElf
EXCEPT 
SELECT * FROM FusionsForDarkElf;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDarkElfPlus AS
SELECT IncorrectPredictedFusionsForDarkElf.Material1Name,
IncorrectPredictedFusionsForDarkElf.Material1Type,
IncorrectPredictedFusionsForDarkElf.Material1SecTypes,
IncorrectPredictedFusionsForDarkElf.Material1Attack,
IncorrectPredictedFusionsForDarkElf.Material2Name,
IncorrectPredictedFusionsForDarkElf.Material2Type,
IncorrectPredictedFusionsForDarkElf.Material2SecTypes,
IncorrectPredictedFusionsForDarkElf.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDarkElf
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDarkElf.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDarkElf.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDarkElf AS
SELECT * FROM FusionsForDarkElf
EXCEPT 
SELECT * FROM PredictedFusionsForDarkElf;