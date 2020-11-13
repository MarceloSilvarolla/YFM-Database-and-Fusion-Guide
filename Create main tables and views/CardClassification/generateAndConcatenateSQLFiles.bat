setlocal
cd %~dp0
del createCardClassification.sql

:: generate SQL files from setEachSecTypeColumnToOneWhenAppropriate
py generateSQLFilesFromSetEachSecTypeColumnToOneWhenAppropriate.py

:: Concatenate all SQL files in this directory
type "addEachIsColumnSetToZero.sql" >> createCardClassification.sql
echo. >> createCardClassification.sql
echo. >> createCardClassification.sql
type "setEachSecTypeColumnToOneWhenAppropriate.sql" >> createCardClassification.sql
echo. >> createCardClassification.sql
echo. >> createCardClassification.sql
type "createCardSecTypesColumn.sql" >> createCardClassification.sql
echo. >> createCardClassification.sql
echo. >> createCardClassification.sql
type "createTotalSecTypesColumn.sql" >> createCardClassification.sql