import sys 
import os
import csv
sys.path.append(os.path.relpath("../Test definitively all fusions/"))
from _generateCreatePredictedFusions import *
import networkx as nx
import matplotlib.pyplot as plt
import pprint
import itertools
import random

pathToTypesCSV = os.path.abspath(os.path.join(os.path.dirname(__file__), "Types.csv"))
pathToFusionsCSV = os.path.abspath(os.path.join(os.path.dirname(__file__), "Fusions.csv"))
pathToFusionsWithTypesTXT = os.path.abspath(os.path.join(os.path.dirname(__file__), "FusionsWithTypes.txt"))



fusionRules = readFusionRules(wantExactFusions = False)

def subTypes_v1(T, wantExactCards):
  if T[0] != '[' and not wantExactCards:
    return set()
  return {T}

def subTypes_v2(T, wantExactCards):
  if T == "[Thronian]" or T == "[Sheepian]":
    # assuming Thronian is defined as FiendOrGS1MoonNotMoonEnvoy
    # assuming Sheepian is defined as FiendOrGS1Moon
    return {"[Fiend]"}
  if T == "[Bugrothian]":
    return {"[Turtle]"}
  if T == "[Aqua]":
    return {"[Turtle]"}
  # if T == "[Koumorian]":
  #   # assuming [Koumorian] defined as
  #   # ([GS1MoonNotFairy] u {Kuriboh, Mammoth Graveyard})
  #   return {"[GS1Moon]"}
  if T == "[MercuryMagicUser]" or T == "[Spellcaster]":
    return {"[MercurySpellcaster]"}
  if T == "[Beast]":
    return {"[UsableBeast]"}
  if T == "[FeatherFromMachine]":
    return {"[FeatherFromBear"}

  if T[0] != '[' and not wantExactCards:
    return set()
  return {T}

def generateCSVsForGephiAndTXTForWebGraphVizFromFusionsTXT():
  with open(pathToTypesCSV, 'w+') as typesCSV, open(pathToFusionsCSV, 'w+') as fusionsCSV, \
       open(pathToFusionsWithTypesTXT, 'w+') as fusionsWithTypesTXT:
    atk = readCardAtks()
    typesCSV.write("ID; Label\n")
    fusionsCSV.write("Source; Target; Label\n")
    setOfTypes = set()
    setOfFusions = set()
    materialID = {}
    fusionRulesPlus = {}
    for (T_1, T_2) in fusionRules:
      for T_1subType in subTypes_v1(T_1, wantExactCards = False):
        for T_2subType in subTypes_v1(T_2, wantExactCards = False):
          setOfTypes.add(T_1subType)
          setOfTypes.add(T_2subType)
          setOfFusions.add((T_1subType, T_2subType))
          fusionRulesPlus[(T_1subType, T_2subType)] = fusionRules[(T_1, T_2)]
    listOfTypes = list(setOfTypes)
    listOfTypes.sort()
    for index, T in enumerate(listOfTypes):
      typesCSV.write(f"{index};{T}\n")
      materialID[T] = index
    listOfFusions = list(setOfFusions)
    listOfFusions.sort()
    for (T_1, T_2) in listOfFusions:
      greatestResultAtk = 0
      leastResultAttack = -1
      attacks = []
      for resultWithConflicts in fusionRulesPlus[(T_1, T_2)]:
        greatestResultAtk = atk[resultWithConflicts[0]]
        attacks.append(atk[resultWithConflicts[0]])
        if leastResultAttack == -1:
          leastResultAttack = atk[resultWithConflicts[0]]
      if greatestResultAtk >= 0:
        fusionsCSV.write(f"{materialID[T_1]};{materialID[T_2]};{attacks}\n")
        fusionsWithTypesTXT.write(f"\"{T_1}\" -- \"{T_2}\" [ label = \"{attacks}\"]\n")

def generateCSVsForGephiFromNetworkxGraph(G):
  with open(pathToTypesCSV, 'w+') as typesCSV, open(pathToFusionsCSV, 'w+') as fusionsCSV:
    nodeToIndex = {}
    typesCSV.write("ID; Label\n")
    for index, node in enumerate(sorted(list(G.nodes()))):
      nodeToIndex[node] = index
      typesCSV.write(f"{index};{node}\n")
    fusionsCSV.write("Source; Target; Label\n")
    for node, nbrs in G.adj.items():
      for nbr, eattr in nbrs.items():
        lbl = eattr['label']
        # print(f"({n}, {nbr}, {lbl})").
        if nodeToIndex[node] <= nodeToIndex[nbr]:
          fusionsCSV.write(f"{nodeToIndex[node]};{nodeToIndex[nbr]};{lbl}\n")

def generateNetworkxGraphFromCSVs():
  G = nx.Graph()
  indexToNodeName = []
  with open(pathToTypesCSV) as typesCSV, open(pathToFusionsCSV) as fusionsCSV: 
    readerTypesCSV = csv.reader(typesCSV, delimiter = ';')
    for index, line in enumerate(readerTypesCSV):
      if index > 0:
        G.add_node(line[1])
        indexToNodeName.append(line[1])

    readerFusionsCSV = csv.reader(fusionsCSV, delimiter = ';')
    for index, line in enumerate(readerFusionsCSV):
      if index > 0:
        u = int(line[0])
        v = int(line[1])
        G.add_edge(indexToNodeName[u], indexToNodeName[v], label = line[2])
  
  return G

