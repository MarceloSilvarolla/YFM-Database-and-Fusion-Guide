-- Test The Snake Hair fusions
--[Zombie] + Graveyard and the Hand of Invitation
--                           = The Snake Hair (1500/1200) 

DROP TABLE IF EXISTS PredictedFusionsForTheSnakeHair;
DROP TABLE IF EXISTS FusionsForTheSnakeHair;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTheSnakeHair;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForTheSnakeHairPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForTheSnakeHair;

-- Create table with predicted fusions resulting in The Snake Hair

CREATE TEMPORARY TABLE PredictedFusionsForTheSnakeHair AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Zombie' AND C2.CardName = 'Graveyard and the Hand of Invitation' AND
  C1.Attack < 1500 AND C2.Attack < 1500);

INSERT INTO PredictedFusionsForTheSnakeHair
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForTheSnakeHair;

-- Create table with actual fusions for The Snake Hair

CREATE TEMPORARY TABLE FusionsForTheSnakeHair AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'The Snake Hair';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTheSnakeHair AS
SELECT * FROM PredictedFusionsForTheSnakeHair
EXCEPT 
SELECT * FROM FusionsForTheSnakeHair;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForTheSnakeHairPlus AS
SELECT IncorrectPredictedFusionsForTheSnakeHair.Material1Name,
IncorrectPredictedFusionsForTheSnakeHair.Material1Type,
IncorrectPredictedFusionsForTheSnakeHair.Material1SecTypes,
IncorrectPredictedFusionsForTheSnakeHair.Material1Attack,
IncorrectPredictedFusionsForTheSnakeHair.Material2Name,
IncorrectPredictedFusionsForTheSnakeHair.Material2Type,
IncorrectPredictedFusionsForTheSnakeHair.Material2SecTypes,
IncorrectPredictedFusionsForTheSnakeHair.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForTheSnakeHair
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForTheSnakeHair.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForTheSnakeHair.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForTheSnakeHair AS
SELECT * FROM FusionsForTheSnakeHair
EXCEPT 
SELECT * FROM PredictedFusionsForTheSnakeHair;