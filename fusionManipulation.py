import sqlite3
import re
from toposort import toposort, toposort_flatten
import os
from operator import itemgetter

OFFSET_FUSION_EQUALS_SIGN = 26
OFFSET_FUSION_LESSTHAN_SIGN = 28
OFFSET_CARD_SEC_TYPES = 32

pathToYFMDB = os.path.abspath(os.path.join(os.path.dirname(__file__), ".", "YFM.db"))
pathTofusionsTXT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".", "fusions.txt"))



###############################################
# SECTION 1: Reading fusions from a text file #
###############################################

# Returns dictionary fusionRules where
# 1. For each fusion rule of the form
# T_1 + T_2 = C_{0, 0}
#			    <  C_{0, 1},
#                   ...
#			       C_{0, n_0} 
#             C_{1, 0}
#			    <  C_{1, 1},
#                   ...
#			       C_{1, n_1} 
#             ...
#             C_{m, 0}
#			    <  C_{m, 1},
#                   ...
#			       C_{m, n_m}
# we have
# fusionRules[(T_1, T_2)] 
#            == [ [C_{0, 0}, C_{0, 1}, ..., C_{0, n_0}],
# 				[C_{1, 0}, C_{1, 1}, ..., C_{1, n_1}],
#				...
#				[C_{m, 0}, C_{m, 1}, ..., C_{m, n_m}] ]
# 2. The only keys stored in the above dictionary are the ones explicity indicated above
def readFusionRules(wantExactFusions):
	with open(pathTofusionsTXT) as inputFile:
		
		fusionRules = {}
		whatToDoNext = "Read T_1 and T_2 and maybe C_00"
		inputFileIt = iter(inputFile)
		line = next(inputFileIt) # skips first line
		line = next(inputFileIt)
		while True:
			if whatToDoNext == "Read T_1 and T_2 and maybe C_00":
				T_1plusT_2equalsC_00Regex = re.compile("(.*)\+(.*)=([^(]*)")
				searchResult = T_1plusT_2equalsC_00Regex.search(line)
				if searchResult != None:
					T_1 = searchResult.group(1).strip()
					T_2 = searchResult.group(2).strip()
					C = [ [searchResult.group(3).strip()] ]
					whatToDoNext = "Read conflicts if any"
					try:
						line = next(inputFileIt)
					except StopIteration:
						whatToDoNext = "Add last fusion rule to fusionRules and return"
					continue
				else:
					T_1plusT_2Regex = re.compile("(.*)\+(.*)")
					searchResult = T_1plusT_2Regex.search(line)
					assert searchResult != None
					T_1 = searchResult.group(1).strip()
					T_2 = searchResult.group(2).strip()
					whatToDoNext = "Read C_00"
					try:
						line = next(inputFileIt)
					except StopIteration:
						whatToDoNext = "Add last fusion rule to fusionRules and return"
					continue
			elif whatToDoNext == "Read C_00":
				C_00Regex = re.compile("\s*=([^(]*)")
				searchResult = C_00Regex.search(line)
				assert searchResult != None
				C = [ [searchResult.group(1).strip()] ]
				whatToDoNext = "Read conflicts if any"
				try:
					line = next(inputFileIt)
				except StopIteration:
					whatToDoNext = "Add last fusion rule to fusionRules and return"
				continue
			elif whatToDoNext == "Read conflicts if any":
				if re.search("^\s*$", line) or re.search("^[-]+$", line) or ( re.search("Exact fusions", line) and wantExactFusions ):
					whatToDoNext = "Read conflicts if any"
					try:
						line = next(inputFileIt)
					except StopIteration:
						whatToDoNext = "Add last fusion rule to fusionRules and return"
					continue
				if re.search("Exact fusions", line) and not wantExactFusions:
					whatToDoNext = "Add last fusion rule to fusionRules and return"
					continue
				if re.search("Conflicts in detail", line):
					whatToDoNext = "Add last fusion rule to fusionRules and return"
					continue
				if '+' in line:
					fusionRules[(T_1, T_2)] = C
					whatToDoNext = "Read T_1 and T_2 and maybe C_00"
					continue
				if '=' in line:
					whatToDoNext = "Read next fusion result"
					continue
				if '<' in line:
					lessThanFirstConflictRegex = re.compile("\s*<([^(]*)")
					searchResult = lessThanFirstConflictRegex.search(line)
				else:
					anotherConflictRegex = re.compile("\s*([^(]*)")
					searchResult = anotherConflictRegex.search(line)
				assert searchResult != None
				C[-1].append(searchResult.group(1).strip())
				whatToDoNext = "Read conflicts if any"
				try:
					line = next(inputFileIt)
				except StopIteration:
					whatToDoNext = "Add last fusion rule to fusionRules and return"
				continue
			elif whatToDoNext == "Read next fusion result":
				equalsFusionResultRegex = re.compile("=([^(]*)")
				searchResult = equalsFusionResultRegex.search(line)
				assert searchResult != None
				C.append([searchResult.group(1).strip()])
				whatToDoNext = "Read conflicts if any"
				try:
					line = next(inputFileIt)
				except StopIteration:
					whatToDoNext = "Add last fusion rule to fusionRules and return"
				continue
			elif whatToDoNext == "Add last fusion rule to fusionRules and return":
				fusionRules[(T_1, T_2)] = C
				return fusionRules
			else:
				raise Exception("Unknown whatToDoNext")


