-- Test Minomushi Warrior fusions
--[Rock] + [Warrior]        = Minomushi Warrior (1300/1200)
--                              < Charubin the Fire Knight (1100/800),
--                                Flame Swordsman (1800/1600),
--                                Stone D. (2000/2300),
--                                Mystical Sand (2100/1700)

DROP TABLE IF EXISTS PredictedFusionsForMinomushiWarrior;
DROP TABLE IF EXISTS FusionsForMinomushiWarrior;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMinomushiWarrior;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMinomushiWarriorPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMinomushiWarrior;

-- Create table with predicted fusions resulting in Minomushi Warrior

CREATE TEMPORARY TABLE PredictedFusionsForMinomushiWarrior AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Rock' AND C2.CardType = 'Warrior' AND
  C1.Attack < 1300 AND C2.Attack < 1300);

INSERT INTO PredictedFusionsForMinomushiWarrior
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMinomushiWarrior;

-- Create table with actual fusions for Minomushi Warrior

CREATE TEMPORARY TABLE FusionsForMinomushiWarrior AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Minomushi Warrior';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMinomushiWarrior AS
SELECT * FROM PredictedFusionsForMinomushiWarrior
EXCEPT 
SELECT * FROM FusionsForMinomushiWarrior;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMinomushiWarriorPlus AS
SELECT IncorrectPredictedFusionsForMinomushiWarrior.Material1Name,
IncorrectPredictedFusionsForMinomushiWarrior.Material1Type,
IncorrectPredictedFusionsForMinomushiWarrior.Material1SecTypes,
IncorrectPredictedFusionsForMinomushiWarrior.Material1Attack,
IncorrectPredictedFusionsForMinomushiWarrior.Material2Name,
IncorrectPredictedFusionsForMinomushiWarrior.Material2Type,
IncorrectPredictedFusionsForMinomushiWarrior.Material2SecTypes,
IncorrectPredictedFusionsForMinomushiWarrior.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMinomushiWarrior
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMinomushiWarrior.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMinomushiWarrior.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMinomushiWarrior AS
SELECT * FROM FusionsForMinomushiWarrior
EXCEPT 
SELECT * FROM PredictedFusionsForMinomushiWarrior;