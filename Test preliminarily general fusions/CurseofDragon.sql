-- Test Curse of Dragon fusions
--[Dragon] + [Zombie]       = Dragon Zombie (1600/0)
--                          = Skelgon (1700/1900)
--                          = Curse of Dragon (2000/1500)
--                              < Sword Arm of Dragon (1750/2030),
--                                Twin-headed Thunder Dragon (2800/2100)
DROP TABLE IF EXISTS PredictedFusionsForCurseOfDragon;
DROP TABLE IF EXISTS FusionsForCurseOfDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCurseOfDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCurseOfDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForCurseOfDragon;

-- Create table with predicted fusions resulting in Curse of Dragon

CREATE TEMPORARY TABLE PredictedFusionsForCurseOfDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Zombie' AND
  C1.Attack < 2000 AND C2.Attack < 2000 AND
  (C1.Attack >= 1700 OR C2.Attack >= 1700);

INSERT INTO PredictedFusionsForCurseOfDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForCurseOfDragon;

-- Create table with actual fusions for CurseOfDragon

CREATE TEMPORARY TABLE FusionsForCurseOfDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Curse of Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCurseOfDragon AS
SELECT * FROM PredictedFusionsForCurseOfDragon
EXCEPT 
SELECT * FROM FusionsForCurseOfDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCurseOfDragonPlus AS
SELECT IncorrectPredictedFusionsForCurseOfDragon.Material1Name,
IncorrectPredictedFusionsForCurseOfDragon.Material1Type,
IncorrectPredictedFusionsForCurseOfDragon.Material1SecTypes,
IncorrectPredictedFusionsForCurseOfDragon.Material1Attack,
IncorrectPredictedFusionsForCurseOfDragon.Material2Name,
IncorrectPredictedFusionsForCurseOfDragon.Material2Type,
IncorrectPredictedFusionsForCurseOfDragon.Material2SecTypes,
IncorrectPredictedFusionsForCurseOfDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForCurseOfDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForCurseOfDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForCurseOfDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForCurseOfDragon AS
SELECT * FROM FusionsForCurseOfDragon
EXCEPT 
SELECT * FROM PredictedFusionsForCurseOfDragon;