#################################################################
# SECTION 2: Computing dictionaries from python data structures #
#################################################################

# Returns dictionary resultToMaterials where
# resultToMaterials[resultCard] is a list of all pairs (T_1, T_2) such that
# resultCard is one of the results C_{0, 0}, C_{1, 0}, ..., C_{m, 0}
# of the fusion T_1 + T_2, as listed in the comment above readFusionRules() above.
# Note that the pair (T_2, T_1) is not included
def computeResultToMaterials(fusions):
	resultToMaterials = {}
	for (T_1, T_2) in fusions:
		for resultAndConflicts in fusions[(T_1, T_2)]:
			result = resultAndConflicts[0]
			if result not in resultToMaterials:
				resultToMaterials[result] = []
			resultToMaterials[result].append( (T_1, T_2) )
	return resultToMaterials

# Returns a dictionary conflictPrecedence such that for each card result we have
# conflictPrecedence[result] is a set of all cards that take precedence over
# result when both are candidate results of a fusion
def computeDependenceOfFusionResults(fusions):
	conflictPrecedence = {}
	for (T_1, T_2) in fusions:
		for resultAndConflicts in fusions[(T_1, T_2)]:
			result = resultAndConflicts[0]
			if result not in conflictPrecedence:
				conflictPrecedence[result] = set()
			iterConflicts = iter(resultAndConflicts)
			next(iterConflicts)
			for conflict in iterConflicts:
				conflictPrecedence[result].add(conflict)
	return conflictPrecedence

def computeReferencedSetsOfCards(fusionRules):
	referencedSetsOfCards = set()
	for (T_1, T_2) in fusionRules:
		referencedSetsOfCards.add(T_1)
		referencedSetsOfCards.add(T_2)
	return referencedSetsOfCards

# Returns dictionary supersets such that for each referenced set of cards T
# supersets[T] is the set of all referenced sets of cards that contain T
def computeSupersets(referencedSetsOfCards):
# [Aqua] contained_in [Bugrothian] (except high atk cards)
# [UsableBeast] contained_in [Beast]
# [MercurySpellcaster] contained_in [MercuryMagicUser]
# [MercurySpellcaster] contained_in [Spellcaster]
# [FeatherFromBear] contained_in [FeatherFromMachine]
# [Turtle] contained_in [Aqua]
# [Fiend] contained_in [Thronian] contained_in [Sheepian]
# (assuming Thronian is defined as FiendOrGS1MoonNotMoonEnvoy)
# (assuming Sheepian is defined as FiendOrGS1Moon)
	supersets = {"[Aqua]": {"[Bugrothian]"},
"[UsableBeast]": {"[Beast]"},
"[MercurySpellcaster]": {"[MercuryMagicUser]", "[Spellcaster]"},
"[FeatherFromBear]": {"[FeatherFromMachine]"},
"[Turtle]": {"[Aqua]", "[Bugrothian]"},
"[Fiend]": {"[Thronian]", "[Sheepian]"},
"[Thronian]": {"[Sheepian]"}}
	for setOfCards in referencedSetsOfCards:
		if setOfCards not in supersets:
			supersets[setOfCards] = {setOfCards}
		else:
			supersets[setOfCards].add(setOfCards)

	return supersets

