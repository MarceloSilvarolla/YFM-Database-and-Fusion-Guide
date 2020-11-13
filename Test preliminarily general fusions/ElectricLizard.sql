-- Test Electric Lizard fusions
--[Reptile] + [Thunder] = Electric Lizard (850/800)

DROP TABLE IF EXISTS PredictedFusionsForElectricLizard;
DROP TABLE IF EXISTS FusionsForElectricLizard;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForElectricLizard;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForElectricLizardPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForElectricLizard;

-- Create table with predicted fusions resulting in Electric Lizard

CREATE TEMPORARY TABLE PredictedFusionsForElectricLizard AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Reptile' AND C2.CardType = 'Thunder' AND
  C1.Attack < 850 AND C2.Attack < 850);

INSERT INTO PredictedFusionsForElectricLizard
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForElectricLizard;

-- Create table with actual fusions for Electric Lizard

CREATE TEMPORARY TABLE FusionsForElectricLizard AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Electric Lizard';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForElectricLizard AS
SELECT * FROM PredictedFusionsForElectricLizard
EXCEPT 
SELECT * FROM FusionsForElectricLizard;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForElectricLizardPlus AS
SELECT IncorrectPredictedFusionsForElectricLizard.Material1Name,
IncorrectPredictedFusionsForElectricLizard.Material1Type,
IncorrectPredictedFusionsForElectricLizard.Material1SecTypes,
IncorrectPredictedFusionsForElectricLizard.Material1Attack,
IncorrectPredictedFusionsForElectricLizard.Material2Name,
IncorrectPredictedFusionsForElectricLizard.Material2Type,
IncorrectPredictedFusionsForElectricLizard.Material2SecTypes,
IncorrectPredictedFusionsForElectricLizard.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForElectricLizard
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForElectricLizard.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForElectricLizard.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForElectricLizard AS
SELECT * FROM FusionsForElectricLizard
EXCEPT 
SELECT * FROM PredictedFusionsForElectricLizard;