-- Test Dark Witch fusions
--[Fairy] + [Female] = Dark Witch (1800/1700)

DROP TABLE IF EXISTS PredictedFusionsForDarkWitch;
DROP TABLE IF EXISTS FusionsForDarkWitch;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDarkWitch;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDarkWitchPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDarkWitch;

-- Create table with predicted fusions resulting in Dark Witch

CREATE TEMPORARY TABLE PredictedFusionsForDarkWitch AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fairy' AND C2.IsFemale = 1 AND
  C1.Attack < 1800 AND C2.Attack < 1800);

INSERT INTO PredictedFusionsForDarkWitch
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDarkWitch;

-- Create table with actual fusions for Dark Witch

CREATE TEMPORARY TABLE FusionsForDarkWitch AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Dark Witch';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDarkWitch AS
SELECT * FROM PredictedFusionsForDarkWitch
EXCEPT 
SELECT * FROM FusionsForDarkWitch;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDarkWitchPlus AS
SELECT IncorrectPredictedFusionsForDarkWitch.Material1Name,
IncorrectPredictedFusionsForDarkWitch.Material1Type,
IncorrectPredictedFusionsForDarkWitch.Material1SecTypes,
IncorrectPredictedFusionsForDarkWitch.Material1Attack,
IncorrectPredictedFusionsForDarkWitch.Material2Name,
IncorrectPredictedFusionsForDarkWitch.Material2Type,
IncorrectPredictedFusionsForDarkWitch.Material2SecTypes,
IncorrectPredictedFusionsForDarkWitch.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDarkWitch
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDarkWitch.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDarkWitch.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDarkWitch AS
SELECT * FROM FusionsForDarkWitch
EXCEPT 
SELECT * FROM PredictedFusionsForDarkWitch;