###############################################################
# SECTION 3: Computing dictionaries from SQLite database file #
###############################################################

# Returns a dictionary atk such that
# atk[cardName] is the atk of the card named cardName
# for each cardName
def readCardAtks():
	atk = {}
	conn = sqlite3.connect(pathToYFMDB)
	c = conn.cursor()
	for cardName, cardAtk in c.execute("SELECT CardName, Attack FROM Cards"):
		atk[cardName] = cardAtk
	conn.close()
	return atk

def readCardDefs():
	defense = {}
	conn = sqlite3.connect(pathToYFMDB)
	c = conn.cursor()
	for cardName, cardDefense in c.execute("SELECT CardName, Defense FROM Cards"):
		defense[cardName] = cardDefense
	conn.close()
	return defense

def readCardsInfo():
	conn = sqlite3.connect(pathToYFMDB)
	c = conn.cursor()
	cardsInfo = {}
	colNames = []
	for colInfo in c.execute("PRAGMA table_info(Cards)"):
		colNames.append(colInfo[1])
	for cardInfo in c.execute("SELECT * FROM Cards"):
		cardName = cardInfo[1]
		cardInfoDict = {}
		for colIndex, colName in enumerate(colNames):
			if colName != 'CardName':
				cardInfoDict[colName] = cardInfo[colIndex]
		cardsInfo[cardName] = cardInfoDict
	conn.close()
	return cardsInfo

# Returns set setOfPrimaryTypes that contains
# all primary times, such as 'Dragon' and 'Warrior'
def computePrimaryTypes():
	setOfPrimaryTypes = set()
	conn = sqlite3.connect(pathToYFMDB)
	c = conn.cursor()
	for cardType in c.execute("SELECT DISTINCT CardType from cards ORDER BY CardType;"):
		setOfPrimaryTypes.add(cardType[0])
	conn.close()
	return setOfPrimaryTypes

# Returns set setOfSecondaryTypes that contains
# all secondary types, such as 'Dragon' and 'Elf'
def computeSecondaryTypes():
	setOfSecondaryTypes = set()
	conn = sqlite3.connect(pathToYFMDB)
	c = conn.cursor()
	for createTableStatement in c.execute("""SELECT sql FROM sqlite_master
WHERE type='table' and name = 'Cards';"""):
		for columnNameAndType in createTableStatement[0].split(','):
			secTypeRegex = re.compile("Is(.*) INT")
			searchResult = secTypeRegex.search(columnNameAndType)
			if searchResult:
				setOfSecondaryTypes.add(searchResult.group(1).strip())
	conn.close()
	return setOfSecondaryTypes
	


##########################################################################################
# SECTION 4: Computing dictionaries from SQLite database file and python data structures #
##########################################################################################


# Returns list [T_1, T_2, result, S_1, S_2, conflict, material1Set, material2Set]
# where 
# 1. a card material1 is in material1Set if and only if there exists a card material2
# such that (material1, material2) satisfies the atk and type conditions of
# the fusion rule T_1 + T_2 = result
# and the fusion material1 + material2 = conflict is in FusionsPlus
# 2. similarly for material2
def generateConflictInDetail(T_1, T_2, result, fusionRuleT, S_1, S_2, conflict, fusionRuleS, setOfPrimaryTypes, setOfSecondaryTypes, atk, dbCursor):
	material1Set = set()
	material2Set = set()
	atkConditionT = computeAtkCondition(T_1, T_2, result, fusionRuleT, atk, 'C1.Attack', 'C2.Attack')
	typConditionT = computeTypeConditions(T_1, T_2, setOfPrimaryTypes, setOfSecondaryTypes, 'C1', 'C2')
	atkConditionS = computeAtkCondition(S_1, S_2, conflict, fusionRuleS, atk, 'C1.Attack', 'C2.Attack')
	typConditionS = computeTypeConditions(S_1, S_2, setOfPrimaryTypes, setOfSecondaryTypes, 'C1', 'C2')

	for (material1, material2) in dbCursor.execute(f"""SELECT Material1Name, Material2Name
FROM FusionsPlus
JOIN Cards AS C1
ON   Material1Name = C1.CardName
JOIN Cards AS C2
ON   Material2Name = C2.CardName
WHERE ResultName = \"{conflict}\" AND
{atkConditionT} AND {typConditionT} AND
{atkConditionS} AND {typConditionS}"""):
		material1Set.add(material1)
		material2Set.add(material2)

	return {'T_1' : T_1, 'T_2' : T_2, 'result' : result, 'fusionRuleT' : fusionRuleT,
			'S_1' : S_1, 'S_2' : S_2, 'conflict': conflict, 'fusionRuleS' : fusionRuleS,
			'material1Set' : material1Set, 'material2Set' : material2Set}


