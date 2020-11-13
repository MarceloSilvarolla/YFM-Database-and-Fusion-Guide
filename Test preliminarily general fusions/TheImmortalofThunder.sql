-- Test The Immortal of Thunder fusions
--[Spellcaster] + [Thunder]  = The Immortal of Thunder (1500/1300)
--                           = Kaminari Attack (1900/1400)
--                               < Thousand Dragon (2400/2000)

DROP TABLE IF EXISTS PredictedFusionsForTheImmortalofThunder;
DROP TABLE IF EXISTS FusionsForTheImmortalofThunder;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTheImmortalofThunder;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTheImmortalofThunderPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForTheImmortalofThunder;

-- Create table with predicted fusions resulting in The Immortal of Thunder

CREATE TEMPORARY TABLE PredictedFusionsForTheImmortalofThunder AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Spellcaster' AND C2.CardType = 'Thunder' AND
  C1.Attack < 1500 AND C2.Attack < 1500);

INSERT INTO PredictedFusionsForTheImmortalofThunder
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForTheImmortalofThunder;

-- Create table with actual fusions for The Immortal of Thunder

CREATE TEMPORARY TABLE FusionsForTheImmortalofThunder AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'The Immortal of Thunder';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTheImmortalofThunder AS
SELECT * FROM PredictedFusionsForTheImmortalofThunder
EXCEPT 
SELECT * FROM FusionsForTheImmortalofThunder;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTheImmortalofThunderPlus AS
SELECT IncorrectPredictedFusionsForTheImmortalofThunder.Material1Name,
IncorrectPredictedFusionsForTheImmortalofThunder.Material1Type,
IncorrectPredictedFusionsForTheImmortalofThunder.Material1SecTypes,
IncorrectPredictedFusionsForTheImmortalofThunder.Material1Attack,
IncorrectPredictedFusionsForTheImmortalofThunder.Material2Name,
IncorrectPredictedFusionsForTheImmortalofThunder.Material2Type,
IncorrectPredictedFusionsForTheImmortalofThunder.Material2SecTypes,
IncorrectPredictedFusionsForTheImmortalofThunder.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForTheImmortalofThunder
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForTheImmortalofThunder.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForTheImmortalofThunder.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForTheImmortalofThunder AS
SELECT * FROM FusionsForTheImmortalofThunder
EXCEPT 
SELECT * FROM PredictedFusionsForTheImmortalofThunder;