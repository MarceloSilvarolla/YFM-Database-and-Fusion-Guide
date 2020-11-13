-- Test Sword Arm of Dragon fusions
--[Dragon] + [Warrior]      = Dragon Statue (1100/900)
--                          = Dragoness the Wicked Knight (1200/900)
--                              < Flame Swordsman (1800/1600)
--                          = D. Human (1300/1100)
--                          = Sword Arm of Dragon (1750/2030)
--                              < Skelgon (1700/1900),
--                                Flame Swordsman (1800/1600),
--                                Dark Elf (2000/800)
DROP TABLE IF EXISTS PredictedFusionsForSwordArmOfDragon;
DROP TABLE IF EXISTS FusionsForSwordArmOfDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSwordArmOfDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForSwordArmOfDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForSwordArmOfDragon;

-- Create table with predicted fusions resulting in Sword Arm of Dragon

CREATE TEMPORARY TABLE PredictedFusionsForSwordArmOfDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1750 AND C2.Attack < 1750 AND
  (C1.Attack >= 1300 OR C2.Attack >= 1300);

INSERT INTO PredictedFusionsForSwordArmOfDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForSwordArmOfDragon;

-- Create table with actual fusions for Sword Arm of Dragon

CREATE TEMPORARY TABLE FusionsForSwordArmOfDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Sword Arm of Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSwordArmOfDragon AS
SELECT * FROM PredictedFusionsForSwordArmOfDragon
EXCEPT 
SELECT * FROM FusionsForSwordArmOfDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForSwordArmOfDragonPlus AS
SELECT IncorrectPredictedFusionsForSwordArmOfDragon.Material1Name,
IncorrectPredictedFusionsForSwordArmOfDragon.Material1Type,
IncorrectPredictedFusionsForSwordArmOfDragon.Material1SecTypes,
IncorrectPredictedFusionsForSwordArmOfDragon.Material1Attack,
IncorrectPredictedFusionsForSwordArmOfDragon.Material2Name,
IncorrectPredictedFusionsForSwordArmOfDragon.Material2Type,
IncorrectPredictedFusionsForSwordArmOfDragon.Material2SecTypes,
IncorrectPredictedFusionsForSwordArmOfDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForSwordArmOfDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForSwordArmOfDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForSwordArmOfDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForSwordArmOfDragon AS
SELECT * FROM FusionsForSwordArmOfDragon
EXCEPT 
SELECT * FROM PredictedFusionsForSwordArmOfDragon;