def generateConflictsInDetail():

	rawGeneralFusionRules = readFusionRules(False)
	symmetricSortedGeneralFusionRulesList = computeFusionsSymmetricAndSorted()
	symmetricGeneralFusionRules = readFusionRules(False)
	takeSymmetricClosureOfGivenFusionRules(symmetricGeneralFusionRules)

	rawResultToMaterials = computeResultToMaterials(rawGeneralFusionRules)

	setOfPrimaryTypes = computePrimaryTypes()
	setOfSecondaryTypes = computeSecondaryTypes()
	atk = readCardAtks()

	conn = sqlite3.connect(pathToYFMDB)
	dbCursor = conn.cursor()


	# conflictDependence = computeDependenceOfFusionResults(rawGeneralFusionRules)
	# for result in conflictDependence:
	# 	for conflict in conflictDependence[result]:
	# 		print(f"\"{result}\" -> \"{conflict}\"")
	
	conflictsInDetail = []
	
	for ((T_1, T_2), fusionRuleT) in symmetricSortedGeneralFusionRulesList:
		# fusionRuleT = symmetricSortedGeneralFusionRulesList[(T_1, T_2)]
		for resultWithConflicts in fusionRuleT:
			result = resultWithConflicts[0]
			conflicts = resultWithConflicts[1:]
			for conflict in conflicts:
				for (S_1, S_2) in rawResultToMaterials[conflict]:
					fusionRuleS = symmetricGeneralFusionRules[(S_1, S_2)]
					conflictInDetail = generateConflictInDetail(T_1, T_2, result, fusionRuleT,
																S_1, S_2, conflict, fusionRuleS,
																setOfPrimaryTypes, setOfSecondaryTypes,
																atk, dbCursor)
					if conflictInDetail['material1Set']:
						conflictsInDetail.append(conflictInDetail)
					conflictInDetail = generateConflictInDetail(T_1, T_2, result, fusionRuleT,
																S_2, S_1, conflict, fusionRuleS,
																setOfPrimaryTypes, setOfSecondaryTypes,
																atk, dbCursor)
					if conflictInDetail['material1Set']:
						conflictsInDetail.append(conflictInDetail)

	conn.close()
	return conflictsInDetail

####################################################
# SECTION 5: Computing lists from fusion text file #
####################################################

def computeFusionsSymmetricAndSorted():
	generalFusionRules = readFusionRules(False)
	takeSymmetricClosureOfGivenFusionRules(generalFusionRules)
	listOfFusionRulesWithGeneralMaterial1 = [((T_1, T_2), generalFusionRules[(T_1, T_2)]) for (T_1, T_2) in generalFusionRules if T_1[0] == '[']
	sortListOfFusionRules(listOfFusionRulesWithGeneralMaterial1)
	return listOfFusionRulesWithGeneralMaterial1

def computeListOfFusionRuleResults():
	with open(pathTofusionsTXT) as inputfile:
		setOfResults = set()
		for line in inputfile:
			if line.startswith("Conflicts"):
				break
			regExp = re.compile("(.*)=\s*([^(]*)")
			searchResult = regExp.search(line)
			if searchResult != None:
				#print(searchResult.group(2).strip())
				setOfResults.add(searchResult.group(2).strip())
	listOfResults = list(setOfResults)
	listOfResults.sort()
	return listOfResults

