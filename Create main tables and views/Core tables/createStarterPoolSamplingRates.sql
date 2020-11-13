DROP TABLE IF EXISTS main.StarterPoolSamplingRates;
-- Create table StarterPoolSamplingRates and populate it
CREATE TABLE "StarterPoolSamplingRates" (
	"StarterPoolID"	INT,
	"CardID"	INT,
	"Prob"	INT,
	PRIMARY KEY("StarterPoolID","CardID"),
	FOREIGN KEY("StarterPoolID") REFERENCES StarterPools("StarterPoolID"),
	FOREIGN KEY("CardID") REFERENCES Cards("CardID")
);

INSERT INTO StarterPoolSamplingRates
SELECT PoolID AS StarterPoolID, CardID, Prob
FROM FmDatabase.StarterPools;