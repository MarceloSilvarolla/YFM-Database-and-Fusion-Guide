-- Test Celtic Guardian fusions
--[Elf] + [Warrior]         = Celtic Guardian (1400/1200)

DROP TABLE IF EXISTS PredictedFusionsForCelticGuardian;
DROP TABLE IF EXISTS FusionsForCelticGuardian;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCelticGuardian;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCelticGuardianPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForCelticGuardian;

-- Create table with predicted fusions resulting in Celtic Guardian

CREATE TEMPORARY TABLE PredictedFusionsForCelticGuardian AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsElf = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1400 AND C2.Attack < 1400);

INSERT INTO PredictedFusionsForCelticGuardian
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForCelticGuardian;

-- Create table with actual fusions for Celtic Guardian

CREATE TEMPORARY TABLE FusionsForCelticGuardian AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Celtic Guardian';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCelticGuardian AS
SELECT * FROM PredictedFusionsForCelticGuardian
EXCEPT 
SELECT * FROM FusionsForCelticGuardian;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCelticGuardianPlus AS
SELECT IncorrectPredictedFusionsForCelticGuardian.Material1Name,
IncorrectPredictedFusionsForCelticGuardian.Material1Type,
IncorrectPredictedFusionsForCelticGuardian.Material1SecTypes,
IncorrectPredictedFusionsForCelticGuardian.Material1Attack,
IncorrectPredictedFusionsForCelticGuardian.Material2Name,
IncorrectPredictedFusionsForCelticGuardian.Material2Type,
IncorrectPredictedFusionsForCelticGuardian.Material2SecTypes,
IncorrectPredictedFusionsForCelticGuardian.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForCelticGuardian
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForCelticGuardian.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForCelticGuardian.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForCelticGuardian AS
SELECT * FROM FusionsForCelticGuardian
EXCEPT 
SELECT * FROM PredictedFusionsForCelticGuardian;