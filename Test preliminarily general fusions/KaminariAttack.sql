-- Test Kaminari Attack fusions
--[Spellcaster] + Spike Seadra
--                           = Kaminari Attack (1900/1400)
--                               < Thousand Dragon (2400/2000)
--[Spellcaster] + [Thunder]  = The Immortal of Thunder (1500/1300)
--                           = Kaminari Attack (1900/1400)
--                               < Thousand Dragon (2400/2000)

DROP TABLE IF EXISTS PredictedFusionsForKaminariAttack;
DROP TABLE IF EXISTS FusionsForKaminariAttack;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKaminariAttack;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForKaminariAttackPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForKaminariAttack;

-- Create table with predicted fusions resulting in Kaminari Attack

CREATE TEMPORARY TABLE PredictedFusionsForKaminariAttack AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  C1.CardType = 'Spellcaster' AND 
  (C2.CardName = 'Spike Seadra' OR C2.CardType = 'Thunder') AND
  C1.Attack < 1900 AND C2.Attack < 1900 AND
  (C1.Attack >= 1500 OR C2.Attack >= 1500);


INSERT INTO PredictedFusionsForKaminariAttack
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForKaminariAttack;

-- Create table with actual fusions for Kaminari Attack

CREATE TEMPORARY TABLE FusionsForKaminariAttack AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Kaminari Attack';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKaminariAttack AS
SELECT * FROM PredictedFusionsForKaminariAttack
EXCEPT 
SELECT * FROM FusionsForKaminariAttack;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForKaminariAttackPlus AS
SELECT IncorrectPredictedFusionsForKaminariAttack.Material1Name,
IncorrectPredictedFusionsForKaminariAttack.Material1Type,
IncorrectPredictedFusionsForKaminariAttack.Material1SecTypes,
IncorrectPredictedFusionsForKaminariAttack.Material1Attack,
IncorrectPredictedFusionsForKaminariAttack.Material2Name,
IncorrectPredictedFusionsForKaminariAttack.Material2Type,
IncorrectPredictedFusionsForKaminariAttack.Material2SecTypes,
IncorrectPredictedFusionsForKaminariAttack.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForKaminariAttack
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForKaminariAttack.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForKaminariAttack.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForKaminariAttack AS
SELECT * FROM FusionsForKaminariAttack
EXCEPT 
SELECT * FROM PredictedFusionsForKaminariAttack;