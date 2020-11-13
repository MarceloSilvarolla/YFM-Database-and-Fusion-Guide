-- Test Koumori Dragon fusions
--[Dragon] + ([GS1MoonNotFairy] u {Kuriboh, Mammoth Graveyard})
--                          = Koumori Dragon (1500/1200)
--                              < Dragon Statue (1100/900),
--                                Dragoness the Wicked Knight (1200/900),
--                                D. Human (1300/1100),
--                                Tiger Axe (1300/1100),
--                                Bean Soldier (1400/1300),
--                                Cyber Soldier (1500/1700),
--                                Dragon Zombie (1600/0),
--                                Spike Seadra  (1600/1300),
--                                Sword Arm of Dragon (1750/2030),
--                                Metal Dragon  (1850/1700),
--                                Stone D. (2000/2300),
--                                B. Dragon Jungle King (2100/1800)

DROP TABLE IF EXISTS PredictedFusionsForKoumoriDragon;
DROP TABLE IF EXISTS FusionsForKoumoriDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKoumoriDragon;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKoumoriDragonPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForKoumoriDragon;

-- Create table with predicted fusions resulting in Koumori Dragon

CREATE TEMPORARY TABLE PredictedFusionsForKoumoriDragon AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.IsDragon = 1 AND
  ( (C2.GuardianStar1 = 'Moon' AND C2.CardType <> 'Fairy') OR
  (C2.CardName IN ('Kuriboh', 'Mammoth Graveyard')) ) AND 
  C1.Attack < 1500 AND C2.Attack < 1500;

INSERT INTO PredictedFusionsForKoumoriDragon
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForKoumoriDragon;

-- Create table with actual fusions for Koumori Dragon

CREATE TEMPORARY TABLE FusionsForKoumoriDragon AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Koumori Dragon';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKoumoriDragon AS
SELECT * FROM PredictedFusionsForKoumoriDragon
EXCEPT 
SELECT * FROM FusionsForKoumoriDragon;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKoumoriDragonPlus AS
SELECT IncorrectPredictedFusionsForKoumoriDragon.Material1Name,
IncorrectPredictedFusionsForKoumoriDragon.Material1Type,
IncorrectPredictedFusionsForKoumoriDragon.Material1SecTypes,
IncorrectPredictedFusionsForKoumoriDragon.Material1Attack,
IncorrectPredictedFusionsForKoumoriDragon.Material2Name,
IncorrectPredictedFusionsForKoumoriDragon.Material2Type,
IncorrectPredictedFusionsForKoumoriDragon.Material2SecTypes,
IncorrectPredictedFusionsForKoumoriDragon.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForKoumoriDragon
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForKoumoriDragon.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForKoumoriDragon.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForKoumoriDragon AS
SELECT * FROM FusionsForKoumoriDragon
EXCEPT 
SELECT * FROM PredictedFusionsForKoumoriDragon;