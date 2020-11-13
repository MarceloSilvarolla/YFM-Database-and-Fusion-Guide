-- Test Invader of the Throne fusions
--[FiendOrGS1Moon] + Protector of the Throne 
--                                  = Invader of the Throne (1350/1700)
--                                      < Charubin the Fire Knight (1100/800)
--                                        Dragon Statue (1100/900)
--                                        Zombie Warrior (1200/900)
--                                        D. Human (1300/1100)
--                                        Cyber Soldier (1500/1700)
--                                        Armored Zombie (1500/0)
--                                        Queen of Autumn Leaves (1800/1500)
--                                        Dark Witch (1800/1700)
--                                        Nekogal #2 (1900/2000)
--                                        Mystical Sand (2100/1700)

DROP TABLE IF EXISTS PredictedFusionsForInvaderoftheThrone;
DROP TABLE IF EXISTS FusionsForInvaderoftheThrone;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForInvaderoftheThrone;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForInvaderoftheThronePlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForInvaderoftheThrone;

-- Create table with predicted fusions resulting in Invader of the Throne

CREATE TEMPORARY TABLE PredictedFusionsForInvaderoftheThrone AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.CardType = 'Fiend' OR C1.GuardianStar1 = 'Moon') AND
  (C2.CardName = 'Protector of the Throne') AND
  (C1.Attack < 1350 AND C2.Attack < 1350);

INSERT INTO PredictedFusionsForInvaderoftheThrone
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForInvaderoftheThrone;

-- Create table with actual fusions for Invader of the Throne

CREATE TEMPORARY TABLE FusionsForInvaderoftheThrone AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Invader of the Throne';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForInvaderoftheThrone AS
SELECT * FROM PredictedFusionsForInvaderoftheThrone
EXCEPT 
SELECT * FROM FusionsForInvaderoftheThrone;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForInvaderoftheThronePlus AS
SELECT IncorrectPredictedFusionsForInvaderoftheThrone.Material1Name,
IncorrectPredictedFusionsForInvaderoftheThrone.Material1Type,
IncorrectPredictedFusionsForInvaderoftheThrone.Material1SecTypes,
IncorrectPredictedFusionsForInvaderoftheThrone.Material1Attack,
IncorrectPredictedFusionsForInvaderoftheThrone.Material2Name,
IncorrectPredictedFusionsForInvaderoftheThrone.Material2Type,
IncorrectPredictedFusionsForInvaderoftheThrone.Material2SecTypes,
IncorrectPredictedFusionsForInvaderoftheThrone.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForInvaderoftheThrone
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForInvaderoftheThrone.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForInvaderoftheThrone.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForInvaderoftheThrone AS
SELECT * FROM FusionsForInvaderoftheThrone
EXCEPT 
SELECT * FROM PredictedFusionsForInvaderoftheThrone;