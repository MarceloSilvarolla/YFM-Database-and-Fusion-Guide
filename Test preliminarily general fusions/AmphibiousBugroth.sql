-- Test Amphibious Bugroth fusions
--[AquaOrGS1Neptune] + Ground Attacker Bugroth
--                          = Amphibious Bugroth (1850/1300 Neptune/Sun)
--                              < Metal Fish (1600/1900),
--                                Metal Dragon (1850/1700)

DROP TABLE IF EXISTS PredictedFusionsForAmphibiousBugroth;
DROP TABLE IF EXISTS FusionsForAmphibiousBugroth;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForAmphibiousBugroth;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForAmphibiousBugrothPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForAmphibiousBugroth;

-- Create table with predicted fusions resulting in Amphibious Bugroth

CREATE TEMPORARY TABLE PredictedFusionsForAmphibiousBugroth AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.GuardianStar1 = 'Neptune' OR C1.CardType = 'Aqua') AND C2.CardName = 'Ground Attacker Bugroth' AND
  C1.Attack < 1850 AND C2.Attack < 1850;

INSERT INTO PredictedFusionsForAmphibiousBugroth
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForAmphibiousBugroth;

-- Create table with actual fusions for Amphibious Bugroth

CREATE TEMPORARY TABLE FusionsForAmphibiousBugroth AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Amphibious Bugroth';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForAmphibiousBugroth AS
SELECT * FROM PredictedFusionsForAmphibiousBugroth
EXCEPT 
SELECT * FROM FusionsForAmphibiousBugroth;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForAmphibiousBugrothPlus AS
SELECT IncorrectPredictedFusionsForAmphibiousBugroth.Material1Name,
IncorrectPredictedFusionsForAmphibiousBugroth.Material1Type,
IncorrectPredictedFusionsForAmphibiousBugroth.Material1SecTypes,
IncorrectPredictedFusionsForAmphibiousBugroth.Material1Attack,
IncorrectPredictedFusionsForAmphibiousBugroth.Material2Name,
IncorrectPredictedFusionsForAmphibiousBugroth.Material2Type,
IncorrectPredictedFusionsForAmphibiousBugroth.Material2SecTypes,
IncorrectPredictedFusionsForAmphibiousBugroth.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForAmphibiousBugroth
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForAmphibiousBugroth.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForAmphibiousBugroth.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForAmphibiousBugroth AS
SELECT * FROM FusionsForAmphibiousBugroth
EXCEPT 
SELECT * FROM PredictedFusionsForAmphibiousBugroth;