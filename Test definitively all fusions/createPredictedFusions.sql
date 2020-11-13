DROP TABLE IF EXISTS PredictedFusions;
CREATE TEMPORARY TABLE PredictedFusions (
	Material1Name TEXT,
	Material1Type TEXT,
	Material1SecTypes TEXT,
	Material1Attack INT,
	Material2Name TEXT,
	Material2Type TEXT,
	Material2SecTypes TEXT,
	Material2Attack INT,
	PredictedResult TEXT
);
INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Ancient Elf" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1450 AND C2.Attack < 1450 ) AND (((C1.CardName = "Magician of Faith") AND (C2.CardName = "Metalmorph")) OR ((C2.CardName = "Magician of Faith") AND (C1.CardName = "Metalmorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Turtle Bird" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1900 AND C2.Attack < 1900 ) AND (((C1.IsTurtle = 1) AND (C2.CardType = 'Winged Beast')) OR ((C2.IsTurtle = 1) AND (C1.CardType = 'Winged Beast'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dark Elf" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2000 AND C2.Attack < 2000 ) AND (((C1.IsMercuryMagicUser = 1) AND (C2.IsElf = 1)) OR ((C2.IsMercuryMagicUser = 1) AND (C1.IsElf = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Trakadon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 ) AND (((C1.CardName = "Petit Dragon") AND (C2.CardName = "Serpent Marauder")) OR ((C2.CardName = "Petit Dragon") AND (C1.CardName = "Serpent Marauder"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "The Wicked Worm Beast" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardName = "Ancient Jar") AND (C2.CardName = "Mystery Hand")) OR ((C2.CardName = "Ancient Jar") AND (C1.CardName = "Mystery Hand"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Hinotama" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Sparks") AND (C2.CardName = "Sparks")) OR ((C2.CardName = "Sparks") AND (C1.CardName = "Sparks"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Nekogal #2" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1900 AND C2.Attack < 1900 ) AND (((C1.IsUsableBeast = 1) AND (C2.IsFemale = 1)) OR ((C2.IsUsableBeast = 1) AND (C1.IsFemale = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Ryu-kishin Powered" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1600 AND C2.Attack < 1600 ) AND (((C1.IsMercurySpellcaster = 1) AND (C2.CardName = "Ryu-kishin")) OR ((C2.IsMercurySpellcaster = 1) AND (C1.CardName = "Ryu-kishin"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Axe of Despair" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Bear Trap") AND (C2.CardName = "Tiger Axe")) OR ((C2.CardName = "Bear Trap") AND (C1.CardName = "Tiger Axe"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Elegant Egotist" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Electro-whip") AND (C2.CardName = "Job-change Mirror")) OR ((C2.CardName = "Electro-whip") AND (C1.CardName = "Job-change Mirror"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Electro-whip") AND (C2.CardName = "Wicked Mirror")) OR ((C2.CardName = "Electro-whip") AND (C1.CardName = "Wicked Mirror"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Electro-whip") AND (C2.CardName = "Fiend's Mirror")) OR ((C2.CardName = "Electro-whip") AND (C1.CardName = "Fiend's Mirror"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Pumpking the King of Ghosts" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 AND (C1.Attack >= 1000 OR C2.Attack >= 1000) ) AND (((C1.CardType = 'Plant') AND (C2.CardType = 'Zombie')) OR ((C2.CardType = 'Plant') AND (C1.CardType = 'Zombie'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Yamadron Ritual" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dragon Treasure") AND (C2.CardName = "Elegant Egotist")) OR ((C2.CardName = "Dragon Treasure") AND (C1.CardName = "Elegant Egotist"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Electro-whip" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Beautiful Beast Trainer") AND (C2.CardName = "Warrior Elimination")) OR ((C2.CardName = "Beautiful Beast Trainer") AND (C1.CardName = "Warrior Elimination"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Monster Tamer") AND (C2.CardName = "Warrior Elimination")) OR ((C2.CardName = "Monster Tamer") AND (C1.CardName = "Warrior Elimination"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Megamorph" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dian Keto the Cure Master") AND (C2.CardName = "Dian Keto the Cure Master")) OR ((C2.CardName = "Dian Keto the Cure Master") AND (C1.CardName = "Dian Keto the Cure Master"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Javelin Beetle Pact" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Forest") AND (C2.CardName = "Power of Kaishin")) OR ((C2.CardName = "Forest") AND (C1.CardName = "Power of Kaishin"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Forest" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Megamorph") AND (C2.CardName = "Vile Germs")) OR ((C2.CardName = "Megamorph") AND (C1.CardName = "Vile Germs"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Laser Cannon Armor" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Machine Conversion Factory") AND (C2.CardName = "Violet Crystal")) OR ((C2.CardName = "Machine Conversion Factory") AND (C1.CardName = "Violet Crystal"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Thunder Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1600 AND C2.Attack < 1600 ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Thunder')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Thunder'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Book of Secret Arts" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Boo Koo") AND (C2.CardName = "Dark-piercing Light")) OR ((C2.CardName = "Boo Koo") AND (C1.CardName = "Dark-piercing Light"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Machine Conversion Factory" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "House of Adhesive Tape") AND (C2.CardName = "Metalmorph")) OR ((C2.CardName = "House of Adhesive Tape") AND (C1.CardName = "Metalmorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Breath of Light" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Bad Reaction to Simochi") AND (C2.CardName = "Goblin Fan")) OR ((C2.CardName = "Bad Reaction to Simochi") AND (C1.CardName = "Goblin Fan"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Follow Wind") AND (C2.CardName = "Wasteland")) OR ((C2.CardName = "Follow Wind") AND (C1.CardName = "Wasteland"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Meteor B. Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 3500 AND C2.Attack < 3500 ) AND (((C1.CardName = "Meteor Dragon") AND (C2.CardName = "Red-eyes B. Dragon")) OR ((C2.CardName = "Meteor Dragon") AND (C1.CardName = "Red-eyes B. Dragon"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Curse of Millennium Shield" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Metalmorph") AND (C2.CardName = "Metalmorph")) OR ((C2.CardName = "Metalmorph") AND (C1.CardName = "Metalmorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Curse of Tri-Horned Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Horn of Light")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Horn of Light"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Horn of the Unicorn")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Horn of the Unicorn"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "30,000-Year White Turtle" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1250 AND C2.Attack < 1250 ) AND (((C1.CardType = 'Spellcaster') AND (C2.IsTurtle = 1)) OR ((C2.CardType = 'Spellcaster') AND (C1.IsTurtle = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dragon Zombie" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1600 AND C2.Attack < 1600 ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Zombie')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Zombie'))))
OR ((C2.Attack >= 0) AND (((C1.CardName = "Crawling Dragon") AND (C2.CardName = "Dragon Capture Jar")) OR ((C2.CardName = "Crawling Dragon") AND (C1.CardName = "Dragon Capture Jar"))))
OR (( C1.Attack < 1600 AND C2.Attack < 1600 ) AND (((C1.CardName = "Twin Long Rods #2") AND (C2.CardName = "Graveyard and the Hand of Invitation")) OR ((C2.CardName = "Twin Long Rods #2") AND (C1.CardName = "Graveyard and the Hand of Invitation"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Zera Ritual" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dark Energy") AND (C2.CardName = "Malevolent Nuzzler")) OR ((C2.CardName = "Dark Energy") AND (C1.CardName = "Malevolent Nuzzler"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Eternal Draught" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dark Hole") AND (C2.CardName = "Umi")) OR ((C2.CardName = "Dark Hole") AND (C1.CardName = "Umi"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Mystical Moon") AND (C2.CardName = "Umi")) OR ((C2.CardName = "Mystical Moon") AND (C1.CardName = "Umi"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Tremendous Fire") AND (C2.CardName = "Umi")) OR ((C2.CardName = "Tremendous Fire") AND (C1.CardName = "Umi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Revival of Sennen Genjin" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Curse of Millennium Shield") AND (C2.CardName = "Puppet Ritual")) OR ((C2.CardName = "Curse of Millennium Shield") AND (C1.CardName = "Puppet Ritual"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Mystical Moon")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Mystical Moon"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Gaia the Dragon Champion" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2600 AND C2.Attack < 2600 ) AND (((C1.CardName = "Curse of Dragon") AND (C2.CardName = "Gaia the Fierce Knight")) OR ((C2.CardName = "Curse of Dragon") AND (C1.CardName = "Gaia the Fierce Knight"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Metalmorph" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Electro-whip") AND (C2.CardName = "Metal Guardian")) OR ((C2.CardName = "Electro-whip") AND (C1.CardName = "Metal Guardian"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Machine Conversion Factory") AND (C2.CardName = "Metal Guardian")) OR ((C2.CardName = "Machine Conversion Factory") AND (C1.CardName = "Metal Guardian"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "The Snake Hair" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 ) AND (((C1.CardType = 'Zombie') AND (C2.CardName = "Graveyard and the Hand of Invitation")) OR ((C2.CardType = 'Zombie') AND (C1.CardName = "Graveyard and the Hand of Invitation"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "The 13th Grave" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C2.Attack >= 0) AND (((C1.CardName = "Clown Zombie") AND (C2.CardName = "Kojikocy")) OR ((C2.CardName = "Clown Zombie") AND (C1.CardName = "Kojikocy"))))
OR ((C2.Attack >= 0) AND (((C1.CardName = "Dream Clown") AND (C2.CardName = "Mysterious Puppeteer")) OR ((C2.CardName = "Dream Clown") AND (C1.CardName = "Mysterious Puppeteer"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "B. Skull Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 3200 AND C2.Attack < 3200 ) AND (((C1.CardName = "Red-eyes B. Dragon") AND (C2.CardName = "Summoned Skull")) OR ((C2.CardName = "Red-eyes B. Dragon") AND (C1.CardName = "Summoned Skull"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Snakeyashi" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1000 AND C2.Attack < 1000 ) AND (((C1.CardType = 'Plant') AND (C2.CardType = 'Reptile')) OR ((C2.CardType = 'Plant') AND (C1.CardType = 'Reptile'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Hyosube" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 ) AND (((C1.CardType = 'Aqua') AND (C2.CardName = "Kappa Avenger" OR C2.CardName = "Psychic Kappa")) OR ((C2.CardType = 'Aqua') AND (C1.CardName = "Kappa Avenger" OR C1.CardName = "Psychic Kappa"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Skelgon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1700 AND C2.Attack < 1700 AND (C1.Attack >= 1600 OR C2.Attack >= 1600) ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Zombie')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Zombie'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Kunai with Chain" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Legendary Sword") AND (C2.CardName = "Sword of Dark Destruction")) OR ((C2.CardName = "Legendary Sword") AND (C1.CardName = "Sword of Dark Destruction"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Yamadron" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1600 AND C2.Attack < 1600 ) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Wicked Dragon with the Ersatz Head")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Wicked Dragon with the Ersatz Head"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Thousand Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2400 AND C2.Attack < 2400 ) AND (((C1.IsDragon = 1) AND (C2.CardName = "Time Wizard")) OR ((C2.IsDragon = 1) AND (C1.CardName = "Time Wizard"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Invisible Wire" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Black Pendant") AND (C2.CardName = "Yami")) OR ((C2.CardName = "Black Pendant") AND (C1.CardName = "Yami"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Clown Zombie" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C2.Attack >= 0) AND (((C1.CardName = "Crass Clown") AND (C2.CardName = "Final Flame")) OR ((C2.CardName = "Crass Clown") AND (C1.CardName = "Final Flame"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Whiptail Crow" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1650 AND C2.Attack < 1650 ) AND (((C1.CardType = 'Winged Beast') AND (C2.CardName = "Ryu-kishin")) OR ((C2.CardType = 'Winged Beast') AND (C1.CardName = "Ryu-kishin"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Goblin's Secret Remedy" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Red Medicine") AND (C2.CardName = "Red Medicine")) OR ((C2.CardName = "Red Medicine") AND (C1.CardName = "Red Medicine"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Metalzoa" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 3000 AND C2.Attack < 3000 ) AND (((C1.CardName = "Metalmorph") AND (C2.CardName = "Zoa")) OR ((C2.CardName = "Metalmorph") AND (C1.CardName = "Zoa"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Puppet Ritual" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Metalmorph") AND (C2.CardName = "Stain Storm")) OR ((C2.CardName = "Metalmorph") AND (C1.CardName = "Stain Storm"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Vile Germs" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Crush Card") AND (C2.CardName = "Forest")) OR ((C2.CardName = "Crush Card") AND (C1.CardName = "Forest"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Kuriboh")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Kuriboh"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Queen of Autumn Leaves" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.IsFemale = 1) AND (C2.CardType = 'Plant')) OR ((C2.IsFemale = 1) AND (C1.CardType = 'Plant'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Black Pendant" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dark Energy") AND (C2.CardName = "Machine Conversion Factory")) OR ((C2.CardName = "Dark Energy") AND (C1.CardName = "Machine Conversion Factory"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Stone Ghost" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 ) AND (((C1.CardType = 'Rock') AND (C2.CardType = 'Zombie')) OR ((C2.CardType = 'Rock') AND (C1.CardType = 'Zombie'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Baby Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C2.Attack >= 0) AND (((C1.CardName = "Battle Ox") AND (C2.CardName = "Dragon Statue")) OR ((C2.CardName = "Battle Ox") AND (C1.CardName = "Dragon Statue"))))
OR ((C2.Attack >= 0) AND (((C1.CardName = "Dragon Piper") AND (C2.CardName = "Orion the Battle King")) OR ((C2.CardName = "Dragon Piper") AND (C1.CardName = "Orion the Battle King"))))
OR ((C2.Attack >= 0) AND (((C1.CardName = "Monster Egg") AND (C2.CardName = "The Wicked Worm Beast")) OR ((C2.CardName = "Monster Egg") AND (C1.CardName = "The Wicked Worm Beast"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Cosmo Queen's Prayer" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Cyber Shield") AND (C2.CardName = "Malevolent Nuzzler")) OR ((C2.CardName = "Cyber Shield") AND (C1.CardName = "Malevolent Nuzzler"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Eatgaboon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Beast Fangs") AND (C2.CardName = "Beast Fangs")) OR ((C2.CardName = "Beast Fangs") AND (C1.CardName = "Beast Fangs"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Fire Reaper" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 700 AND C2.Attack < 700 ) AND (((C1.IsPyro = 1) AND (C2.CardType = 'Zombie')) OR ((C2.IsPyro = 1) AND (C1.CardType = 'Zombie'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Final Flame" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Hinotama") AND (C2.CardName = "Hinotama")) OR ((C2.CardName = "Hinotama") AND (C1.CardName = "Hinotama"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Kappa Avenger" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 ) AND (((C1.CardType = 'Fiend') AND (C2.CardName = "Psychic Kappa")) OR ((C2.CardType = 'Fiend') AND (C1.CardName = "Psychic Kappa"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Spike Seadra" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1600 AND C2.Attack < 1600 ) AND (((C1.CardType = 'Aqua') AND (C2.IsDragon = 1)) OR ((C2.CardType = 'Aqua') AND (C1.IsDragon = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Great Mammoth of Goldfine" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2200 AND C2.Attack < 2200 ) AND (((C1.CardType = 'Zombie') AND (C2.CardName = "Mammoth Graveyard")) OR ((C2.CardType = 'Zombie') AND (C1.CardName = "Mammoth Graveyard"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Fortress Whale's Oath" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Machine Conversion Factory") AND (C2.CardName = "Umi")) OR ((C2.CardName = "Machine Conversion Factory") AND (C1.CardName = "Umi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Horn of the Unicorn" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Raise Body Heat") AND (C2.CardName = "Reverse Trap")) OR ((C2.CardName = "Raise Body Heat") AND (C1.CardName = "Reverse Trap"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Rare Fish" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 AND (C1.Attack >= 1350 OR C2.Attack >= 1350) ) AND (((C1.CardType = 'Beast') AND (C2.CardType = 'Fish')) OR ((C2.CardType = 'Beast') AND (C1.CardType = 'Fish'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Big Eye" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 ) AND (((C1.CardName = "House of Adhesive Tape") AND (C2.CardName = "Monster Eye")) OR ((C2.CardName = "House of Adhesive Tape") AND (C1.CardName = "Monster Eye"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Cyber Saurus" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.CardType = 'Dinosaur') AND (C2.CardType = 'Machine')) OR ((C2.CardType = 'Dinosaur') AND (C1.CardType = 'Machine'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Beastry Mirror Ritual" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dark Energy") AND (C2.CardName = "Elegant Egotist")) OR ((C2.CardName = "Dark Energy") AND (C1.CardName = "Elegant Egotist"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Wasteland" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Forest") AND (C2.CardName = "Ookazi")) OR ((C2.CardName = "Forest") AND (C1.CardName = "Ookazi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Insect Armor with Laser Cannon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Machine Conversion Factory") AND (C2.CardName = "Hinotama")) OR ((C2.CardName = "Machine Conversion Factory") AND (C1.CardName = "Hinotama"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Mavelus" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 ) AND (((C1.IsPyro = 1) AND (C2.CardType = 'Winged Beast')) OR ((C2.IsPyro = 1) AND (C1.CardType = 'Winged Beast'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Power of Kaishin" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Breath of Light") AND (C2.CardName = "Umi")) OR ((C2.CardName = "Breath of Light") AND (C1.CardName = "Umi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Tripwire Beast" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 ) AND (((C1.CardType = 'Beast') AND (C2.CardType = 'Thunder')) OR ((C2.CardType = 'Beast') AND (C1.CardType = 'Thunder'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Wow Warrior" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1250 AND C2.Attack < 1250 ) AND (((C1.CardType = 'Fish') AND (C2.CardType = 'Warrior')) OR ((C2.CardType = 'Fish') AND (C1.CardType = 'Warrior'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Widespread Ruin" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dragon Capture Jar") AND (C2.CardName = "Tremendous Fire")) OR ((C2.CardName = "Dragon Capture Jar") AND (C1.CardName = "Tremendous Fire"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Water Magician" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardName = "Aqua Snake") AND (C2.CardName = "Waterdragon Fairy")) OR ((C2.CardName = "Aqua Snake") AND (C1.CardName = "Waterdragon Fairy"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Stain Storm" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Acid Trap Hole") AND (C2.CardName = "Follow Wind")) OR ((C2.CardName = "Acid Trap Hole") AND (C1.CardName = "Follow Wind"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Electro-whip") AND (C2.CardName = "Umi")) OR ((C2.CardName = "Electro-whip") AND (C1.CardName = "Umi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Musician King" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1750 AND C2.Attack < 1750 ) AND (((C1.IsMusKingian = 1) AND (C2.CardName = "Hibikime" OR C2.CardName = "Sonic Maid")) OR ((C2.IsMusKingian = 1) AND (C1.CardName = "Hibikime" OR C1.CardName = "Sonic Maid"))))
OR (( C1.Attack < 1750 AND C2.Attack < 1750 ) AND (((C1.CardName = "Celtic Guardian") AND (C2.CardName = "Sonic Maid")) OR ((C2.CardName = "Celtic Guardian") AND (C1.CardName = "Sonic Maid"))))
OR (( C1.Attack < 1750 AND C2.Attack < 1750 ) AND (((C1.CardName = "Ancient Elf") AND (C2.CardName = "Sonic Maid")) OR ((C2.CardName = "Ancient Elf") AND (C1.CardName = "Sonic Maid"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Mystical Sheep #1" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1150 AND C2.Attack < 1150 ) AND (((C1.IsSheepian = 1) AND (C2.CardName = "Mystical Sheep #2")) OR ((C2.IsSheepian = 1) AND (C1.CardName = "Mystical Sheep #2"))))
OR (( C1.Attack < 1150 AND C2.Attack < 1150 ) AND (((C1.CardName = "Blue-eyed Silver Zombie") AND (C2.CardName = "Mystical Sheep #2")) OR ((C2.CardName = "Blue-eyed Silver Zombie") AND (C1.CardName = "Mystical Sheep #2"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Electric Lizard" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 850 AND C2.Attack < 850 ) AND (((C1.CardType = 'Reptile') AND (C2.CardType = 'Thunder')) OR ((C2.CardType = 'Reptile') AND (C1.CardType = 'Thunder'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Legendary Sword" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Flame Swordsman") AND (C2.CardName = "Umi")) OR ((C2.CardName = "Flame Swordsman") AND (C1.CardName = "Umi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Harpie's Pet Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2000 AND C2.Attack < 2000 ) AND (((C1.IsDragon = 1) AND (C2.CardName = "Harpie Lady")) OR ((C2.IsDragon = 1) AND (C1.CardName = "Harpie Lady"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Wood Remains" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1000 AND C2.Attack < 1000 ) AND (((C1.CardType = 'Plant') AND (C2.CardType = 'Zombie')) OR ((C2.CardType = 'Plant') AND (C1.CardType = 'Zombie'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Invader of the Throne" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1350 AND C2.Attack < 1350 ) AND (((C1.IsThronian = 1) AND (C2.CardName = "Protector of the Throne")) OR ((C2.IsThronian = 1) AND (C1.CardName = "Protector of the Throne"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Harpie's Feather Duster" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.IsFeatherFromBear = 1) AND (C2.CardName = "Bear Trap")) OR ((C2.IsFeatherFromBear = 1) AND (C1.CardName = "Bear Trap"))))
OR ((C1.Attack >= 0) AND (((C1.IsFeatherFromMachine = 1) AND (C2.CardName = "Machine Conversion Factory")) OR ((C2.IsFeatherFromMachine = 1) AND (C1.CardName = "Machine Conversion Factory"))))
OR ((C1.Attack >= 0) AND (((C1.IsFeatherFromHarpie = 1) AND (C2.CardName = "Harpie Lady" OR C2.CardName = "Harpie Lady Sisters")) OR ((C2.IsFeatherFromHarpie = 1) AND (C1.CardName = "Harpie Lady" OR C1.CardName = "Harpie Lady Sisters"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Flying Penguin") AND (C2.CardName = "Invisible Wire")) OR ((C2.CardName = "Flying Penguin") AND (C1.CardName = "Invisible Wire"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Bear Trap" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Beast Fangs") AND (C2.CardName = "Megamorph")) OR ((C2.CardName = "Beast Fangs") AND (C1.CardName = "Megamorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Elf's Light" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Ancient Elf") AND (C2.CardName = "House of Adhesive Tape")) OR ((C2.CardName = "Ancient Elf") AND (C1.CardName = "House of Adhesive Tape"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Monster Tamer" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.CardName = "Beautiful Beast Trainer") AND (C2.CardName = "Mooyan Curry")) OR ((C2.CardName = "Beautiful Beast Trainer") AND (C1.CardName = "Mooyan Curry"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Shadow Spell" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Spellbinding Circle") AND (C2.CardName = "Spellbinding Circle")) OR ((C2.CardName = "Spellbinding Circle") AND (C1.CardName = "Spellbinding Circle"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dark Energy" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Yami") AND (C2.CardName = "Yami")) OR ((C2.CardName = "Yami") AND (C1.CardName = "Yami"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Kwagar Hercules" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1900 AND C2.Attack < 1900 ) AND (((C1.CardType = 'Insect') AND (C2.CardName = "Kuwagata a")) OR ((C2.CardType = 'Insect') AND (C1.CardName = "Kuwagata a"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Acid Trap Hole" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dark Hole") AND (C2.CardName = "Stain Storm")) OR ((C2.CardName = "Dark Hole") AND (C1.CardName = "Stain Storm"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Revival of Skeleton Rider" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Machine Conversion Factory") AND (C2.CardName = "Wasteland")) OR ((C2.CardName = "Machine Conversion Factory") AND (C1.CardName = "Wasteland"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Beautiful Beast Trainer" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C2.Attack >= 0) AND (((C1.CardName = "Cyber Shield") AND (C2.CardName = "Monster Tamer")) OR ((C2.CardName = "Cyber Shield") AND (C1.CardName = "Monster Tamer"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Tainted Wisdom" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1250 AND C2.Attack < 1250 ) AND (((C1.CardName = "Ancient Brain") AND (C2.CardName = "Invisible Wire")) OR ((C2.CardName = "Ancient Brain") AND (C1.CardName = "Invisible Wire"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Swords of Revealing Light" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dark-piercing Light") AND (C2.CardName = "Shadow Spell")) OR ((C2.CardName = "Dark-piercing Light") AND (C1.CardName = "Shadow Spell"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Commencement Dance" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Cyber Shield") AND (C2.CardName = "Winged Trumpeter")) OR ((C2.CardName = "Cyber Shield") AND (C1.CardName = "Winged Trumpeter"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Misairuzame" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardType = 'Fish') AND (C2.CardType = 'Machine')) OR ((C2.CardType = 'Fish') AND (C1.CardType = 'Machine'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Ultimate Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dragon Treasure") AND (C2.CardName = "Megamorph")) OR ((C2.CardName = "Dragon Treasure") AND (C1.CardName = "Megamorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dragon Statue" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1100 AND C2.Attack < 1100 ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Warrior'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Novox's Prayer" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Eternal Rest") AND (C2.CardName = "Kunai with Chain")) OR ((C2.CardName = "Eternal Rest") AND (C1.CardName = "Kunai with Chain"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Amphibious Bugroth" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1850 AND C2.Attack < 1850 ) AND (((C1.IsBugrothian = 1) AND (C2.CardName = "Ground Attacker Bugroth")) OR ((C2.IsBugrothian = 1) AND (C1.CardName = "Ground Attacker Bugroth"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Fake Trap" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Cursebreaker") AND (C2.CardName = "Spellbinding Circle")) OR ((C2.CardName = "Cursebreaker") AND (C1.CardName = "Spellbinding Circle"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Reverse Trap") AND (C2.CardName = "Widespread Ruin")) OR ((C2.CardName = "Reverse Trap") AND (C1.CardName = "Widespread Ruin"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Bright Castle" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Castle of Dark Illusions") AND (C2.CardName = "Dark-piercing Light")) OR ((C2.CardName = "Castle of Dark Illusions") AND (C1.CardName = "Dark-piercing Light"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Reaper of the Cards" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C2.Attack >= 0) AND (((C1.CardName = "Koumori Dragon") AND (C2.CardName = "Saggi the Dark Clown")) OR ((C2.CardName = "Koumori Dragon") AND (C1.CardName = "Saggi the Dark Clown"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "House of Adhesive Tape" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Eradicating Aerosol") AND (C2.CardName = "Magical Labyrinth")) OR ((C2.CardName = "Eradicating Aerosol") AND (C1.CardName = "Magical Labyrinth"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Cocoon of Evolution" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Akihiron") AND (C2.CardName = "Giant Soldier of Stone")) OR ((C2.CardName = "Akihiron") AND (C1.CardName = "Giant Soldier of Stone"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Ansatsu") AND (C2.CardName = "LaMoon")) OR ((C2.CardName = "Ansatsu") AND (C1.CardName = "LaMoon"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Darkfire Dragon") AND (C2.CardName = "Tiger Axe")) OR ((C2.CardName = "Darkfire Dragon") AND (C1.CardName = "Tiger Axe"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Koumori Dragon") AND (C2.CardName = "Summoned Skull")) OR ((C2.CardName = "Koumori Dragon") AND (C1.CardName = "Summoned Skull"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Enchanting Mermaid" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 AND (C1.Attack >= 1150 OR C2.Attack >= 1150) ) AND (((C1.IsFemale = 1) AND (C2.CardType = 'Fish')) OR ((C2.IsFemale = 1) AND (C1.CardType = 'Fish'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Soul of the Pure" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Goblin's Secret Remedy") AND (C2.CardName = "Goblin's Secret Remedy")) OR ((C2.CardName = "Goblin's Secret Remedy") AND (C1.CardName = "Goblin's Secret Remedy"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Winged Trumpeter") AND (C2.CardName = "Winged Trumpeter")) OR ((C2.CardName = "Winged Trumpeter") AND (C1.CardName = "Winged Trumpeter"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Black Luster Ritual" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dark Energy") AND (C2.CardName = "Dark-piercing Light")) OR ((C2.CardName = "Dark Energy") AND (C1.CardName = "Dark-piercing Light"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Salamandra" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Legendary Sword") AND (C2.CardName = "Sparks")) OR ((C2.CardName = "Legendary Sword") AND (C1.CardName = "Sparks"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Cockroach Knight" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 800 AND C2.Attack < 800 ) AND (((C1.CardType = 'Insect') AND (C2.CardType = 'Warrior')) OR ((C2.CardType = 'Insect') AND (C1.CardType = 'Warrior'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Battle Warrior" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 700 AND C2.Attack < 700 ) AND (((C1.CardName = "Key Mace") AND (C2.CardName = "Shadow Specter")) OR ((C2.CardName = "Key Mace") AND (C1.CardName = "Shadow Specter"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Red-eyes B. Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2400 AND C2.Attack < 2400 ) AND (((C1.CardName = "B. Dragon Jungle King") AND (C2.CardName = "Tyhone #2")) OR ((C2.CardName = "B. Dragon Jungle King") AND (C1.CardName = "Tyhone #2"))))
OR (( C1.Attack < 2400 AND C2.Attack < 2400 ) AND (((C1.CardName = "Blackland Fire Dragon") AND (C2.CardName = "Tyhone #2")) OR ((C2.CardName = "Blackland Fire Dragon") AND (C1.CardName = "Tyhone #2"))))
OR (( C1.Attack < 2400 AND C2.Attack < 2400 ) AND (((C1.CardName = "Darkfire Dragon") AND (C2.CardName = "Tyhone #2")) OR ((C2.CardName = "Darkfire Dragon") AND (C1.CardName = "Tyhone #2"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Goblin Fan" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Breath of Light") AND (C2.CardName = "Follow Wind")) OR ((C2.CardName = "Breath of Light") AND (C1.CardName = "Follow Wind"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Steel Shell" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Final Flame") AND (C2.CardName = "Monsturtle")) OR ((C2.CardName = "Final Flame") AND (C1.CardName = "Monsturtle"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Mon Larvas" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 ) AND (((C1.CardType = 'Beast') AND (C2.CardName = "Larvas")) OR ((C2.CardType = 'Beast') AND (C1.CardName = "Larvas"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dark Hole" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Acid Trap Hole") AND (C2.CardName = "Dark Energy")) OR ((C2.CardName = "Acid Trap Hole") AND (C1.CardName = "Dark Energy"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Stop Defense" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Millennium Shield") AND (C2.CardName = "Reverse Trap")) OR ((C2.CardName = "Millennium Shield") AND (C1.CardName = "Reverse Trap"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Contruct of Mask" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Elf's Light") AND (C2.CardName = "Malevolent Nuzzler")) OR ((C2.CardName = "Elf's Light") AND (C1.CardName = "Malevolent Nuzzler"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "The Immortal of Thunder" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 ) AND (((C1.CardType = 'Spellcaster') AND (C2.CardType = 'Thunder')) OR ((C2.CardType = 'Spellcaster') AND (C1.CardType = 'Thunder'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Tremendous Fire" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Ookazi") AND (C2.CardName = "Ookazi")) OR ((C2.CardName = "Ookazi") AND (C1.CardName = "Ookazi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Bolt Escargot" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardType = 'Aqua') AND (C2.CardType = 'Thunder')) OR ((C2.CardType = 'Aqua') AND (C1.CardType = 'Thunder'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Turtle Tiger" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1000 AND C2.Attack < 1000 ) AND (((C1.CardType = 'Beast') AND (C2.IsTurtle = 1)) OR ((C2.CardType = 'Beast') AND (C1.IsTurtle = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Violet Crystal" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Breath of Light") AND (C2.CardName = "Prisman")) OR ((C2.CardName = "Breath of Light") AND (C1.CardName = "Prisman"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Cursebreaker" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Key Mace")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Key Mace"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Firegrass" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 700 AND C2.Attack < 700 ) AND (((C1.CardType = 'Plant') AND (C2.IsPyro = 1)) OR ((C2.CardType = 'Plant') AND (C1.IsPyro = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Invigoration" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Raigeki")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Raigeki"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Raise Body Heat" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Mooyan Curry") AND (C2.CardName = "Sparks")) OR ((C2.CardName = "Mooyan Curry") AND (C1.CardName = "Sparks"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Sword of Dark Destruction" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Armored Zombie") AND (C2.CardName = "Eternal Rest")) OR ((C2.CardName = "Armored Zombie") AND (C1.CardName = "Eternal Rest"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dungeon Worm" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.CardName = "Labyrinth Wall") AND (C2.CardName = "Zone Eater")) OR ((C2.CardName = "Labyrinth Wall") AND (C1.CardName = "Zone Eater"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Eternal Rest" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Elf's Light") AND (C2.CardName = "Silver Bow and Arrow")) OR ((C2.CardName = "Elf's Light") AND (C1.CardName = "Silver Bow and Arrow"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Korogashi" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 550 AND C2.Attack < 550 ) AND (((C1.CardName = "Armed Ninja") AND (C2.CardName = "Sinister Serpent")) OR ((C2.CardName = "Armed Ninja") AND (C1.CardName = "Sinister Serpent"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Turtle Oath" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Fake Trap") AND (C2.CardName = "Steel Shell")) OR ((C2.CardName = "Fake Trap") AND (C1.CardName = "Steel Shell"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Power of Kaishin") AND (C2.CardName = "Umi")) OR ((C2.CardName = "Power of Kaishin") AND (C1.CardName = "Umi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Darkworld Thorns" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 ) AND (((C1.CardType = 'Fiend') AND (C2.CardName = "Fungi of the Musk")) OR ((C2.CardType = 'Fiend') AND (C1.CardName = "Fungi of the Musk"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Rabid Horseman" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2000 AND C2.Attack < 2000 ) AND (((C1.CardName = "Battle Ox") AND (C2.CardName = "Mystic Horseman")) OR ((C2.CardName = "Battle Ox") AND (C1.CardName = "Mystic Horseman"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Darkfire Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 ) AND (((C1.CardName = "Widespread Ruin") AND (C2.CardName = "Zone Eater")) OR ((C2.CardName = "Widespread Ruin") AND (C1.CardName = "Zone Eater"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Harpie Lady Sisters" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1950 AND C2.Attack < 1950 ) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Harpie Lady")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Harpie Lady"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Garma Sword Oath" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Elegant Egotist") AND (C2.CardName = "Legendary Sword")) OR ((C2.CardName = "Elegant Egotist") AND (C1.CardName = "Legendary Sword"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Resurrection of Chakra" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Malevolent Nuzzler") AND (C2.CardName = "Malevolent Nuzzler")) OR ((C2.CardName = "Malevolent Nuzzler") AND (C1.CardName = "Malevolent Nuzzler"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Shadow Specter" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 500 AND C2.Attack < 500 ) AND (((C1.CardType = 'Beast') AND (C2.CardType = 'Zombie')) OR ((C2.CardType = 'Beast') AND (C1.CardType = 'Zombie'))))
OR (( C1.Attack < 500 AND C2.Attack < 500 ) AND (((C1.CardName = "Kuriboh") AND (C2.CardName = "Skull Servant")) OR ((C2.CardName = "Kuriboh") AND (C1.CardName = "Skull Servant"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Boulder Tortoise" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1450 AND C2.Attack < 1450 ) AND (((C1.CardType = 'Rock') AND (C2.IsTurtle = 1)) OR ((C2.CardType = 'Rock') AND (C1.IsTurtle = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dian Keto the Cure Master" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Soul of the Pure") AND (C2.CardName = "Soul of the Pure")) OR ((C2.CardName = "Soul of the Pure") AND (C1.CardName = "Soul of the Pure"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Witty Phantom" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C2.Attack >= 0) AND (((C1.CardName = "Armored Zombie") AND (C2.CardName = "Wood Clown")) OR ((C2.CardName = "Armored Zombie") AND (C1.CardName = "Wood Clown"))))
OR (( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardName = "Djinn the Watcher of the Wind") AND (C2.CardName = "Wolf")) OR ((C2.CardName = "Djinn the Watcher of the Wind") AND (C1.CardName = "Wolf"))))
OR ((C2.Attack >= 0) AND (((C1.CardName = "Gyakutenno Megami") AND (C2.CardName = "Weather Control")) OR ((C2.CardName = "Gyakutenno Megami") AND (C1.CardName = "Weather Control"))))
OR (( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardName = "Oscillo Hero #2") AND (C2.CardName = "Spirit of the Harp")) OR ((C2.CardName = "Oscillo Hero #2") AND (C1.CardName = "Spirit of the Harp"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Beast Fangs" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Final Flame") AND (C2.CardName = "Ooguchi")) OR ((C2.CardName = "Final Flame") AND (C1.CardName = "Ooguchi"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Revived of Serpent Night Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dark Energy") AND (C2.CardName = "Dragon Treasure")) OR ((C2.CardName = "Dark Energy") AND (C1.CardName = "Dragon Treasure"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Metal Fish" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1600 AND C2.Attack < 1600 AND (C1.Attack >= 1400 OR C2.Attack >= 1400) ) AND (((C1.CardType = 'Fish') AND (C2.CardType = 'Machine')) OR ((C2.CardType = 'Fish') AND (C1.CardType = 'Machine'))))
OR (( C1.Attack < 1600 AND C2.Attack < 1600 ) AND (((C1.CardName = "Tongyo") AND (C2.CardName = "Metalmorph")) OR ((C2.CardName = "Tongyo") AND (C1.CardName = "Metalmorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Fiend Refrection #1" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 ) AND (((C1.CardType = 'Winged Beast') AND (C2.IsMirror = 1)) OR ((C2.CardType = 'Winged Beast') AND (C1.IsMirror = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Crush Card" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Metalmorph") AND (C2.CardName = "Vile Germs")) OR ((C2.CardName = "Metalmorph") AND (C1.CardName = "Vile Germs"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Eradicating Aerosol" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Follow Wind") AND (C2.CardName = "Goblin's Secret Remedy")) OR ((C2.CardName = "Follow Wind") AND (C1.CardName = "Goblin's Secret Remedy"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Goblin's Secret Remedy") AND (C2.CardName = "Machine Conversion Factory")) OR ((C2.CardName = "Goblin's Secret Remedy") AND (C1.CardName = "Machine Conversion Factory"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "D. Human" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 AND (C1.Attack >= 1200 OR C2.Attack >= 1200) ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Warrior'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Hamburger Recipe" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Book of Secret Arts") AND (C2.CardName = "Mooyan Curry")) OR ((C2.CardName = "Book of Secret Arts") AND (C1.CardName = "Mooyan Curry"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Raigeki" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Electro-whip") AND (C2.CardName = "Metalmorph")) OR ((C2.CardName = "Electro-whip") AND (C1.CardName = "Metalmorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Reverse Trap" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Cursebreaker") AND (C2.CardName = "Megamorph")) OR ((C2.CardName = "Cursebreaker") AND (C1.CardName = "Megamorph"))))
OR ((C1.Attack >= 0) AND (((C1.CardName = "Fake Trap") AND (C2.CardName = "Megamorph")) OR ((C2.CardName = "Fake Trap") AND (C1.CardName = "Megamorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Bad Reaction to Simochi" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Mooyan Curry") AND (C2.CardName = "Mooyan Curry")) OR ((C2.CardName = "Mooyan Curry") AND (C1.CardName = "Mooyan Curry"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Flame Cerebrus" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2100 AND C2.Attack < 2100 ) AND (((C1.IsUsableBeast = 1) AND (C2.IsPyro = 1)) OR ((C2.IsUsableBeast = 1) AND (C1.IsPyro = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Corroding Shark" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1100 AND C2.Attack < 1100 ) AND (((C1.CardType = 'Fish') AND (C2.CardType = 'Zombie')) OR ((C2.CardType = 'Fish') AND (C1.CardType = 'Zombie'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dragon Capture Jar" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Dragon Treasure") AND (C2.CardName = "Mooyan Curry")) OR ((C2.CardName = "Dragon Treasure") AND (C1.CardName = "Mooyan Curry"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Winged Trumpeter" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Machine Conversion Factory") AND (C2.CardName = "Silver Bow and Arrow")) OR ((C2.CardName = "Machine Conversion Factory") AND (C1.CardName = "Silver Bow and Arrow"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Spirit of the Books" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardType = 'Winged Beast') AND (C2.CardName = "Boo Koo")) OR ((C2.CardType = 'Winged Beast') AND (C1.CardName = "Boo Koo"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Gate Guardian Ritual" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Magical Labyrinth") AND (C2.CardName = "Metalmorph")) OR ((C2.CardName = "Magical Labyrinth") AND (C1.CardName = "Metalmorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Vermillion Sparrow" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1900 AND C2.Attack < 1900 AND (C1.Attack >= 1800 OR C2.Attack >= 1800) ) AND (((C1.IsPyro = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsPyro = 1) AND (C1.CardType = 'Warrior'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Soul Hunter" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2200 AND C2.Attack < 2200 ) AND (((C1.CardType = 'Reptile') AND (C2.CardName = "Clown Zombie" OR C2.CardName = "Crass Clown")) OR ((C2.CardType = 'Reptile') AND (C1.CardName = "Clown Zombie" OR C1.CardName = "Crass Clown"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Disk Magician" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1350 AND C2.Attack < 1350 ) AND (((C1.IsMercurySpellcaster = 1) AND (C2.CardType = 'Machine')) OR ((C2.IsMercurySpellcaster = 1) AND (C1.CardType = 'Machine'))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Launcher Spider" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C2.Attack >= 0) AND (((C1.CardName = "Jirai Gumo") AND (C2.CardName = "Metalmorph")) OR ((C2.CardName = "Jirai Gumo") AND (C1.CardName = "Metalmorph"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "War-lion Ritual" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Beast Fangs") AND (C2.CardName = "Elegant Egotist")) OR ((C2.CardName = "Beast Fangs") AND (C1.CardName = "Elegant Egotist"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Ookazi" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
((C1.Attack >= 0) AND (((C1.CardName = "Final Flame") AND (C2.CardName = "Final Flame")) OR ((C2.CardName = "Final Flame") AND (C1.CardName = "Final Flame"))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Mystical Elf" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 800 AND C2.Attack < 800 ) AND (((C1.IsElf = 1) AND (C2.IsMystElfian = 1)) OR ((C2.IsElf = 1) AND (C1.IsMystElfian = 1))));

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Giga-tech Wolf" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 ) AND (((C1.IsUsableBeast = 1) AND (C2.CardType = 'Machine')) OR ((C2.IsUsableBeast = 1) AND (C1.CardType = 'Machine'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Giga-tech Wolf"
FROM PredictedFusions
WHERE PredictedResult = "Flame Cerebrus" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Celtic Guardian" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.IsElf = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsElf = 1) AND (C1.CardType = 'Warrior'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Celtic Guardian"
FROM PredictedFusions
WHERE PredictedResult = "Dark Elf" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Summoned Skull" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2500 AND C2.Attack < 2500 ) AND (((C1.CardType = 'Fiend') AND (C2.CardName = "Job-change Mirror")) OR ((C2.CardType = 'Fiend') AND (C1.CardName = "Job-change Mirror"))))
OR (( C1.Attack < 2500 AND C2.Attack < 2500 ) AND (((C1.CardName = "Time Wizard") AND (C2.CardName = "Embryonic Beast")) OR ((C2.CardName = "Time Wizard") AND (C1.CardName = "Embryonic Beast"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Summoned Skull"
FROM PredictedFusions
WHERE PredictedResult = "Darkworld Thorns" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Fire Kraken" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1600 AND C2.Attack < 1600 ) AND (((C1.IsPyro = 1) AND (C2.CardName = "Fiend Kraken")) OR ((C2.IsPyro = 1) AND (C1.CardName = "Fiend Kraken"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Fire Kraken"
FROM PredictedFusions
WHERE PredictedResult = "Spike Seadra" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Tatsunootoshigo" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1350 AND C2.Attack < 1350 ) AND (((C1.CardType = 'Beast') AND (C2.CardType = 'Fish')) OR ((C2.CardType = 'Beast') AND (C1.CardType = 'Fish'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Tatsunootoshigo"
FROM PredictedFusions
WHERE PredictedResult = "Nekogal #2" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Zombie Warrior" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 ) AND (((C1.CardType = 'Warrior') AND (C2.CardType = 'Zombie')) OR ((C2.CardType = 'Warrior') AND (C1.CardType = 'Zombie'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Zombie Warrior"
FROM PredictedFusions
WHERE PredictedResult = "Dragon Zombie" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Armored Zombie" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 AND (C1.Attack >= 1200 OR C2.Attack >= 1200) ) AND (((C1.CardType = 'Warrior') AND (C2.CardType = 'Zombie')) OR ((C2.CardType = 'Warrior') AND (C1.CardType = 'Zombie'))))
OR ((C2.Attack >= 0) AND (((C1.CardName = "Zanki") AND (C2.CardName = "Warrior Elimination")) OR ((C2.CardName = "Zanki") AND (C1.CardName = "Warrior Elimination"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Armored Zombie"
FROM PredictedFusions
WHERE PredictedResult = "Dragon Zombie" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Armored Zombie"
FROM PredictedFusions
WHERE PredictedResult = "Dark Elf" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Tiger Axe" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 ) AND (((C1.IsUsableBeast = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsUsableBeast = 1) AND (C1.CardType = 'Warrior'))))
OR ((C2.Attack >= 0) AND (((C1.CardName = "Ancient Jar") AND (C2.CardName = "Fiend Sword")) OR ((C2.CardName = "Ancient Jar") AND (C1.CardName = "Fiend Sword"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Tiger Axe"
FROM PredictedFusions
WHERE PredictedResult = "Nekogal #2" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Tiger Axe"
FROM PredictedFusions
WHERE PredictedResult = "Flame Cerebrus" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Flower Wolf" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.IsUsableBeast = 1) AND (C2.CardType = 'Plant')) OR ((C2.IsUsableBeast = 1) AND (C1.CardType = 'Plant'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flower Wolf"
FROM PredictedFusions
WHERE PredictedResult = "Nekogal #2" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flower Wolf"
FROM PredictedFusions
WHERE PredictedResult = "Flame Cerebrus" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Rose Spectre of Dunn" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2000 AND C2.Attack < 2000 ) AND (((C1.CardType = 'Fiend') AND (C2.CardName = "Arlownay")) OR ((C2.CardType = 'Fiend') AND (C1.CardName = "Arlownay"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Rose Spectre of Dunn"
FROM PredictedFusions
WHERE PredictedResult = "Queen of Autumn Leaves" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Giant Turtle Who Feeds on Flames" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.IsPyro = 1) AND (C2.IsTurtle = 1)) OR ((C2.IsPyro = 1) AND (C1.IsTurtle = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Giant Turtle Who Feeds on Flames"
FROM PredictedFusions
WHERE PredictedResult = "30,000-Year White Turtle" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Giant Turtle Who Feeds on Flames"
FROM PredictedFusions
WHERE PredictedResult = "Boulder Tortoise" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Giant Turtle Who Feeds on Flames"
FROM PredictedFusions
WHERE PredictedResult = "Turtle Bird" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Kaminari Attack" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1900 AND C2.Attack < 1900 ) AND (((C1.CardType = 'Spellcaster') AND (C2.CardName = "Spike Seadra")) OR ((C2.CardType = 'Spellcaster') AND (C1.CardName = "Spike Seadra"))))
OR (( C1.Attack < 1900 AND C2.Attack < 1900 AND (C1.Attack >= 1500 OR C2.Attack >= 1500) ) AND (((C1.CardType = 'Spellcaster') AND (C2.CardType = 'Thunder')) OR ((C2.CardType = 'Spellcaster') AND (C1.CardType = 'Thunder'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Kaminari Attack"
FROM PredictedFusions
WHERE PredictedResult = "Thousand Dragon" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Kaminari Attack"
FROM PredictedFusions
WHERE PredictedResult = "Thousand Dragon" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Marine Beast" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1700 AND C2.Attack < 1700 AND (C1.Attack >= 1500 OR C2.Attack >= 1500) ) AND (((C1.CardType = 'Beast') AND (C2.CardType = 'Fish')) OR ((C2.CardType = 'Beast') AND (C1.CardType = 'Fish'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Marine Beast"
FROM PredictedFusions
WHERE PredictedResult = "Nekogal #2" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Magical Ghost" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 ) AND (((C1.CardType = 'Spellcaster') AND (C2.CardType = 'Zombie')) OR ((C2.CardType = 'Spellcaster') AND (C1.CardType = 'Zombie'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Magical Ghost"
FROM PredictedFusions
WHERE PredictedResult = "Dark Elf" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Lord of the Lamp" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardType = 'Spellcaster') AND (C2.CardName = "Mystic Lamp")) OR ((C2.CardType = 'Spellcaster') AND (C1.CardName = "Mystic Lamp"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Lord of the Lamp"
FROM PredictedFusions
WHERE PredictedResult = "Dark Elf" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dice Armadillo" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1650 AND C2.Attack < 1650 AND (C1.Attack >= 1200 OR C2.Attack >= 1200) ) AND (((C1.IsUsableBeast = 1) AND (C2.CardType = 'Machine')) OR ((C2.IsUsableBeast = 1) AND (C1.CardType = 'Machine'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dice Armadillo"
FROM PredictedFusions
WHERE PredictedResult = "Flame Cerebrus" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dark Witch" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.CardType = 'Fairy') AND (C2.IsFemale = 1)) OR ((C2.CardType = 'Fairy') AND (C1.IsFemale = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dark Witch"
FROM PredictedFusions
WHERE PredictedResult = "Mystical Elf" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dark Witch"
FROM PredictedFusions
WHERE PredictedResult = "Celtic Guardian" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dark Witch"
FROM PredictedFusions
WHERE PredictedResult = "Musician King" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dark Witch"
FROM PredictedFusions
WHERE PredictedResult = "Queen of Autumn Leaves" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dark Witch"
FROM PredictedFusions
WHERE PredictedResult = "Dark Elf" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Flame Ghost" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1000 AND C2.Attack < 1000 AND (C1.Attack >= 700 OR C2.Attack >= 700) ) AND (((C1.IsPyro = 1) AND (C2.CardType = 'Zombie')) OR ((C2.IsPyro = 1) AND (C1.CardType = 'Zombie'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Ghost"
FROM PredictedFusions
WHERE PredictedResult = "Wood Remains" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Ghost"
FROM PredictedFusions
WHERE PredictedResult = "Zombie Warrior" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Ghost"
FROM PredictedFusions
WHERE PredictedResult = "Stone Ghost" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Ghost"
FROM PredictedFusions
WHERE PredictedResult = "Magical Ghost" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Ghost"
FROM PredictedFusions
WHERE PredictedResult = "The Snake Hair" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Charubin the Fire Knight" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1100 AND C2.Attack < 1100 ) AND (((C1.IsPyro = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsPyro = 1) AND (C1.CardType = 'Warrior'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Charubin the Fire Knight"
FROM PredictedFusions
WHERE PredictedResult = "Zombie Warrior" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Charubin the Fire Knight"
FROM PredictedFusions
WHERE PredictedResult = "Queen of Autumn Leaves" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Flame Swordsman" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 AND (C1.Attack >= 1100 OR C2.Attack >= 1100) ) AND (((C1.IsPyro = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsPyro = 1) AND (C1.CardType = 'Warrior'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Swordsman"
FROM PredictedFusions
WHERE PredictedResult = "Zombie Warrior" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Swordsman"
FROM PredictedFusions
WHERE PredictedResult = "Armored Zombie" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Swordsman"
FROM PredictedFusions
WHERE PredictedResult = "Dragon Zombie" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Flame Swordsman"
FROM PredictedFusions
WHERE PredictedResult = "Queen of Autumn Leaves" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Ice Water" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1150 AND C2.Attack < 1150 ) AND (((C1.IsFemale = 1) AND (C2.CardType = 'Fish')) OR ((C2.IsFemale = 1) AND (C1.CardType = 'Fish'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Ice Water"
FROM PredictedFusions
WHERE PredictedResult = "Wow Warrior" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Ice Water"
FROM PredictedFusions
WHERE PredictedResult = "Tatsunootoshigo" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Bean Soldier" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.CardType = 'Plant') AND (C2.CardType = 'Warrior')) OR ((C2.CardType = 'Plant') AND (C1.CardType = 'Warrior'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Bean Soldier"
FROM PredictedFusions
WHERE PredictedResult = "Charubin the Fire Knight" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Bean Soldier"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Bean Soldier"
FROM PredictedFusions
WHERE PredictedResult = "Queen of Autumn Leaves" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Stone D." AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2000 AND C2.Attack < 2000 ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Rock')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Rock'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Stone D."
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Amazon of the Seas" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 AND (C1.Attack >= 1200 OR C2.Attack >= 1200) ) AND (((C1.IsFemale = 1) AND (C2.CardType = 'Fish')) OR ((C2.IsFemale = 1) AND (C1.CardType = 'Fish'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Amazon of the Seas"
FROM PredictedFusions
WHERE PredictedResult = "Wow Warrior" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Amazon of the Seas"
FROM PredictedFusions
WHERE PredictedResult = "Tatsunootoshigo" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Amazon of the Seas"
FROM PredictedFusions
WHERE PredictedResult = "Dark Witch" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Amazon of the Seas"
FROM PredictedFusions
WHERE PredictedResult = "Queen of Autumn Leaves" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dragoness the Wicked Knight" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1200 AND C2.Attack < 1200 AND (C1.Attack >= 1100 OR C2.Attack >= 1100) ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Warrior'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dragoness the Wicked Knight"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Kairyu-shin" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 AND (C1.Attack >= 1600 OR C2.Attack >= 1600) ) AND (((C1.CardType = 'Aqua') AND (C2.IsDragon = 1)) OR ((C2.CardType = 'Aqua') AND (C1.IsDragon = 1))))
OR (( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.CardName = "Darkfire Dragon") AND (C2.CardName = "Reverse Trap")) OR ((C2.CardName = "Darkfire Dragon") AND (C1.CardName = "Reverse Trap"))))
OR (( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.CardName = "Final Flame") AND (C2.CardName = "Waterdragon Fairy")) OR ((C2.CardName = "Final Flame") AND (C1.CardName = "Waterdragon Fairy"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Kairyu-shin"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "7 Colored Fish" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1800 AND C2.Attack < 1800 ) AND (((C1.CardType = 'Fish') AND (C2.IsRainbow = 1)) OR ((C2.CardType = 'Fish') AND (C1.IsRainbow = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "7 Colored Fish"
FROM PredictedFusions
WHERE PredictedResult = "Queen of Autumn Leaves" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "7 Colored Fish"
FROM PredictedFusions
WHERE PredictedResult = "Dark Witch" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Sword Arm of Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1750 AND C2.Attack < 1750 AND (C1.Attack >= 1300 OR C2.Attack >= 1300) ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Warrior')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Warrior'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Sword Arm of Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Skelgon" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Sword Arm of Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Sword Arm of Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Dark Elf" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Cyber Soldier" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 ) AND (((C1.CardType = 'Machine') AND (C2.CardType = 'Warrior')) OR ((C2.CardType = 'Machine') AND (C1.CardType = 'Warrior'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Cyber Soldier"
FROM PredictedFusions
WHERE PredictedResult = "Charubin the Fire Knight" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Cyber Soldier"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Punished Eagle" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2100 AND C2.Attack < 2100 ) AND (((C1.CardType = 'Winged Beast') AND (C2.CardName = "The Judgement Hand")) OR ((C2.CardType = 'Winged Beast') AND (C1.CardName = "The Judgement Hand"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Punished Eagle"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Winged Egg of New Life" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1400 AND C2.Attack < 1400 ) AND (((C1.IsAngelWinged = 1) AND (C2.IsEgg = 1)) OR ((C2.IsAngelWinged = 1) AND (C1.IsEgg = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Winged Egg of New Life"
FROM PredictedFusions
WHERE PredictedResult = "Mystical Elf" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Winged Egg of New Life"
FROM PredictedFusions
WHERE PredictedResult = "Tiger Axe" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Winged Egg of New Life"
FROM PredictedFusions
WHERE PredictedResult = "Celtic Guardian" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Winged Egg of New Life"
FROM PredictedFusions
WHERE PredictedResult = "Dark Witch" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Winged Egg of New Life"
FROM PredictedFusions
WHERE PredictedResult = "Dark Elf" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Garvas" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2000 AND C2.Attack < 2000 ) AND (((C1.CardType = 'Beast') AND (C2.IsAngelWinged = 1)) OR ((C2.CardType = 'Beast') AND (C1.IsAngelWinged = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Garvas"
FROM PredictedFusions
WHERE PredictedResult = "Mystical Sheep #1" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Garvas"
FROM PredictedFusions
WHERE PredictedResult = "Mon Larvas" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Garvas"
FROM PredictedFusions
WHERE PredictedResult = "Winged Egg of New Life" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Garvas"
FROM PredictedFusions
WHERE PredictedResult = "Dark Witch" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Garvas"
FROM PredictedFusions
WHERE PredictedResult = "Nekogal #2" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Sea King Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2000 AND C2.Attack < 2000 ) AND (((C1.IsTurtle = 1) AND (C2.IsDragon = 1)) OR ((C2.IsTurtle = 1) AND (C1.IsDragon = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Sea King Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Spike Seadra" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Sea King Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Kairyu-shin" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Koumori Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 ) AND (((C1.IsDragon = 1) AND (C2.IsKoumorian = 1)) OR ((C2.IsDragon = 1) AND (C1.IsKoumorian = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Koumori Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Dragoness the Wicked Knight" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Koumori Dragon"
FROM PredictedFusions
WHERE PredictedResult = "D. Human" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Koumori Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Tiger Axe" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Blackland Fire Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1500 AND C2.Attack < 1500 ) AND (((C1.IsMercuryMagicUser = 1) AND (C2.IsDragon = 1)) OR ((C2.IsMercuryMagicUser = 1) AND (C1.IsDragon = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Blackland Fire Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Dragon Zombie" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Blackland Fire Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Dragon Statue" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Blackland Fire Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Dragoness the Wicked Knight" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Blackland Fire Dragon"
FROM PredictedFusions
WHERE PredictedResult = "D. Human" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Blackland Fire Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Sword Arm of Dragon" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Twin-headed Thunder Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2800 AND C2.Attack < 2800 AND (C1.Attack >= 1600 OR C2.Attack >= 1600) ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Thunder')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Thunder'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Twin-headed Thunder Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Skelgon" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Twin-headed Thunder Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Sword Arm of Dragon" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Judge Man" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2200 AND C2.Attack < 2200 ) AND (((C1.CardType = 'Warrior') AND (C2.CardName = "The Judgement Hand")) OR ((C2.CardType = 'Warrior') AND (C1.CardName = "The Judgement Hand"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Judge Man"
FROM PredictedFusions
WHERE PredictedResult = "Sword Arm of Dragon" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Judge Man"
FROM PredictedFusions
WHERE PredictedResult = "Musician King" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Judge Man"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Judge Man"
FROM PredictedFusions
WHERE PredictedResult = "Vermillion Sparrow" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "B. Dragon Jungle King" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2100 AND C2.Attack < 2100 ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Plant')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Plant'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "B. Dragon Jungle King"
FROM PredictedFusions
WHERE PredictedResult = "Bean Soldier" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "B. Dragon Jungle King"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "B. Dragon Jungle King"
FROM PredictedFusions
WHERE PredictedResult = "Pumpking the King of Ghosts" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Metal Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1850 AND C2.Attack < 1850 ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Machine')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Machine'))))
OR (( C1.Attack < 1850 AND C2.Attack < 1850 ) AND (((C1.CardName = "Baby Dragon") AND (C2.CardName = "Metalmorph")) OR ((C2.CardName = "Baby Dragon") AND (C1.CardName = "Metalmorph"))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Metal Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Cyber Soldier" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Metal Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Cyber Saurus" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Metal Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Curse of Dragon" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2000 AND C2.Attack < 2000 AND (C1.Attack >= 1700 OR C2.Attack >= 1700) ) AND (((C1.IsDragon = 1) AND (C2.CardType = 'Zombie')) OR ((C2.IsDragon = 1) AND (C1.CardType = 'Zombie'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Curse of Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Sword Arm of Dragon" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Curse of Dragon"
FROM PredictedFusions
WHERE PredictedResult = "Twin-headed Thunder Dragon" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Mystical Sand" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2100 AND C2.Attack < 2100 ) AND (((C1.IsFemale = 1) AND (C2.CardType = 'Rock')) OR ((C2.IsFemale = 1) AND (C1.CardType = 'Rock'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Mystical Sand"
FROM PredictedFusions
WHERE PredictedResult = "Charubin the Fire Knight" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Mystical Sand"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Mystical Sand"
FROM PredictedFusions
WHERE PredictedResult = "B. Dragon Jungle King" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Ushi Oni" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2150 AND C2.Attack < 2150 ) AND (((C1.IsMercurySpellcaster = 1) AND (C2.IsJar = 1)) OR ((C2.IsMercurySpellcaster = 1) AND (C1.IsJar = 1))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Ushi Oni"
FROM PredictedFusions
WHERE PredictedResult = "Mystical Sand" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Crimson Sunbird" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 2300 AND C2.Attack < 2300 AND (C1.Attack >= 1300 OR C2.Attack >= 1300) ) AND (((C1.IsPyro = 1) AND (C2.CardType = 'Winged Beast')) OR ((C2.IsPyro = 1) AND (C1.CardType = 'Winged Beast'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Crimson Sunbird"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Crimson Sunbird"
FROM PredictedFusions
WHERE PredictedResult = "Vermillion Sparrow" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Crimson Sunbird"
FROM PredictedFusions
WHERE PredictedResult = "Queen of Autumn Leaves" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Crimson Sunbird"
FROM PredictedFusions
WHERE PredictedResult = "Harpie's Pet Dragon" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Crimson Sunbird"
FROM PredictedFusions
WHERE PredictedResult = "Mystical Sand" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Minomushi Warrior" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 1300 AND C2.Attack < 1300 ) AND (((C1.CardType = 'Rock') AND (C2.CardType = 'Warrior')) OR ((C2.CardType = 'Rock') AND (C1.CardType = 'Warrior'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Minomushi Warrior"
FROM PredictedFusions
WHERE PredictedResult = "Charubin the Fire Knight" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Minomushi Warrior"
FROM PredictedFusions
WHERE PredictedResult = "Flame Swordsman" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Minomushi Warrior"
FROM PredictedFusions
WHERE PredictedResult = "Stone D." 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Minomushi Warrior"
FROM PredictedFusions
WHERE PredictedResult = "Mystical Sand" ;

INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "Dissolverock" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
(( C1.Attack < 900 AND C2.Attack < 900 ) AND (((C1.IsPyro = 1) AND (C2.CardType = 'Rock')) OR ((C2.IsPyro = 1) AND (C1.CardType = 'Rock'))))
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dissolverock"
FROM PredictedFusions
WHERE PredictedResult = "Stone Ghost" 
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "Dissolverock"
FROM PredictedFusions
WHERE PredictedResult = "Minomushi Warrior" ;

