from os import path
import re, string;


pathToYFMDB = path.abspath(path.join(path.dirname(__file__), '..', '..', "YFM.db"))
equipNames = ['Axe of Despair', 'Beast Fangs', 'Black Pendant', 'Book of Secret Arts', 
'Bright Castle', 'Cyber Shield', 'Dark Energy', 'Dragon Treasure', 'Electro-whip', 
'Elegant Egotist', "Elf's Light", 'Follow Wind', 'Horn of Light', 'Horn of the Unicorn',
'Insect Armor with Laser Cannon', 'Invigoration', 'Kunai with Chain', 'Laser Cannon Armor',
'Legendary Sword', 'Machine Conversion Factory', 'Magical Labyrinth', 'Malevolent Nuzzler',
'Megamorph', 'Metalmorph', 'Mystical Moon', 'Power of Kaishin', 'Raise Body Heat',
'Salamandra', 'Silver Bow and Arrow', 'Steel Shell', 'Sword of Dark Destruction',
'Vile Germs', 'Violet Crystal', 'Winged Trumpeter']

def generateEquippedBySQL():
	with open("equippedBy.sql", 'w+') as outputFile:
		# Generate SQL code responsible for the creation of the IsEquippedBy columns
		nonAlphanumericRegex = re.compile('[\W_]+')
		for equipName in equipNames:
			equipNameWithoutNonAlphanumChars = nonAlphanumericRegex.sub('', equipName)
			outputFile.write(f"""ALTER TABLE Cards ADD IsEquippedBy{equipNameWithoutNonAlphanumChars} INT;
UPDATE Cards
SET IsEquippedBy{equipNameWithoutNonAlphanumChars} = 0;\n""")
			outputFile.write(f"""UPDATE Cards
SET IsEquippedBy{equipNameWithoutNonAlphanumChars} = 1
WHERE CardName IN (SELECT EquippedName
				   FROM   EquippingPlus
				   WHERE  EquipName = "{equipName}");\n\n""")

		IsEquippedByColNames = ["IsEquippedBy" + nonAlphanumericRegex.sub('', equipName) for equipName in equipNames]
		sumOfEquippedByCols = ' + '.join(IsEquippedByColNames)
		# Generate SQL code responsible for the creation of the column TotalEquips
		outputFile.write(f"""ALTER TABLE Cards ADD TotalEquips INT;
UPDATE Cards
SET    TotalEquips = {sumOfEquippedByCols};""")


		# Generate SQL code responsible for the creation of the column EquippedBy
		outputFile.write(f"""ALTER TABLE Cards ADD EquippedBy TEXT;
UPDATE Cards
SET    EquippedBy = '';\n""")
		for index, equipName in enumerate(equipNames):
			equipNameWithoutNonAlphanumChars = nonAlphanumericRegex.sub('', equipName)
			outputFile.write(f"""UPDATE Cards
SET EquippedBy = EquippedBy || '{equipNameWithoutNonAlphanumChars} '
WHERE IsEquippedBy{equipNameWithoutNonAlphanumChars} = 1;
""")
			

generateEquippedBySQL()