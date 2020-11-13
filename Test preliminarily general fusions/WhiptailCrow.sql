-- Test Whiptail Crow fusions
--[Winged Beast] + Ryu-kishin = Whiptail Crow (1650/1600)

DROP TABLE IF EXISTS PredictedFusionsForWhiptailCrow;
DROP TABLE IF EXISTS FusionsForWhiptailCrow;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForWhiptailCrow;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForWhiptailCrowPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForWhiptailCrow;

-- Create table with predicted fusions resulting in Whiptail Crow

CREATE TEMPORARY TABLE PredictedFusionsForWhiptailCrow AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Winged Beast' AND C2.CardName = 'Ryu-kishin' AND
  C1.Attack < 1650 AND C2.Attack < 1650);

INSERT INTO PredictedFusionsForWhiptailCrow
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForWhiptailCrow;

-- Create table with actual fusions for Whiptail Crow

CREATE TEMPORARY TABLE FusionsForWhiptailCrow AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Whiptail Crow';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForWhiptailCrow AS
SELECT * FROM PredictedFusionsForWhiptailCrow
EXCEPT 
SELECT * FROM FusionsForWhiptailCrow;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForWhiptailCrowPlus AS
SELECT IncorrectPredictedFusionsForWhiptailCrow.Material1Name,
IncorrectPredictedFusionsForWhiptailCrow.Material1Type,
IncorrectPredictedFusionsForWhiptailCrow.Material1SecTypes,
IncorrectPredictedFusionsForWhiptailCrow.Material1Attack,
IncorrectPredictedFusionsForWhiptailCrow.Material2Name,
IncorrectPredictedFusionsForWhiptailCrow.Material2Type,
IncorrectPredictedFusionsForWhiptailCrow.Material2SecTypes,
IncorrectPredictedFusionsForWhiptailCrow.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForWhiptailCrow
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForWhiptailCrow.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForWhiptailCrow.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForWhiptailCrow AS
SELECT * FROM FusionsForWhiptailCrow
EXCEPT 
SELECT * FROM PredictedFusionsForWhiptailCrow;