#################################
# SECTION 6: Computing SQL code #
#################################

# Returns the SQL code that checks to see if
# the card of the current row of the table called tableAlias is of type T
def computeTypeCondition(T, setOfPrimaryTypes, setOfSecondaryTypes, tableAlias):
	if T[0] == '[' and T[-1] == ']':
		T = T[1:-1]
		if T in setOfSecondaryTypes:
			return f"({tableAlias}.Is{T} = 1)"
		if T in setOfPrimaryTypes:
			return f"({tableAlias}.CardType = '{T}')"
		raise Exception("Invalid primary or secondary type: " + T)
	if T[0] == '{' and T[-1] == '}':
		sqlTypeCondition = ""
		T = T[1:-1]
		T = T.split(',')
		T = [string.strip() for string in T]
		for index, cardName in enumerate(T):
			if index == 0:
				sqlTypeCondition += f"""({tableAlias}.CardName = "{cardName}\""""
			else:
				sqlTypeCondition += f""" OR {tableAlias}.CardName = "{cardName}\""""
		sqlTypeCondition += ')'
		return sqlTypeCondition
	if any(c in '{}[],' for c in T):
		raise Exception("Invalid type: " + T)
	return f'({tableAlias}.CardName = "{T}")'

def computeTypeConditions(T_1, T_2, setOfPrimaryTypes, setOfSecondaryTypes, tableAlias1, tableAlias2):
	firstCondition = computeTypeCondition(T_1, setOfPrimaryTypes, setOfSecondaryTypes, tableAlias1)
	secondCondition = computeTypeCondition(T_2, setOfPrimaryTypes, setOfSecondaryTypes, tableAlias2)
	return f"({firstCondition} AND {secondCondition})"

def computePartialAtkCondition(T_1, result, atk, T_1AttackCol):
	sqlCode = ""
	resultAtk = atk[result]
	if resultAtk == 0:
		return f"({T_1AttackCol} >= 0)" # always evaluates to true
	sqlCode = f"( {T_1AttackCol} < {resultAtk} )"
	return sqlCode

def computeAtkCondition(T_1, T_2, result, fusionRule, atk, T_1AttackCol, T_2AttackCol):
	fusionsWithoutAtkRestriction = { 
	('Warrior Elimination',  'Zanki'),
	('Battle Ox',  'Dragon Statue'),
	('Dragon Piper',  'Orion the Battle King'),
	('Monster Egg',  'The Wicked Worm Beast'),
	('Cyber Shield',  'Monster Tamer'),
	('Crass Clown',  'Final Flame'),
	('Crawling Dragon',  'Dragon Capture Jar'),
	('Jirai Gumo',  'Metalmorph'),
	('Koumori Dragon',  'Saggi the Dark Clown'),
	('Clown Zombie',  'Kojikocy'),
	('Dream Clown',  'Mysterious Puppeteer'),
	('Ancient Jar',  'Fiend Sword'),
	('Gyakutenno Megami',  'Weather Control'),
	('Armored Zombie',  'Wood Clown') }
	sqlCode = ""
	resultAtk = atk[result]
	if resultAtk == 0:
		return f"({T_1AttackCol} >= 0)" # always evaluates to true
	if (T_1, T_2) in fusionsWithoutAtkRestriction or (T_2, T_1) in fusionsWithoutAtkRestriction:
		return f"({T_2AttackCol} >= 0)" # always evaluates to true
	atkOfCardBefore = -1
	for resultWithConflicts in fusionRule:
		if resultWithConflicts[0] != result:
			atkOfCardBefore = atk[resultWithConflicts[0]]
		else:
			break
	sqlCode = f"( {T_1AttackCol} < {resultAtk} AND {T_2AttackCol} < {resultAtk}"
	if atkOfCardBefore > 0:
		sqlCode += f" AND ({T_1AttackCol} >= {atkOfCardBefore} OR {T_2AttackCol} >= {atkOfCardBefore})"
	sqlCode += ' )'
	return sqlCode

def computeNameInSetCondition(setOfCards, cardNameColumn):
	nameInSetCondition = f"{cardNameColumn} IN ("
	for index, card in enumerate(setOfCards):
		if index == 0:
			nameInSetCondition += f'"{card}"'
		else:
			nameInSetCondition += f', "{card}"'
	nameInSetCondition += ')'
	return nameInSetCondition

