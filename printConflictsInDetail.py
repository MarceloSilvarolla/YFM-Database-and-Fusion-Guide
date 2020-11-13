import sys 
import os
sys.path.append(os.path.relpath("."))
from fusionManipulation import *
import pprint

conflictsInDetail = generateConflictsInDetail()
printConflictsInDetail(conflictsInDetail)
