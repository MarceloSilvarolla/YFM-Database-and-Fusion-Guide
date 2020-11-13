-- Test Tripwire Beast fusions
--[Beast] + [Thunder]       = Tripwire Beast (1200/1300)

DROP TABLE IF EXISTS PredictedFusionsForTripwireBeast;
DROP TABLE IF EXISTS FusionsForTripwireBeast;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTripwireBeast;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTripwireBeastPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForTripwireBeast;

-- Create table with predicted fusions resulting in Tripwire Beast

CREATE TEMPORARY TABLE PredictedFusionsForTripwireBeast AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Beast' AND C2.CardType = 'Thunder' AND
  C1.Attack < 1200 AND C2.Attack < 1200;

INSERT INTO PredictedFusionsForTripwireBeast
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForTripwireBeast;

-- Create table with actual fusions for Tripwire Beast

CREATE TEMPORARY TABLE FusionsForTripwireBeast AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Tripwire Beast';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTripwireBeast AS
SELECT * FROM PredictedFusionsForTripwireBeast
EXCEPT 
SELECT * FROM FusionsForTripwireBeast;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTripwireBeastPlus AS
SELECT IncorrectPredictedFusionsForTripwireBeast.Material1Name,
IncorrectPredictedFusionsForTripwireBeast.Material1Type,
IncorrectPredictedFusionsForTripwireBeast.Material1SecTypes,
IncorrectPredictedFusionsForTripwireBeast.Material1Attack,
IncorrectPredictedFusionsForTripwireBeast.Material2Name,
IncorrectPredictedFusionsForTripwireBeast.Material2Type,
IncorrectPredictedFusionsForTripwireBeast.Material2SecTypes,
IncorrectPredictedFusionsForTripwireBeast.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForTripwireBeast
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForTripwireBeast.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForTripwireBeast.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForTripwireBeast AS
SELECT * FROM FusionsForTripwireBeast
EXCEPT 
SELECT * FROM PredictedFusionsForTripwireBeast;