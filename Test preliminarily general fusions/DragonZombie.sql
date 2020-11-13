-- Test Dragon Zombie fusions
--[Dragon] + [Zombie]       = Dragon Zombie (1600/0)
--                          = Skelgon (1700/1900)
--                          = Curse of Dragon (2000/1500)
--                              < Sword Arm of Dragon (1750/2030),
--                                Twin-headed Thunder Dragon (2800/2100)

DROP TABLE IF EXISTS PredictedFusionsForDragonZombie;
DROP TABLE IF EXISTS FusionsForDragonZombie;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDragonZombie;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDragonZombiePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDragonZombie;

-- Create table with predicted fusions resulting in Dragon Zombie

CREATE TEMPORARY TABLE PredictedFusionsForDragonZombie AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Zombie' AND
  C1.Attack < 1600 AND C2.Attack < 1600;

INSERT INTO PredictedFusionsForDragonZombie
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDragonZombie;

-- Create table with actual fusions for Dragon Zombie

CREATE TEMPORARY TABLE FusionsForDragonZombie AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Dragon Zombie';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDragonZombie AS
SELECT * FROM PredictedFusionsForDragonZombie
EXCEPT 
SELECT * FROM FusionsForDragonZombie;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDragonZombiePlus AS
SELECT IncorrectPredictedFusionsForDragonZombie.Material1Name,
IncorrectPredictedFusionsForDragonZombie.Material1Type,
IncorrectPredictedFusionsForDragonZombie.Material1SecTypes,
IncorrectPredictedFusionsForDragonZombie.Material1Attack,
IncorrectPredictedFusionsForDragonZombie.Material2Name,
IncorrectPredictedFusionsForDragonZombie.Material2Type,
IncorrectPredictedFusionsForDragonZombie.Material2SecTypes,
IncorrectPredictedFusionsForDragonZombie.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDragonZombie
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDragonZombie.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDragonZombie.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDragonZombie AS
SELECT * FROM FusionsForDragonZombie
EXCEPT 
SELECT * FROM PredictedFusionsForDragonZombie;








