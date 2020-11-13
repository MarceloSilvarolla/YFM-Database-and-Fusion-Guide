-- Test Winged Egg of New Life fusions
--[AngelWinged] + [Egg]     = Winged Egg of New Life (1400/1700)
--                              < Mystical Elf (800/2000),
--                                Tiger Axe (1300/1100),
--                                Celtic Guardian (1400/1200),
--                                Dark Witch (1800/1700),
--                                Dark Elf (2000/800)

DROP TABLE IF EXISTS PredictedFusionsForWingedEggofNewLife;
DROP TABLE IF EXISTS FusionsForWingedEggofNewLife;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForWingedEggofNewLife;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForWingedEggofNewLifePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForWingedEggofNewLife;

-- Create table with predicted fusions resulting in Winged Egg of New Life

CREATE TEMPORARY TABLE PredictedFusionsForWingedEggofNewLife AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsAngelWinged = 1 AND C2.IsEgg = 1 AND
  C1.Attack < 1400 AND C2.Attack < 1400);

INSERT INTO PredictedFusionsForWingedEggofNewLife
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForWingedEggofNewLife;

-- Create table with actual fusions for Winged Egg of New Life

CREATE TEMPORARY TABLE FusionsForWingedEggofNewLife AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Winged Egg of New Life';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForWingedEggofNewLife AS
SELECT * FROM PredictedFusionsForWingedEggofNewLife
EXCEPT 
SELECT * FROM FusionsForWingedEggofNewLife;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForWingedEggofNewLifePlus AS
SELECT IncorrectPredictedFusionsForWingedEggofNewLife.Material1Name,
IncorrectPredictedFusionsForWingedEggofNewLife.Material1Type,
IncorrectPredictedFusionsForWingedEggofNewLife.Material1SecTypes,
IncorrectPredictedFusionsForWingedEggofNewLife.Material1Attack,
IncorrectPredictedFusionsForWingedEggofNewLife.Material2Name,
IncorrectPredictedFusionsForWingedEggofNewLife.Material2Type,
IncorrectPredictedFusionsForWingedEggofNewLife.Material2SecTypes,
IncorrectPredictedFusionsForWingedEggofNewLife.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForWingedEggofNewLife
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForWingedEggofNewLife.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForWingedEggofNewLife.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForWingedEggofNewLife AS
SELECT * FROM FusionsForWingedEggofNewLife
EXCEPT 
SELECT * FROM PredictedFusionsForWingedEggofNewLife;