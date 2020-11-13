-- Test Summoned Skull fusions
--[Fiend] + Job-change Mirror (800/1300)
--                          = Summoned Skull (2500/1200)
--                              < Darkworld Thorns (1200/900)

DROP TABLE IF EXISTS PredictedFusionsForSummonedSkull;
DROP TABLE IF EXISTS FusionsForSummonedSkull;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSummonedSkull;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSummonedSkullPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForSummonedSkull;

-- Create table with predicted fusions resulting in Summoned Skull

CREATE TEMPORARY TABLE PredictedFusionsForSummonedSkull AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fiend' AND C2.CardName = 'Job-change Mirror' AND
  C1.Attack < 2500 AND C2.Attack < 2500);

INSERT INTO PredictedFusionsForSummonedSkull
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForSummonedSkull;

-- Create table with actual fusions for Summoned Skull

CREATE TEMPORARY TABLE FusionsForSummonedSkull AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Summoned Skull';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSummonedSkull AS
SELECT * FROM PredictedFusionsForSummonedSkull
EXCEPT 
SELECT * FROM FusionsForSummonedSkull;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSummonedSkullPlus AS
SELECT IncorrectPredictedFusionsForSummonedSkull.Material1Name,
IncorrectPredictedFusionsForSummonedSkull.Material1Type,
IncorrectPredictedFusionsForSummonedSkull.Material1SecTypes,
IncorrectPredictedFusionsForSummonedSkull.Material1Attack,
IncorrectPredictedFusionsForSummonedSkull.Material2Name,
IncorrectPredictedFusionsForSummonedSkull.Material2Type,
IncorrectPredictedFusionsForSummonedSkull.Material2SecTypes,
IncorrectPredictedFusionsForSummonedSkull.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForSummonedSkull
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForSummonedSkull.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForSummonedSkull.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForSummonedSkull AS
SELECT * FROM FusionsForSummonedSkull
EXCEPT 
SELECT * FROM PredictedFusionsForSummonedSkull;