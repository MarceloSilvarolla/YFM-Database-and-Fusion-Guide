-- Test Kwagar Hercules fusions
--[Insect] + Kuwagata a      = Kwagar Hercules (1900/1700)

DROP TABLE IF EXISTS PredictedFusionsForKwagarHercules;
DROP TABLE IF EXISTS FusionsForKwagarHercules;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKwagarHercules;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKwagarHerculesPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForKwagarHercules;

-- Create table with predicted fusions resulting in Kwagar Hercules

CREATE TEMPORARY TABLE PredictedFusionsForKwagarHercules AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Insect' AND C2.CardName = 'Kuwagata a' AND
  C1.Attack < 1900 AND C2.Attack < 1900);

INSERT INTO PredictedFusionsForKwagarHercules
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForKwagarHercules;

-- Create table with actual fusions for Kwagar Hercules

CREATE TEMPORARY TABLE FusionsForKwagarHercules AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Kwagar Hercules';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKwagarHercules AS
SELECT * FROM PredictedFusionsForKwagarHercules
EXCEPT 
SELECT * FROM FusionsForKwagarHercules;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKwagarHerculesPlus AS
SELECT IncorrectPredictedFusionsForKwagarHercules.Material1Name,
IncorrectPredictedFusionsForKwagarHercules.Material1Type,
IncorrectPredictedFusionsForKwagarHercules.Material1SecTypes,
IncorrectPredictedFusionsForKwagarHercules.Material1Attack,
IncorrectPredictedFusionsForKwagarHercules.Material2Name,
IncorrectPredictedFusionsForKwagarHercules.Material2Type,
IncorrectPredictedFusionsForKwagarHercules.Material2SecTypes,
IncorrectPredictedFusionsForKwagarHercules.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForKwagarHercules
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForKwagarHercules.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForKwagarHercules.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForKwagarHercules AS
SELECT * FROM FusionsForKwagarHercules
EXCEPT 
SELECT * FROM PredictedFusionsForKwagarHercules;