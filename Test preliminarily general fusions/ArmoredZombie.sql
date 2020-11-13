-- Test Armored Zombie fusions
--[Warrior] + [Zombie]       = Zombie Warrior (1200/900)
--                               < Dragon Zombie (1600/0)
--                           = Armored Zombie (1500/0)
--                               < Dragon Zombie (1600/0),
--                                 Dark Elf (2000/800)

DROP TABLE IF EXISTS PredictedFusionsForArmoredZombie;
DROP TABLE IF EXISTS FusionsForArmoredZombie;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForArmoredZombie;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForArmoredZombiePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForArmoredZombie;

-- Create table with predicted fusions resulting in Armored Zombie

CREATE TEMPORARY TABLE PredictedFusionsForArmoredZombie AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Warrior' AND C2.CardType = 'Zombie' AND
  C1.Attack < 1500 AND C2.Attack < 1500) AND
  (C1.Attack >= 1200 OR C2.Attack >= 1200);

INSERT INTO PredictedFusionsForArmoredZombie
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForArmoredZombie;

-- Create table with actual fusions for Armored Zombie

CREATE TEMPORARY TABLE FusionsForArmoredZombie AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Armored Zombie';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForArmoredZombie AS
SELECT * FROM PredictedFusionsForArmoredZombie
EXCEPT 
SELECT * FROM FusionsForArmoredZombie;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForArmoredZombiePlus AS
SELECT IncorrectPredictedFusionsForArmoredZombie.Material1Name,
IncorrectPredictedFusionsForArmoredZombie.Material1Type,
IncorrectPredictedFusionsForArmoredZombie.Material1SecTypes,
IncorrectPredictedFusionsForArmoredZombie.Material1Attack,
IncorrectPredictedFusionsForArmoredZombie.Material2Name,
IncorrectPredictedFusionsForArmoredZombie.Material2Type,
IncorrectPredictedFusionsForArmoredZombie.Material2SecTypes,
IncorrectPredictedFusionsForArmoredZombie.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForArmoredZombie
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForArmoredZombie.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForArmoredZombie.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForArmoredZombie AS
SELECT * FROM FusionsForArmoredZombie
EXCEPT 
SELECT * FROM PredictedFusionsForArmoredZombie;