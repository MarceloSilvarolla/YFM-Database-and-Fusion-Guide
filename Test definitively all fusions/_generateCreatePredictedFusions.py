import sqlite3
import re
import sys
import os
from toposort import toposort, toposort_flatten
sys.path.append(os.path.relpath(".."))
from fusionManipulation import *

pathToYFMDB = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "YFM.db"))
pathTofusionsTXT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "fusions.txt"))
pathTocreatePredictedFusionsSQL = os.path.abspath(os.path.join(os.path.dirname(__file__), "createPredictedFusions.sql"))


def generateCreatePredictedFusions():
	with open(pathTocreatePredictedFusionsSQL, 'w+') as outputFile:
		atk = readCardAtks()
		setOfPrimaryTypes = computePrimaryTypes()
		setOfSecondaryTypes = computeSecondaryTypes()

		fusions = readFusionRules(wantExactFusions = True)
		resultToMaterials = computeResultToMaterials(fusions)
		conflictPrecedence = computeDependenceOfFusionResults(fusions)
		topologicalOrder = list(toposort(conflictPrecedence))
		flattened_topoOrder = [card for setOfCards in topologicalOrder for card in setOfCards]

		outputFile.write("""DROP TABLE IF EXISTS PredictedFusions;
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
""")

		for result in flattened_topoOrder:
			outputFile.write(f"""INSERT INTO PredictedFusions
SELECT C1.CardName AS Material1Name, C1.CardType AS Material1Type, C1.CardSecTypes AS Material1SecTypes, C1.Attack AS Material1Attack,
  C2.CardName AS Material2Name, C2.CardType AS Material2Type, C2.CardSecTypes AS Material2SecTypes, C2.Attack AS Material2Attack,
  "{result}" AS PredictedResult
FROM Cards AS C1
JOIN Cards AS C2
WHERE
""")
			# type conditions depend on T_1 and T_2
			# atk conditions depend on the fusion rule
			listOfConflicts = []
			# T_1 + T_2 = result
			for index, (T_1, T_2) in enumerate(resultToMaterials[result]):
				for resultWithConflicts in fusions[(T_1, T_2)]:
					if resultWithConflicts[0] == result:
						# resultWithConflicts == [result, C_1, ..., C_n]
						# where the C_i are the conflicts, that is,
						# cards that take precedence over result
						# when both are candidates for being the outcome of a fusion
						listOfConflicts += resultWithConflicts[1:]
						
						atkCondition = computeAtkCondition(T_1, T_2, result, fusions[(T_1, T_2)], atk,'C1.Attack', 'C2.Attack')
						typeConditions = computeTypeConditions(T_1, T_2, setOfPrimaryTypes, setOfSecondaryTypes, 'C1', 'C2')
						typeConditionsReversed = computeTypeConditions(T_1, T_2, setOfPrimaryTypes, setOfSecondaryTypes, 'C2', 'C1')
						if index > 0:
							outputFile.write("\nOR ")
						outputFile.write("(" + atkCondition + " AND (" + typeConditions + " OR " + typeConditionsReversed + '))')
			for conflict in listOfConflicts:
				outputFile.write(f"""
EXCEPT
SELECT Material1Name, Material1Type, Material1SecTypes, Material1Attack,
	   Material2Name, Material2Type, Material2SecTypes, Material2Attack,
	   "{result}"
FROM PredictedFusions
WHERE PredictedResult = "{conflict}" """)
			outputFile.write(";\n\n")


generateCreatePredictedFusions()