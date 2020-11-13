DROP VIEW IF EXISTS FusionsPlus;
CREATE VIEW FusionsPlus AS
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
       C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
       Result.CardName AS ResultName, Result.CardType AS ResultType, Result.CardSecTypes AS ResultSecTypes, Result.Attack AS ResultAttack
FROM Fusions, Cards AS C1, Cards AS C2, Cards AS Result
WHERE Material1 = C1.CardID AND Material2 = C2.CardID AND Result = Result.CardID;