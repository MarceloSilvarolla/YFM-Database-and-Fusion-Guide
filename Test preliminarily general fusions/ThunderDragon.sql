-- Test Thunder Dragon fusions
-- [Dragon] + [Thunder]      = Thunder Dragon (1600/1500)
--                           = Twin-Headed Thunder Dragon (2800/2100)
--             				     < Skelgon (1700/1900)
DROP TABLE IF EXISTS PredictedFusionsForThunderDragon;
DROP TABLE IF EXISTS FusionsForThunderDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForThunderDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForThunderDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForThunderDragon;

-- Create table with predicted fusions resulting in Thunder Dragon

CREATE TEMPORARY TABLE PredictedFusionsForThunderDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Thunder' AND
  C1.Attack < 1600 AND C2.Attack < 1600;

INSERT INTO PredictedFusionsForThunderDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForThunderDragon;

-- Create table with actual fusions for Thunder Dragon

CREATE TEMPORARY TABLE FusionsForThunderDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Thunder Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForThunderDragon AS
SELECT * FROM PredictedFusionsForThunderDragon
EXCEPT 
SELECT * FROM FusionsForThunderDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForThunderDragonPlus AS
SELECT IncorrectPredictedFusionsForThunderDragon.Material1Name,
IncorrectPredictedFusionsForThunderDragon.Material1Type,
IncorrectPredictedFusionsForThunderDragon.Material1SecTypes,
IncorrectPredictedFusionsForThunderDragon.Material1Attack,
IncorrectPredictedFusionsForThunderDragon.Material2Name,
IncorrectPredictedFusionsForThunderDragon.Material2Type,
IncorrectPredictedFusionsForThunderDragon.Material2SecTypes,
IncorrectPredictedFusionsForThunderDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForThunderDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForThunderDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForThunderDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForThunderDragon AS
SELECT * FROM FusionsForThunderDragon
EXCEPT 
SELECT * FROM PredictedFusionsForThunderDragon;








