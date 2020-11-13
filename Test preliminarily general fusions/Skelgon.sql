-- Test Skelgon fusions
--[Dragon] + [Zombie]       = Dragon Zombie (1600/0)
--                          = Skelgon (1700/1900)
--                          = Curse of Dragon (2000/1500)
--                              < Sword Arm of Dragon (1750/2030),
--                                Twin-headed Thunder Dragon (2800/2100)
DROP TABLE IF EXISTS PredictedFusionsForSkelgon;
DROP TABLE IF EXISTS FusionsForSkelgon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSkelgon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSkelgonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForSkelgon;

-- Create table with predicted fusions resulting in Skelgon

CREATE TEMPORARY TABLE PredictedFusionsForSkelgon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Zombie' AND
  C1.Attack < 1700 AND C2.Attack < 1700 AND
  (C1.Attack >= 1600 OR C2.Attack >= 1600);

INSERT INTO PredictedFusionsForSkelgon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForSkelgon;

-- Create table with actual fusions for Skelgon

CREATE TEMPORARY TABLE FusionsForSkelgon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Skelgon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSkelgon AS
SELECT * FROM PredictedFusionsForSkelgon
EXCEPT 
SELECT * FROM FusionsForSkelgon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSkelgonPlus AS
SELECT IncorrectPredictedFusionsForSkelgon.Material1Name,
IncorrectPredictedFusionsForSkelgon.Material1Type,
IncorrectPredictedFusionsForSkelgon.Material1SecTypes,
IncorrectPredictedFusionsForSkelgon.Material1Attack,
IncorrectPredictedFusionsForSkelgon.Material2Name,
IncorrectPredictedFusionsForSkelgon.Material2Type,
IncorrectPredictedFusionsForSkelgon.Material2SecTypes,
IncorrectPredictedFusionsForSkelgon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForSkelgon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForSkelgon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForSkelgon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForSkelgon AS
SELECT * FROM FusionsForSkelgon
EXCEPT 
SELECT * FROM PredictedFusionsForSkelgon;








