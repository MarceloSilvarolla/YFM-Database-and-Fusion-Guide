import sys 
import os
sys.path.append(os.path.relpath(".."))
from fusionManipulation import *

atk = readCardAtks()
defense = readCardDefs()

def sortListOfFusionRulesBy(listOfFusionRules, functionOfCard):
	listOfFusionRules.sort(key=lambda item : functionOfCard(item[1][-1][0]), reverse=True)

def printFusionsSortedBy(functionOfCard):
	fusions = readFusionRules(wantExactFusions = True)
	listOfFusions = [(materials, fusions[materials]) for materials in fusions]
	sortListOfFusionRulesBy(listOfFusions, functionOfCard)
	# for item in listOfFusions:
	# 	print(item[1][-1][0])
	printListOfFusionRules(listOfFusions)

def atkFun(card):
	return atk[card]

def defFun(card):
	return defense[card]

def maxAtkDefFun(card):
	return max(atk[card], defense[card])

printFusionsSortedBy(defFun)