##############################################
# SECTION 7: Changing python data structures #
##############################################

def takeSymmetricClosureOfGivenFusionRules(givenFusionRules):
	for (T_1, T_2) in list(givenFusionRules):
		givenFusionRules[(T_2, T_1)] = givenFusionRules[(T_1, T_2)]

def sortListOfFusionRules(listOfFusionRules):
	listOfFusionRules.sort(key=itemgetter(0))

#####################################################################
# SECTION 8: Computing ordinary strings from python data structures #
#####################################################################

def shortenGS(guardianStar):
	if guardianStar == None:
		return 'NUL'
	if guardianStar == 'Mercury':
		return 'Mrc'
	if guardianStar == 'Sun':
		return 'Sun'
	if guardianStar == 'Moon':
		return 'Mon'
	if guardianStar == 'Venus':
		return 'Vns'
	if guardianStar == 'Mars':
		return 'Mrs'
	if guardianStar == 'Jupiter':
		return 'Jpt'
	if guardianStar == 'Saturn':
		return 'Stn'
	if guardianStar == 'Uranus':
		return 'Urn'
	if guardianStar == 'Pluto':
		return 'Plt'
	if guardianStar == 'Neptune':
		return 'Npt'
	raise Exception('shortenGS: Invalid Guardian Star: ' + guardianStar)

def cardNameWithAtkDefGS(cardName, cardsInfo):
	return (cardName + 
			    ' (' + str(cardsInfo[cardName]['Attack']) + '/' 
			      	 + str(cardsInfo[cardName]['Defense']) + ' '
			      	 + shortenGS(cardsInfo[cardName]['GuardianStar1']) + '/'
			       	 + shortenGS(cardsInfo[cardName]['GuardianStar2']) + ')'
		   )


#######################
# SECTION 9: Printing #
#######################

def printResultsWithConflictsExceptFirstResult(resultsWithConflicts):
	cardsInfo = readCardsInfo()
	for resultIndex, resultWithConflicts in enumerate(resultsWithConflicts):
		if resultIndex != 0:
			print(' ' * OFFSET_FUSION_EQUALS_SIGN + '= ' + cardNameWithAtkDefGS(resultWithConflicts[0], cardsInfo))
		conflicts = resultWithConflicts[1:]
		for conflictIndex, conflict in enumerate(conflicts):
			if conflictIndex == 0: # conflict is the first conflict
				if conflictIndex < len(conflicts) - 1: # conflict is first and not last
					print(' ' * OFFSET_FUSION_LESSTHAN_SIGN + '< ' + cardNameWithAtkDefGS(conflict, cardsInfo) + ',') # print the first conflict
				else: # conflict is first and last
					print(' ' * OFFSET_FUSION_LESSTHAN_SIGN + '< ' + cardNameWithAtkDefGS(conflict, cardsInfo))
			else: # conflict is not first
				if conflictIndex < len(conflicts) - 1: # conflict is not first and not last
					print(' ' * OFFSET_FUSION_LESSTHAN_SIGN + '  ' + cardNameWithAtkDefGS(conflict, cardsInfo) + ',') # print the first conflict
				else: # conflict is not first and is last
					print(' ' * OFFSET_FUSION_LESSTHAN_SIGN + '  ' + cardNameWithAtkDefGS(conflict, cardsInfo))
	print()
		
def printListOfFusionRules(listOfFusionRules):
	cardsInfo = readCardsInfo()
	for ((T_1, T_2), resultsWithConflicts) in listOfFusionRules:
		# if T_1[0] != '[':
		# 	continue
		T_1plusT_2 = (T_1 + ' + ' + T_2).ljust(OFFSET_FUSION_EQUALS_SIGN)
		if len(T_1plusT_2) <= OFFSET_FUSION_EQUALS_SIGN:
			print(T_1plusT_2 + '= ' + cardNameWithAtkDefGS(resultsWithConflicts[0][0], cardsInfo))
		else:
			print(T_1plusT_2)
			print(' ' * OFFSET_FUSION_EQUALS_SIGN + '= ' + cardNameWithAtkDefGS(resultsWithConflicts[0][0], cardsInfo))
		printResultsWithConflictsExceptFirstResult(resultsWithConflicts)



