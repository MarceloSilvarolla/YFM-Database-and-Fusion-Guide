-- Test Dragon Statue fusions
--[Dragon] + [Warrior]      = Dragon Statue (1100/900)
--                          = Dragoness the Wicked Knight (1200/900)
--                              < Flame Swordsman (1800/1600)
--                          = D. Human (1300/1100)
--                          = Sword Arm of Dragon (1750/2030)
--                              < Skelgon (1700/1900),
--                                Flame Swordsman (1800/1600),
--                                Dark Elf (2000/800)

DROP TABLE IF EXISTS PredictedFusionsForDragonStatue;
DROP TABLE IF EXISTS FusionsForDragonStatue;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDragonStatue;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDragonStatuePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDragonStatue;

-- Create table with predicted fusions resulting in Dragon Statue

CREATE TEMPORARY TABLE PredictedFusionsForDragonStatue AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1100 AND C2.Attack < 1100;

INSERT INTO PredictedFusionsForDragonStatue
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDragonStatue;

-- Create table with actual fusions for Dragon Statue

CREATE TEMPORARY TABLE FusionsForDragonStatue AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Dragon Statue';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDragonStatue AS
SELECT * FROM PredictedFusionsForDragonStatue
EXCEPT 
SELECT * FROM FusionsForDragonStatue;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDragonStatuePlus AS
SELECT IncorrectPredictedFusionsForDragonStatue.Material1Name,
IncorrectPredictedFusionsForDragonStatue.Material1Type,
IncorrectPredictedFusionsForDragonStatue.Material1SecTypes,
IncorrectPredictedFusionsForDragonStatue.Material1Attack,
IncorrectPredictedFusionsForDragonStatue.Material2Name,
IncorrectPredictedFusionsForDragonStatue.Material2Type,
IncorrectPredictedFusionsForDragonStatue.Material2SecTypes,
IncorrectPredictedFusionsForDragonStatue.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDragonStatue
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDragonStatue.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDragonStatue.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDragonStatue AS
SELECT * FROM FusionsForDragonStatue
EXCEPT 
SELECT * FROM PredictedFusionsForDragonStatue;








