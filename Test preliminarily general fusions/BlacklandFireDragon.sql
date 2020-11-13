-- Test Blackland Fire Dragon fusions
--[DarkMagic] + [Dragon]    = Blackland Fire Dragon (1500/800)
--                              < Dragon Zombie (1600/0),
--                               Dragon Statue (1100/900),
--                               Dragoness the Wicked Knight (1200/900),
--                               D. Human (1300/1100),
--                               Sword Arm of Dragon (1750/2030)

DROP TABLE IF EXISTS PredictedFusionsForBlacklandFireDragon;
DROP TABLE IF EXISTS FusionsForBlacklandFireDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBlacklandFireDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForBlacklandFireDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForBlacklandFireDragon;

-- Create table with predicted fusions resulting in Blackland Fire Dragon

CREATE TEMPORARY TABLE PredictedFusionsForBlacklandFireDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsMercuryMagicUser = 1 AND C2.IsDragon = 1 AND
  C1.Attack < 1500 AND C2.Attack < 1500;

INSERT INTO PredictedFusionsForBlacklandFireDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForBlacklandFireDragon;

-- Create table with actual fusions for Blackland Fire Dragon

CREATE TEMPORARY TABLE FusionsForBlacklandFireDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Blackland Fire Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBlacklandFireDragon AS
SELECT * FROM PredictedFusionsForBlacklandFireDragon
EXCEPT 
SELECT * FROM FusionsForBlacklandFireDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForBlacklandFireDragonPlus AS
SELECT IncorrectPredictedFusionsForBlacklandFireDragon.Material1Name,
IncorrectPredictedFusionsForBlacklandFireDragon.Material1Type,
IncorrectPredictedFusionsForBlacklandFireDragon.Material1SecTypes,
IncorrectPredictedFusionsForBlacklandFireDragon.Material1Attack,
IncorrectPredictedFusionsForBlacklandFireDragon.Material2Name,
IncorrectPredictedFusionsForBlacklandFireDragon.Material2Type,
IncorrectPredictedFusionsForBlacklandFireDragon.Material2SecTypes,
IncorrectPredictedFusionsForBlacklandFireDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForBlacklandFireDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForBlacklandFireDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForBlacklandFireDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForBlacklandFireDragon AS
SELECT * FROM FusionsForBlacklandFireDragon
EXCEPT 
SELECT * FROM PredictedFusionsForBlacklandFireDragon;