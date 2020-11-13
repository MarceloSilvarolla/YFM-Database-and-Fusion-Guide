import sys 
import os
sys.path.append(os.path.relpath("."))
from fusionManipulation import *
import pprint

conflictsInDetail = generateConflictsInDetail()
verifyConflictsInDetail(conflictsInDetail, "what happens when materials don't fuse to conflict")

