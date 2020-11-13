-- Test Charubin the Fire Knight fusions
--[Pyro] + [Warrior]        = Charubin the Fire Knight (1100/800)
--                              < Zombie Warrior (1200/900),
--                                Queen of Autumn Leaves (1800/1500)
--                          = Flame Swordsman (1800/1600)
--                              < Zombie Warrior (1200/900),
--                                Armored Zombie (1500/0),
--                                Dragon Zombie (1600/0),
--                                Queen of Autumn Leaves (1800/1500)
--                          = Vermillion Sparrow (1900/1500)

DROP TABLE IF EXISTS PredictedFusionsForCharubintheFireKnight;
DROP TABLE IF EXISTS FusionsForCharubintheFireKnight;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCharubintheFireKnight;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForCharubintheFireKnightPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForCharubintheFireKnight;

-- Create table with predicted fusions resulting in Charubin the Fire Knight

CREATE TEMPORARY TABLE PredictedFusionsForCharubintheFireKnight AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE
  C1.IsPyro = 1 AND C2.CardType = 'Warrior' AND
  C1.Attack < 1100 AND C2.Attack < 1100;

INSERT INTO PredictedFusionsForCharubintheFireKnight
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForCharubintheFireKnight;

-- Create table with actual fusions for Charubin the Fire Knight

CREATE TEMPORARY TABLE FusionsForCharubintheFireKnight AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Charubin the Fire Knight';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCharubintheFireKnight AS
SELECT * FROM PredictedFusionsForCharubintheFireKnight
EXCEPT 
SELECT * FROM FusionsForCharubintheFireKnight;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForCharubintheFireKnightPlus AS
SELECT IncorrectPredictedFusionsForCharubintheFireKnight.Material1Name,
IncorrectPredictedFusionsForCharubintheFireKnight.Material1Type,
IncorrectPredictedFusionsForCharubintheFireKnight.Material1SecTypes,
IncorrectPredictedFusionsForCharubintheFireKnight.Material1Attack,
IncorrectPredictedFusionsForCharubintheFireKnight.Material2Name,
IncorrectPredictedFusionsForCharubintheFireKnight.Material2Type,
IncorrectPredictedFusionsForCharubintheFireKnight.Material2SecTypes,
IncorrectPredictedFusionsForCharubintheFireKnight.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForCharubintheFireKnight
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForCharubintheFireKnight.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForCharubintheFireKnight.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForCharubintheFireKnight AS
SELECT * FROM FusionsForCharubintheFireKnight
EXCEPT 
SELECT * FROM PredictedFusionsForCharubintheFireKnight;








