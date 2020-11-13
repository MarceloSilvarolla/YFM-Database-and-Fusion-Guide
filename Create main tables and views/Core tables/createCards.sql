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
