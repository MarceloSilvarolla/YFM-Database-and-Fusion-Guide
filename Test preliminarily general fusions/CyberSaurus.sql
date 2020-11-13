-- Test Cyber Saurus fusions
--[Dinosaur] + [Machine]    = Cyber Saurus (1800/1400)

DROP TABLE IF EXISTS PredictedFusionsForCyberSaurus;
DROP TABLE IF EXISTS FusionsForCyberSaurus;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCyberSaurus;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCyberSaurusPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForCyberSaurus;

-- Create table with predicted fusions resulting in Cyber Saurus

CREATE TEMPORARY TABLE PredictedFusionsForCyberSaurus AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Dinosaur' AND C2.CardType = 'Machine' AND
  C1.Attack < 1800 AND C2.Attack < 1800;

INSERT INTO PredictedFusionsForCyberSaurus
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForCyberSaurus;

-- Create table with actual fusions for Cyber Saurus

CREATE TEMPORARY TABLE FusionsForCyberSaurus AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Cyber Saurus';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCyberSaurus AS
SELECT * FROM PredictedFusionsForCyberSaurus
EXCEPT 
SELECT * FROM FusionsForCyberSaurus;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCyberSaurusPlus AS
SELECT IncorrectPredictedFusionsForCyberSaurus.Material1Name,
IncorrectPredictedFusionsForCyberSaurus.Material1Type,
IncorrectPredictedFusionsForCyberSaurus.Material1SecTypes,
IncorrectPredictedFusionsForCyberSaurus.Material1Attack,
IncorrectPredictedFusionsForCyberSaurus.Material2Name,
IncorrectPredictedFusionsForCyberSaurus.Material2Type,
IncorrectPredictedFusionsForCyberSaurus.Material2SecTypes,
IncorrectPredictedFusionsForCyberSaurus.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForCyberSaurus
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForCyberSaurus.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForCyberSaurus.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForCyberSaurus AS
SELECT * FROM FusionsForCyberSaurus
EXCEPT 
SELECT * FROM PredictedFusionsForCyberSaurus;