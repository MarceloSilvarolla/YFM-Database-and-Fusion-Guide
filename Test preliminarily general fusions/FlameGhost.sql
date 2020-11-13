-- Test Flame Ghost fusions
--[Pyro] + [Zombie]         = Fire Reaper (700/500)
--                          = Flame Ghost (1000/800)
--                              < Wood Remains (1000/900),
--                                Zombie Warrior (1200/900),
--                                Stone Ghost (1200/1000),
--                                Magical Ghost (1300/1400),
--                                The Snake Hair (1500/1200)

DROP TABLE IF EXISTS PredictedFusionsForFlameGhost;
DROP TABLE IF EXISTS FusionsForFlameGhost;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFlameGhost;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFlameGhostPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForFlameGhost;

-- Create table with predicted fusions resulting in Flame Ghost

CREATE TEMPORARY TABLE PredictedFusionsForFlameGhost AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.CardType = 'Zombie' AND
  C1.Attack < 1000 AND C2.Attack < 1000) AND
  (C1.Attack >= 700 OR C2.Attack >= 700);

INSERT INTO PredictedFusionsForFlameGhost
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForFlameGhost;

-- Create table with actual fusions for Flame Ghost

CREATE TEMPORARY TABLE FusionsForFlameGhost AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Flame Ghost';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFlameGhost AS
SELECT * FROM PredictedFusionsForFlameGhost
EXCEPT 
SELECT * FROM FusionsForFlameGhost;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFlameGhostPlus AS
SELECT IncorrectPredictedFusionsForFlameGhost.Material1Name,
IncorrectPredictedFusionsForFlameGhost.Material1Type,
IncorrectPredictedFusionsForFlameGhost.Material1SecTypes,
IncorrectPredictedFusionsForFlameGhost.Material1Attack,
IncorrectPredictedFusionsForFlameGhost.Material2Name,
IncorrectPredictedFusionsForFlameGhost.Material2Type,
IncorrectPredictedFusionsForFlameGhost.Material2SecTypes,
IncorrectPredictedFusionsForFlameGhost.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForFlameGhost
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForFlameGhost.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForFlameGhost.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForFlameGhost AS
SELECT * FROM FusionsForFlameGhost
EXCEPT 
SELECT * FROM PredictedFusionsForFlameGhost;