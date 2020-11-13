DROP TABLE IF EXISTS main.Cards;
-- Create table Cards and then populate it
CREATE TABLE "Cards" (
	"CardID"	INT,
	"CardName"	TEXT,
	"Description"	TEXT,
	"GuardianStar1"	TEXT,
	"GuardianStar2"	TEXT,
	"Level"	INT,
	"CardType"	INT,
	"Attribute"	TEXT,
	"Attack"	INT,
	"Defense"	INT,
	"Password"	TEXT,
	"StarchipCost"	INT,
	"Droppability" INT,
	"Fusability" INT,
	"Startability" INT,
	"NumSort"	INT,
	"AbcSort"	INT,
	"MaxSort"	INT,
	"AtkSort"	INT,
	"DefSort"	INT,
	"TypSort"	INT,
	"AISort"	INT,
	PRIMARY KEY("CardId")
);

INSERT INTO Cards
SELECT CardID, CardName, Description, GuardianStar1, GuardianStar2,Level, Type AS CardType, Attribute,
  Attack, Defense, Password, StarchipCost, 0 AS Droppability, 0 AS Fusability, 0 AS Startability,
  NumSort, AbcSort, MaxSort, AtkSort, DefSort, TypSort, AISort
FROM FmDatabase.Cards
NATURAL JOIN FmDatabaseWithGS.CardInfo;
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
FROM FmDatabase.Duelists;DROP TABLE IF EXISTS main.DuelistPoolTypes;
-- Create table DuelistPoolTypes and populate it
CREATE TABLE "DuelistPoolTypes" (
	"DuelistPoolTypeID"	INT,
	"DuelistPoolType"	TEXT,
	PRIMARY KEY("DuelistPoolTypeID")
);

INSERT INTO DuelistPoolTypes
SELECT *
FROM FmDatabase.PoolTypes;DROP TABLE IF EXISTS main.DuelistPoolSamplingRates;
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
FROM FmDatabase.DuelistPools;DROP TABLE IF EXISTS main.StarterPools;
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
WHERE StarterPoolID = 7;DROP TABLE IF EXISTS main.StarterPoolSamplingRates;
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
FROM FmDatabase.StarterPools;DROP TABLE IF EXISTS main.Equipping;
-- Create table Equipping and populate it
CREATE TABLE "Equipping" (
	"EquipID"	INT,
	"EquippedID"	INT,
	PRIMARY KEY("EquipID","EquippedID"),
	FOREIGN KEY("EquipID") REFERENCES Cards("CardID"),
	FOREIGN KEY("EquippedID") REFERENCES Cards("CardID")
);

INSERT INTO Equipping
SELECT EquipID AS EquipID, CardID AS EquippedID
FROM FmDatabaseWithGS.EquipInfo;

DROP TABLE IF EXISTS main.Fusions;
-- Create table Fusions and populate it
CREATE TABLE "Fusions" (
	"Material1"	INT,
	"Material2"	INT,
	"Result"	TEXT,
	PRIMARY KEY("Material1","Material2"),
	FOREIGN KEY("Material1") REFERENCES Cards("CardID"),
	FOREIGN KEY("Material2") REFERENCES Cards("CardID"),
	FOREIGN KEY("Result") REFERENCES Cards("CardID")
);

INSERT INTO Fusions
SELECT Material_1 AS Material1, Material_2 AS Material2, Result as Result
FROM FmDatabaseWithGS.Fusions
UNION
SELECT Material_2 AS Material2, Material_1 AS Material1, Result as Result
FROM FmDatabaseWithGS.Fusions;

DROP TABLE IF EXISTS main.Rituals;
-- Create table Rituals and populate it
CREATE TABLE "Rituals" (
	"Tribute1"	INT,
	"Tribute2"	INT,
	"Tribute3"	INT,
	"RitualCard" INT,
	"Result"	INT,
	PRIMARY KEY("Tribute1","Tribute2","Tribute3"),
	FOREIGN KEY("Tribute1") REFERENCES Cards("CardID"),
	FOREIGN KEY("Tribute2") REFERENCES Cards("CardID"),
	FOREIGN KEY("Tribute3") REFERENCES Cards("CardID"),
	FOREIGN KEY("RitualCard") REFERENCES Cards("CardID"),
	FOREIGN KEY("Result") REFERENCES Cards("CardID")
);

INSERT INTO Rituals
SELECT Material_1 AS Tribute1, Material_2 AS Tribute2, Material_3 AS Tribute3, CardId AS RitualCard, Result AS Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_1, Material_3, Material_2, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_2, Material_1, Material_3, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_2, Material_3, Material_1, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_3, Material_1, Material_2, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo
UNION
SELECT Material_3, Material_2, Material_1, CardId AS RitualCard, Result
FROM FmDatabaseWithGS.RitualInfo;





DROP TABLE IF EXISTS GSBeats;

CREATE TABLE GSBeats (
   WinnerGS TEXT,
   LoserGS TEXT
);

INSERT INTO GSBeats
VALUES
   ('Mercury', 'Sun'),
   ('Sun', 'Moon'),
   ('Moon', 'Venus'),
   ('Venus', 'Mercury'),
   ('Mars', 'Jupiter'),
   ('Jupiter', 'Saturn'),
   ('Saturn', 'Uranus'),
   ('Uranus', 'Pluto'),
   ('Pluto', 'Neptune'),
   ('Neptune', 'Mars');