def printFusionsSymmetricAndSorted():
	fusionsSymmetricAndSorted = computeFusionsSymmetricAndSorted()
	printListOfFusionRules(fusionsSymmetricAndSorted)

def printCardsOfEachType():
	fusionRules = readFusionRules(wantExactFusions = True)
	referencedSetsOfCards = sorted(list(computeReferencedSetsOfCards(fusionRules)))
	setOfPrimaryTypes = computePrimaryTypes()
	setOfSecondaryTypes = computeSecondaryTypes()

	conn = sqlite3.connect(pathToYFMDB)
	dbCursor = conn.cursor()
	for T in referencedSetsOfCards:
		if T[0].isalpha() or T[0] == '{':
			continue
		print('-' * len(T))
		print(T)
		print('-' * len(T))
		typCondition = computeTypeCondition(T, setOfPrimaryTypes, setOfSecondaryTypes, 'C1')

		for (cardName) in sorted(list(dbCursor.execute(f"""SELECT CardName
	FROM Cards AS C1
	WHERE {typCondition}
	"""))):
			print(cardName[0])
		print()

	conn.close()


def printCardTypesByCard():
	conn = sqlite3.connect(pathToYFMDB)
	dbCursor = conn.cursor()

	for (cardName, cardSecTypes) in dbCursor.execute("""SELECT CardName, CardSecTypes
FROM Cards
WHERE TotalSecTypes > 0
ORDER BY CardName ASC"""):
		print(cardName.ljust(OFFSET_CARD_SEC_TYPES), '|', cardSecTypes)


	conn.close()




def printConflictsInDetail(conflictsInDetail):
	for conflictInDetail in conflictsInDetail:
		print(conflictInDetail['T_1'].ljust(25) + ' + ' + conflictInDetail['T_2'] + ' = ' + conflictInDetail['result'])
		print(conflictInDetail['S_1'].ljust(25) + ' + ' + conflictInDetail['S_2'] +  ' < ' + conflictInDetail['conflict'])
		mat1it = iter(sorted(list(conflictInDetail['material1Set'])))
		mat2it = iter(sorted(list(conflictInDetail['material2Set'])))
		material1SetDone = False
		material2SetDone = False
		while(not material1SetDone or not material2SetDone):
			try:
				mat1 = next(mat1it)
			except StopIteration:
				material1SetDone = True
				mat1 = ''
			try:
				mat2 = next(mat2it)
			except StopIteration:
				material2SetDone = True
				mat2 = ''
			print(mat1.ljust(25) + '   ' + mat2)
		print()