def printNetworkXGraph(G):
  for n, nbrs in G.adj.items():
          for nbr, eattr in nbrs.items():
            # lbl = eattr['label']
            # print(f"({n}, {nbr}, {lbl})").
            print(f"{n} {nbr}")

def isSupersetOfSome(aTuple, aSetOfTuples):
  for someTuple in aSetOfTuples:
    aTuple_set = set(aTuple)
    someTuple_set = set(someTuple)
    if aTuple_set.issuperset(someTuple_set):
      return True
  return False

# Returns a minimal set of nodes that, once removed, makes G planar
# When G is obtained by using subTypes_v1 without exact fusions
# no set of nodes with 5 or less elements makes G planar when removed
def nodesToRemoveToPlanarizeGraph(G):
  setOfNodeTuplesToRemoveToPlanarizeGraph = set()
  for numberOfNodesToRemove in range(G.number_of_nodes() - 3):
    print(numberOfNodesToRemove)
    for nodesToRemove in itertools.combinations(G.nodes, numberOfNodesToRemove):
      if isSupersetOfSome(nodesToRemove, setOfNodeTuplesToRemoveToPlanarizeGraph):
        break
      H = G.copy()
      for node in nodesToRemove:
        H.remove_node(node)
      (isHPlanar, K) = nx.check_planarity(H, counterexample = False)
      if isHPlanar:
        nodesToRemove_str = re.sub(r'\W+', '', str(nodesToRemove))
        drawPlanarGraph(H, "GraphWithout" + nodesToRemove_str + ".png")
        setOfNodeTuplesToRemoveToPlanarizeGraph.add(nodesToRemove)
  return setOfNodeTuplesToRemoveToPlanarizeGraph

def nodesToRemoveToPlanarizeGraph_greedy(G):
  nodesToRemove = set()
  H = G.copy()
  (isHPlanar, K) = nx.check_planarity(H, counterexample = True)
  while not isHPlanar:
    nodeToRemove = random.choice(list(K.nodes()))
    nodesToRemove.add(nodeToRemove)
    H.remove_node(nodeToRemove)
    (isHPlanar, K) = nx.check_planarity(H, counterexample = True)
  return nodesToRemove


def drawPlanarGraph(G, filename):
  posit = nx.planar_layout(G)

  fig = plt.figure()
  fig.show()

  nx.draw(G, posit , with_labels = True)
  fig.canvas.draw()
  plt.savefig(filename, format="PNG")


def findMaxCliques(G):
  allCliques = []
  for clique in nx.find_cliques(G):
    clique.sort()
    allCliques.append(clique)
  allCliques.sort(key = len, reverse = True)
  for clique in allCliques:
    print(clique)

def contractWarriorZombieDragonPlantRockPyroUsableBeast(G):
  H = nx.contracted_nodes(G, "[Warrior]", "[Zombie]", self_loops=False)
  H = nx.contracted_nodes(H, "[Warrior]", "[Dragon]", self_loops=False)
  H = nx.contracted_nodes(H, "[Warrior]", "[Plant]", self_loops=False)
  H = nx.contracted_nodes(H, "[Warrior]", "[Rock]", self_loops=False)
  H = nx.contracted_nodes(H, "[Warrior]", "[Pyro]", self_loops=False)
  # H = nx.contracted_nodes(H, "[Warrior]", "[UsableBeast]", self_loops=False)
  return H

def removeEdgesAmongWarriorZombieDragonPlantRockPyroUsableBeast(G):
  H = G.copy()
  almostCliqueNodes = ["[Warrior]", "[Zombie]", "[Dragon]", "[Plant]",
                       "[Rock]", "[Pyro]", "[UsableBeast]"]
  
  for edge in itertools.combinations(almostCliqueNodes, 2):
    try:
      H.remove_edge(edge[0], edge[1])
    except:
      pass



  return H

def contractDegreeTwoNodes(G):
  for node in list(G.nodes()):
    if G.degree(node) == 2:
        edges = list(G.edges(node))
        G.add_edge(edges[0][1], edges[1][1])
        G.remove_node(node)
 
generateCSVsForGephiAndTXTForWebGraphVizFromFusionsTXT()
G = generateNetworkxGraphFromCSVs()
print("G has", G.number_of_nodes(), "nodes.")
G = removeEdgesAmongWarriorZombieDragonPlantRockPyroUsableBeast(G)
generateCSVsForGephiFromNetworkxGraph(G)
setOfNodeTuplesToRemoveToPlanarizeGraph = nodesToRemoveToPlanarizeGraph(G)
print(setOfNodeTuplesToRemoveToPlanarizeGraph)
# findMaxCliques(G)
# H = contractWarriorZombieDragonPlantRockPyroUsableBeast(G)
# H = removeEdgesAmongWarriorZombieDragonPlantRockPyroUsableBeast(G)
# print("H:")
# printNetworkXGraph(H)
# (isPlanar, K) = nx.check_planarity(H, counterexample = True)
# print(isPlanar)
# print("")
# if isPlanar:
#   drawPlanarGraph(H)
# else:
#   print("K:")
#   printNetworkXGraph(K)
#   print("")

#   contractDegreeTwoNodes(K)
#   print("contracted K:")
#   printNetworkXGraph(K)

