The database YFM.db
- can be found in the releases section;
- is the main database that includes everything from FmDatabase.db and FmDatabaseWithGS.db from GenericMadScientist's "RNG Manipulation Script" files (https://www.dropbox.com/s/6dzr5hhokx4e86m/RNG%20Manipulation%20Script.zip?dl=0&file_subpath=%2FRNG+Manipulation+Script);
- is created by running "Create main tables and views"/generateAndConcatenateSQLFiles.bat, attaching the two aforementioned databases to a new database in DB Browser for SQLite (https://sqlitebrowser.org/) and opening and running createAllTablesAndViews.sql within DB Browser

The guide FUSION_GUIDE.txt
- is the fusion guide I posted on GameFAQs (https://gamefaqs.gamespot.com/ps/561010-yu-gi-oh-forbidden-memories/faqs/78677);
- was created by
  - copying and pasting DBirtolo's and Kingtut1's fusion rules into fusions.txt, with some minor modifications
  - adding the missing fusion rules printed by printFusionsNotInBirtolosGuide.py to fusions.txt and manually abstracting some of them into general fusion rules in fusions.txt
  - figuring out the conflicts of each fusion rule by using the SQL code in "Test preliminarily general fusions"
  - copying the fusion rules printed by printFusionsSymmetricAndSorted.py to the general fusion rules section of FUSION_GUIDE.txt
  - copying the exact fusion rules from fusions.txt to the exact fusion rules section of FUSION_GUIDE.txt
  - copying and pasting the output of printConflictsInDetail.py to the conflicts in detail section of FUSION_GUIDE.txt
  - running verifyConflictsInDetail.py to check that pairs of materials in the generated conflicts in detail always fuse to the indicated conflict or some sibling
  - copying and pasting the output of printCardsOfEachType.py to the secondary card types section of FUSION_GUIDE.txt, then manually writing high-level definitions for each secondary card type
  - copying and pasting the output of printCardTypesByCard.py to the secondary card types by card section of FUSION_GUIDE.txt

The guide FUSION_GUIDE_PLUS.txt
- is exactly the FUSION_GUIDE.txt guide plus the primary and secondary types of each fusion result.
- It is not posted to GameFAQs because of the 80-character-per-line limit.

The "Test definitively all fusions" folder
- contains the script _generateCreatePredictedFusions.py that
  - topologically sorts fusion results so that, whenever B is a conflict for A's fusion rule, B comes before A
  - generates the sql file createPredictedFusions.sql, adding fusions rule by rule, where the rules are ordered according to the topological order of their results
- contains the sql file createPredictedFusions.sql that creates a table containing all fusions predicted by the fusion rules in the fusions.txt file

The "Test preliminarily general fusions" folder
- contains SQL code that was used to determine the conflicts of each fusion rule

The "Query database and create temporary tables" folder
- contains useful queries for the database, like getting all drops for a desired set of cards

The "Visualize general and semi-general fusions" folder
- is a work in progress
- contains the script createGraphs.py that creates graphs for NetworkX and Gephi, that can produce visualizations for the graph of fusions, where the vertices are the types of cards and the edges indicate the possibility of fusing the given types

The "ER Diagrams" folder
- contains an ERDPlus file and its PNG output that are Entity-relationship diagrams for visualization of the database.