DROP TABLE IF EXISTS main.Equipping;
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





