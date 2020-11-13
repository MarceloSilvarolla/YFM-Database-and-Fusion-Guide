DROP TABLE IF EXISTS main.StarterPools;
-- Create table StarterPools and populate it
CREATE TABLE "StarterPools" (
	"StarterPoolID"	INT,
	"SampleSize"	INT,
	"StarterPoolName" TEXT,
	PRIMARY KEY("StarterPoolID")
);

INSERT INTO StarterPools
SELECT PoolID as StarterPoolID, SampleSize, NULL AS StarterPoolName
FROM StarterGroups;

UPDATE StarterPools
SET StarterPoolName = "ATKplusDEFlt1100"
WHERE StarterPoolID = 1;

UPDATE StarterPools
SET StarterPoolName = "1100leqATKplusDEFlt1600"
WHERE StarterPoolID = 2;

UPDATE StarterPools
SET StarterPoolName = "1600leqATKplusDEFlt2100"
WHERE StarterPoolID = 3;

UPDATE StarterPools
SET StarterPoolName = "2100leqATKplusDEF"
WHERE StarterPoolID = 4;

UPDATE StarterPools
SET StarterPoolName = "PureMagic"
WHERE StarterPoolID = 5;

UPDATE StarterPools
SET StarterPoolName = "Field"
WHERE StarterPoolID = 6;

UPDATE StarterPools
SET StarterPoolName = "Equip"
WHERE StarterPoolID = 7;