DROP TABLE IF EXISTS main.Duelists;
-- Create table Duelists and populate it
CREATE TABLE "Duelists" (
	"DuelistID"	INT,
	"DuelistName"	TEXT,
	"HandSize"	INT,
	"IsMage"	INT,
	PRIMARY KEY("DuelistID")
);

INSERT INTO Duelists
SELECT DuelistID, Name as DuelistName, HandSize, IsMage
FROM FmDatabase.Duelists;