# if whatTestToDo == 'materials fuse to conflict when atkConditionS holds'
# this function verifies that each pair (material1, material2) listed
# in each conflictInDetail fuses to conflict provided the attack condition
# of the fusion S_1 + S_2 = conflict holds.
# 
# if whatTestToDo == "what happens when materials don't fuse to conflict"
# for each pair (material1, material2) listed in conflictInDetail
# that doesn't fuse to conflict, this function prints what the pair fuses to
def verifyConflictsInDetail(conflictsInDetail, whatTestToDo):
	conn = sqlite3.connect(pathToYFMDB)
	dbCursor = conn.cursor()

	atk = readCardAtks()

	dbCursor.execute("""CREATE TEMPORARY TABLE FusionsAndNonFusions AS
SELECT C1.Cardname AS Material1Name, C1.Attack AS Material1Attack, 
       C2.CardName AS Material2Name, C2.Attack AS Material2Attack,
       ResultName
FROM Cards AS C1
JOIN Cards AS C2
LEFT JOIN FusionsPlus
ON   Material1Name = C1.CardName AND Material2Name = C2.CardName""")

	for conflictInDetail in conflictsInDetail:
		T_1 = conflictInDetail['T_1']
		T_2 = conflictInDetail['T_2']
		result = conflictInDetail['result']
		fusionRuleT = conflictInDetail['fusionRuleT']
		S_1 = conflictInDetail['S_1']
		S_2 = conflictInDetail['S_2']
		conflict = conflictInDetail['conflict']
		fusionRuleS = conflictInDetail['fusionRuleS']
		material1Set = conflictInDetail['material1Set']
		material2Set = conflictInDetail['material2Set']


		atkConditionT = computeAtkCondition(T_1, T_2, result, fusionRuleT, atk, 'Material1Attack', 'Material2Attack')
		atkConditionS = computeAtkCondition(S_1, S_2, conflict, fusionRuleS, atk, 'Material1Attack', 'Material2Attack')

		nameInSetCondition1 = computeNameInSetCondition(material1Set, 'Material1Name')
		nameInSetCondition2 = computeNameInSetCondition(material2Set, 'Material2Name')

		# T_1 + T_2 = result (atk condition may not be satisfied)
		# S_1 + S_2 = conflict (atk condition may not be satisfied)
		# material1 + material2 = conflict

		printConflictsInDetail([conflictInDetail])
		if whatTestToDo == 'materials fuse to conflict when atkConditionT holds':
			for (material1, material2, resultName) in dbCursor.execute(f"""SELECT Material1Name, Material2Name, ResultName
FROM FusionsAndNonFusions
WHERE (ResultName IS NULL OR ResultName <> "{conflict}") AND
{nameInSetCondition1} AND {nameInSetCondition2} AND
{atkConditionT}"""):
				print("Mistake: ", end='')
				print(material1, ' ', material2, ' ', resultName)

		elif whatTestToDo == 'materials fuse to conflict when atkConditionS holds':
			for (material1, material2, resultName) in dbCursor.execute(f"""SELECT Material1Name, Material2Name, ResultName
FROM FusionsAndNonFusions
WHERE (ResultName IS NULL OR ResultName <> "{conflict}") AND
{nameInSetCondition1} AND {nameInSetCondition2} AND
{atkConditionS}"""):
				print("Mistake: ", end='')
				print(material1, ' ', material2, ' ', resultName)

		elif whatTestToDo == "what happens when materials don't fuse to conflict":
			for (material1, material2, resultName) in dbCursor.execute(f"""SELECT Material1Name, Material2Name, ResultName
	FROM FusionsAndNonFusions
	WHERE (ResultName IS NULL OR ResultName <> "{conflict}") AND
	{nameInSetCondition1} AND {nameInSetCondition2}"""):
				assert resultName in ['Dragon Statue', 'Dragoness the Wicked Knight', 'D. Human', 'Sword Arm of Dragon']
				assert conflict in ['Dragon Statue', 'Dragoness the Wicked Knight', 'D. Human', 'Sword Arm of Dragon']
				print("WhatHappened: ", end='')
				print(material1, ' ', material2, ' ', resultName)
		elif whatTestToDo == "atkConditionT holds":
			for (material1, material2, resultName) in dbCursor.execute(f"""SELECT Material1Name, Material2Name, ResultName
	FROM FusionsAndNonFusions
	WHERE (NOT {atkConditionT}) AND
	{nameInSetCondition1} AND {nameInSetCondition2}"""):
				print("WhatHappened: ", end='')
				print(material1, ' ', material2, ' ', resultName)
		elif whatTestToDo == "materials satisfy atkConditionT":
			for (material1, material2, resultName) in dbCursor.execute(f"""SELECT Material1Name, Material2Name, ResultName
FROM FusionsAndNonFusions
WHERE 
{nameInSetCondition1} AND {nameInSetCondition2} AND
(NOT {atkConditionT})"""):
				print("Mistake: ", end='')
				print(material1, ' ', material2, ' ', resultName)
		else:
			raise Exception('Invalid whatTestToDo')

	conn.close()

def printFusionsInYFMDBNotInFusionsTXT():
	fusionResults = computeListOfFusionRuleResults()
	conn = sqlite3.connect(pathToYFMDB)
	dbCursor = conn.cursor()
	for (material1Name, material2Name, resultName) in dbCursor.execute("""SELECT Material1Name, Material2Name, ResultName
FROM FusionsPlus"""):
		if resultName not in fusionResults:
			material1 = material1Name.ljust(25)
			material2 = material2Name.ljust(25)
			result = resultName
			print(material1 + "+ " + material2 + "= " + result)
	conn.close()