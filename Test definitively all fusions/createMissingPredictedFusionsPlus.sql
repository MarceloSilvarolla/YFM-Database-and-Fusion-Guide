DROP TABLE IF EXISTS MissingPredictedFusions;
CREATE TEMPORARY TABLE MissingPredictedFusions AS
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
       Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   ResultName
FROM FusionsPlus
EXCEPT
SELECT *
FROM PredictedFusions;


DROP TABLE IF EXISTS MissingPredictedFusionsPlus;
CREATE TEMPORARY TABLE MissingPredictedFusionsPlus AS
SELECT MPF.Material1Name, MPF.Material1Type, MPF.Material1SecTypes, MPF.Material1Attack,
       MPF.Material2Name, MPF.Material2Type, MPF.Material2SecTypes, MPF.Material2Attack,
	   MPF.ResultName, PF.PredictedResult
FROM MissingPredictedFusions AS MPF
LEFT JOIN PredictedFusions AS PF
ON PF.Material1Name = MPF.Material1Name and PF.Material2Name = MPF.Material2Name;