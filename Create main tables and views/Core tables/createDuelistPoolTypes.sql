DROP TABLE IF EXISTS main.DuelistPoolTypes;
-- Create table DuelistPoolTypes and populate it
CREATE TABLE "DuelistPoolTypes" (
	"DuelistPoolTypeID"	INT,
	"DuelistPoolType"	TEXT,
	PRIMARY KEY("DuelistPoolTypeID")
);

INSERT INTO DuelistPoolTypes
SELECT *
FROM FmDatabase.PoolTypes;