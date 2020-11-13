DROP TABLE IF EXISTS main.DuelistPoolSamplingRates;
-- Create table DuelistPoolSamplingRates and populate it
CREATE TABLE "DuelistPoolSamplingRates" (
	"DuelistID"	INT,
	"DuelistPoolTypeID"	INT,
	"CardID"	INT,
	"Prob"	INT,
	PRIMARY KEY("DuelistID","DuelistPoolTypeID","CardID"),
	FOREIGN KEY("DuelistID") REFERENCES "Duelists"("DuelistID"),
	FOREIGN KEY("DuelistPoolTypeID") REFERENCES "DuelistPoolTypes"("DuelistPoolTypeID"),
	FOREIGN KEY("CardID") REFERENCES "Cards"("CardID")
);

INSERT INTO DuelistPoolSamplingRates
SELECT *
FROM FmDatabase.DuelistPools;