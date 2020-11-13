-- Test Fire Reaper fusions
--[Pyro] + [Zombie]         = Fire Reaper (700/500)
--                          = Flame Ghost (1000/800)
--                              < Wood Remains (1000/900),
--                                Zombie Warrior (1200/900),
--                                Stone Ghost (1200/1000),
--                                Magical Ghost (1300/1400),
--                                The Snake Hair (1500/1200)

DROP TABLE IF EXISTS PredictedFusionsForFireReaper;
DROP TABLE IF EXISTS FusionsForFireReaper;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFireReaper;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForFireReaperPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForFireReaper;

-- Create table with predicted fusions resulting in Fire Reaper

CREATE TEMPORARY TABLE PredictedFusionsForFireReaper AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsPyro = 1 AND C2.CardType = 'Zombie' AND
  C1.Attack < 700 AND C2.Attack < 700);

INSERT INTO PredictedFusionsForFireReaper
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForFireReaper;

-- Create table with actual fusions for Fire Reaper

CREATE TEMPORARY TABLE FusionsForFireReaper AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Fire Reaper';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFireReaper AS
SELECT * FROM PredictedFusionsForFireReaper
EXCEPT 
SELECT * FROM FusionsForFireReaper;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForFireReaperPlus AS
SELECT IncorrectPredictedFusionsForFireReaper.Material1Name,
IncorrectPredictedFusionsForFireReaper.Material1Type,
IncorrectPredictedFusionsForFireReaper.Material1SecTypes,
IncorrectPredictedFusionsForFireReaper.Material1Attack,
IncorrectPredictedFusionsForFireReaper.Material2Name,
IncorrectPredictedFusionsForFireReaper.Material2Type,
IncorrectPredictedFusionsForFireReaper.Material2SecTypes,
IncorrectPredictedFusionsForFireReaper.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForFireReaper
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForFireReaper.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForFireReaper.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForFireReaper AS
SELECT * FROM FusionsForFireReaper
EXCEPT 
SELECT * FROM PredictedFusionsForFireReaper;