import re

def generateAddEachIsColumnSetToZeroDotSQL():
	with open("setEachSecTypeColumnToOneWhenAppropriate.sql") as inputfile, open("addEachIsColumnSetToZero.sql", 'w+') as outputfile:
		for line in inputfile:
			regExp = re.compile("SET (.*) = 1")
			searchResult = regExp.search(line)
			if searchResult:
				secType = searchResult.group(1).strip()
				outputfile.write("ALTER TABLE Cards ADD " + secType + " INT;\n")
				outputfile.write("UPDATE Cards\n")
				outputfile.write("SET " + secType + " = 0;\n\n")

def generateCreateTotalSecTypesColumnDotSQL():
	with open("setEachSecTypeColumnToOneWhenAppropriate.sql") as inputfile, open("createTotalSecTypesColumn.sql", 'w+') as outputfile:
		outputfile.write("ALTER TABLE Cards ADD TotalSecTypes INT;\n")
		outputfile.write("UPDATE Cards\n")
		outputfile.write("SET TotalSecTypes = ")
		isPastFirstLine = False
		for line in inputfile:
			regExp = re.compile("SET (.*) = 1")
			searchResult = regExp.search(line)
			if searchResult:
				secType = searchResult.group(1).strip()
				if isPastFirstLine == False:
					outputfile.write(secType)
					isPastFirstLine = True
				else:
					outputfile.write(" + " + secType)
		outputfile.write(";")

def generateCreateCardSecTypesColumnDotSQL():
	with open("setEachSecTypeColumnToOneWhenAppropriate.sql") as inputfile, open("createCardSecTypesColumn.sql", 'w+') as outputfile:
		outputfile.write("ALTER TABLE Cards ADD CardSecTypes TEXT;\n")
		outputfile.write("UPDATE Cards\n")
		outputfile.write("SET CardSecTypes = '';\n\n")
		for line in inputfile:
			regExp = re.compile("SET (.*) = 1")
			searchResult = regExp.search(line)
			if searchResult:
				secType = searchResult.group(1).strip()
				outputfile.write("UPDATE Cards\n")
				outputfile.write("SET CardSecTypes = CardSecTypes || '" + secType[2:] + " '\n")
				outputfile.write("WHERE " + secType + " = 1;\n\n")



generateAddEachIsColumnSetToZeroDotSQL()
generateCreateTotalSecTypesColumnDotSQL()
generateCreateCardSecTypesColumnDotSQL()