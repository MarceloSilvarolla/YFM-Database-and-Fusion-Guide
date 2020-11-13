-- Test Zombie Warrior fusions
--[Warrior] + [Zombie]       = Zombie Warrior (1200/900)
--                               < Dragon Zombie (1600/0)
--                           = Armored Zombie (1500/0)
--                               < Dragon Zombie (1600/0),
--                                 Dark Elf (2000/800)

DROP TABLE IF EXISTS PredictedFusionsForZombieWarrior;
DROP TABLE IF EXISTS FusionsForZombieWarrior;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForZombieWarrior;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForZombieWarriorPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForZombieWarrior;

-- Create table with predicted fusions resulting in Zombie Warrior

CREATE TEMPORARY TABLE PredictedFusionsForZombieWarrior AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Warrior' AND C2.CardType = 'Zombie' AND
  C1.Attack < 1200 AND C2.Attack < 1200);

INSERT INTO PredictedFusionsForZombieWarrior
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForZombieWarrior;

-- Create table with actual fusions for Zombie Warrior

CREATE TEMPORARY TABLE FusionsForZombieWarrior AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Zombie Warrior';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForZombieWarrior AS
SELECT * FROM PredictedFusionsForZombieWarrior
EXCEPT 
SELECT * FROM FusionsForZombieWarrior;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForZombieWarriorPlus AS
SELECT IncorrectPredictedFusionsForZombieWarrior.Material1Name,
IncorrectPredictedFusionsForZombieWarrior.Material1Type,
IncorrectPredictedFusionsForZombieWarrior.Material1SecTypes,
IncorrectPredictedFusionsForZombieWarrior.Material1Attack,
IncorrectPredictedFusionsForZombieWarrior.Material2Name,
IncorrectPredictedFusionsForZombieWarrior.Material2Type,
IncorrectPredictedFusionsForZombieWarrior.Material2SecTypes,
IncorrectPredictedFusionsForZombieWarrior.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForZombieWarrior
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForZombieWarrior.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForZombieWarrior.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForZombieWarrior AS
SELECT * FROM FusionsForZombieWarrior
EXCEPT 
SELECT * FROM PredictedFusionsForZombieWarrior;