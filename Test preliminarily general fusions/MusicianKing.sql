-- Test Musician King fusions
--[MusKingian] + Hibikime   = Musician King (1750/1500)
--[MusKingian] + Sonic Maid = Musician King (1750/1500)

DROP TABLE IF EXISTS PredictedFusionsForMusicianKing;
DROP TABLE IF EXISTS FusionsForMusicianKing;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMusicianKing;
DROP TABLE IF EXISTS IncorrectPredictedFusionsForMusicianKingPlus;
DROP TABLE IF EXISTS MissingPredictedFusionsForMusicianKing;

-- Create table with predicted fusions resulting in Musician King

CREATE TEMPORARY TABLE PredictedFusionsForMusicianKing AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack as Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack as Material2Attack
FROM Cards AS C1
JOIN Cards AS C2
WHERE 
  (C1.IsMusKingian = 1 AND C2.CardName IN ('Hibikime', 'Sonic Maid') AND
  C1.Attack < 1750 AND C2.Attack < 1750);

INSERT INTO PredictedFusionsForMusicianKing
SELECT Material2Name, Material2Type, Material2SecTypes, Material2Attack,
       Material1Name, Material1Type, Material1SecTypes, Material1Attack
FROM PredictedFusionsForMusicianKing;

-- Create table with actual fusions for Musician King

CREATE TEMPORARY TABLE FusionsForMusicianKing AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack
FROM FusionsPlus
WHERE ResultName = 'Musician King';

-- Compare predictions with actual Fusions
CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMusicianKing AS
SELECT * FROM PredictedFusionsForMusicianKing
EXCEPT 
SELECT * FROM FusionsForMusicianKing;

CREATE TEMPORARY TABLE IncorrectPredictedFusionsForMusicianKingPlus AS
SELECT IncorrectPredictedFusionsForMusicianKing.Material1Name,
IncorrectPredictedFusionsForMusicianKing.Material1Type,
IncorrectPredictedFusionsForMusicianKing.Material1SecTypes,
IncorrectPredictedFusionsForMusicianKing.Material1Attack,
IncorrectPredictedFusionsForMusicianKing.Material2Name,
IncorrectPredictedFusionsForMusicianKing.Material2Type,
IncorrectPredictedFusionsForMusicianKing.Material2SecTypes,
IncorrectPredictedFusionsForMusicianKing.Material2Attack,
FusionsPlus.ResultName, FusionsPlus.ResultType,
FusionsPlus.ResultSecTypes, FusionsPlus.ResultAttack
FROM IncorrectPredictedFusionsForMusicianKing
LEFT JOIN FusionsPlus
ON IncorrectPredictedFusionsForMusicianKing.Material1Name = FusionsPlus.Material1Name
AND IncorrectPredictedFusionsForMusicianKing.Material2Name = FusionsPlus.Material2Name;

CREATE TEMPORARY TABLE MissingPredictedFusionsForMusicianKing AS
SELECT * FROM FusionsForMusicianKing
EXCEPT 
SELECT * FROM PredictedFusionsForMusicianKing;