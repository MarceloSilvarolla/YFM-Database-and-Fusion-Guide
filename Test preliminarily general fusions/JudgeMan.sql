-- Test Judge Man fusions
--[Warrior] + The Judgement Hand
--                           = Judge Man (2200/1700)
--                               < Flame Swordsman (1800/1600),
--                                 Vermillion Sparrow (1900/1500),
--                                 Sword Arm of Dragon (1750/2030),
--                                 Musician King (1750/1500)

DROP TABLE IF EXISTS PredictedFusionsForJudgeMan;
DROP TABLE IF EXISTS FusionsForJudgeMan;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForJudgeMan;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForJudgeManPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForJudgeMan;

-- Create table with predicted fusions resulting in Judge Man

CREATE TEMPORARY TABLE PredictedFusionsForJudgeMan AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Warrior' AND C2.CardName = 'The Judgement Hand' AND
  C1.Attack < 2200 AND C2.Attack < 2200);

INSERT INTO PredictedFusionsForJudgeMan
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForJudgeMan;

-- Create table with actual fusions for Judge Man

CREATE TEMPORARY TABLE FusionsForJudgeMan AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Judge Man';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForJudgeMan AS
SELECT * FROM PredictedFusionsForJudgeMan
EXCEPT 
SELECT * FROM FusionsForJudgeMan;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForJudgeManPlus AS
SELECT IncorrectPredictedFusionsForJudgeMan.Material1Name,
IncorrectPredictedFusionsForJudgeMan.Material1Type,
IncorrectPredictedFusionsForJudgeMan.Material1SecTypes,
IncorrectPredictedFusionsForJudgeMan.Material1Attack,
IncorrectPredictedFusionsForJudgeMan.Material2Name,
IncorrectPredictedFusionsForJudgeMan.Material2Type,
IncorrectPredictedFusionsForJudgeMan.Material2SecTypes,
IncorrectPredictedFusionsForJudgeMan.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForJudgeMan
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForJudgeMan.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForJudgeMan.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForJudgeMan AS
SELECT * FROM FusionsForJudgeMan
EXCEPT 
SELECT * FROM PredictedFusionsForJudgeMan;