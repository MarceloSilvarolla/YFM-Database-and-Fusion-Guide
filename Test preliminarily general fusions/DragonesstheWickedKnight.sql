-- Test Dragoness the Wicked Knight fusions
--[Dragon] + [Warrior]      = Dragon Statue (1100/900)
--                          = Dragoness the Wicked Knight (1200/900)
--                              < Flame Swordsman (1800/1600)
--                          = D. Human (1300/1100)
--                          = Sword Arm of Dragon (1750/2030)
--                              < Skelgon (1700/1900),
--                                Flame Swordsman (1800/1600),
--                                Dark Elf (2000/800)
DROP TABLE IF EXISTS PredictedFusionsForDragonessTheWickedKnight;
DROP TABLE IF EXISTS FusionsForDragonessTheWickedKnight;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDragonessTheWickedKnight;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForDragonessTheWickedKnightPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForDragonessTheWickedKnight;

-- Create table with predicted fusions resulting in Dragoness the Wicked Knight

CREATE TEMPORARY TABLE PredictedFusionsForDragonessTheWickedKnight AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsDragon = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1200 AND C2.Attack < 1200 AND
  (C1.Attack >= 1100 OR C2.Attack >= 1100);

INSERT INTO PredictedFusionsForDragonessTheWickedKnight
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForDragonessTheWickedKnight;

-- Create table with actual fusions for Dragoness the Wicked Knight

CREATE TEMPORARY TABLE FusionsForDragonessTheWickedKnight AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Dragoness the Wicked Knight';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDragonessTheWickedKnight AS
SELECT * FROM PredictedFusionsForDragonessTheWickedKnight
EXCEPT 
SELECT * FROM FusionsForDragonessTheWickedKnight;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForDragonessTheWickedKnightPlus AS
SELECT IncorrectPredictedFusionsForDragonessTheWickedKnight.Material1Name,
IncorrectPredictedFusionsForDragonessTheWickedKnight.Material1Type,
IncorrectPredictedFusionsForDragonessTheWickedKnight.Material1SecTypes,
IncorrectPredictedFusionsForDragonessTheWickedKnight.Material1Attack,
IncorrectPredictedFusionsForDragonessTheWickedKnight.Material2Name,
IncorrectPredictedFusionsForDragonessTheWickedKnight.Material2Type,
IncorrectPredictedFusionsForDragonessTheWickedKnight.Material2SecTypes,
IncorrectPredictedFusionsForDragonessTheWickedKnight.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForDragonessTheWickedKnight
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForDragonessTheWickedKnight.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForDragonessTheWickedKnight.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForDragonessTheWickedKnight AS
SELECT * FROM FusionsForDragonessTheWickedKnight
EXCEPT 
SELECT * FROM PredictedFusionsForDragonessTheWickedKnight;








