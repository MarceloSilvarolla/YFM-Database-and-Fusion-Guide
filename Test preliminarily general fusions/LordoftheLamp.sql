-- Test Lord of the Lamp fusions
--[Spellcaster] + Mystic Lamp= Lord of the Lamp (1400/1200)
--                               < Dark Elf (2000/800)

DROP TABLE IF EXISTS PredictedFusionsForLordoftheLamp;
DROP TABLE IF EXISTS FusionsForLordoftheLamp;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForLordoftheLamp;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForLordoftheLampPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForLordoftheLamp;

-- Create table with predicted fusions resulting in Lord of the Lamp

CREATE TEMPORARY TABLE PredictedFusionsForLordoftheLamp AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Spellcaster' AND C2.CardName = 'Mystic Lamp' AND
  C1.Attack < 1400 AND C2.Attack < 1400);

INSERT INTO PredictedFusionsForLordoftheLamp
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForLordoftheLamp;

-- Create table with actual fusions for Lord of the Lamp

CREATE TEMPORARY TABLE FusionsForLordoftheLamp AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Lord of the Lamp';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForLordoftheLamp AS
SELECT * FROM PredictedFusionsForLordoftheLamp
EXCEPT 
SELECT * FROM FusionsForLordoftheLamp;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForLordoftheLampPlus AS
SELECT IncorrectPredictedFusionsForLordoftheLamp.Material1Name,
IncorrectPredictedFusionsForLordoftheLamp.Material1Type,
IncorrectPredictedFusionsForLordoftheLamp.Material1SecTypes,
IncorrectPredictedFusionsForLordoftheLamp.Material1Attack,
IncorrectPredictedFusionsForLordoftheLamp.Material2Name,
IncorrectPredictedFusionsForLordoftheLamp.Material2Type,
IncorrectPredictedFusionsForLordoftheLamp.Material2SecTypes,
IncorrectPredictedFusionsForLordoftheLamp.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForLordoftheLamp
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForLordoftheLamp.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForLordoftheLamp.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForLordoftheLamp AS
SELECT * FROM FusionsForLordoftheLamp
EXCEPT 
SELECT * FROM PredictedFusionsForLordoftheLamp;