setlocal
cd %~dp0 
del createAllTablesAndViews.sql
:: Generate and concatenate SQL files in each directory
call "Core tables\concatenateSQLfiles".bat
call "CardClassification\generateAndConcatenateSQLFiles".bat
call "Views\concatenateSQLfiles".bat
call "CardEquippability\generateSQLFiles".bat

:: Concatenate the results of the above concatenations
type "Core tables\createAllCoreTables.sql" >> createAllTablesAndViews.sql
echo. >> createAllTablesAndViews.sql
echo. >> createAllTablesAndViews.sql
type "CardClassification\createCardClassification.sql" >> createAllTablesAndViews.sql
echo. >> createAllTablesAndViews.sql
echo. >> createAllTablesAndViews.sql
type "Views\createAllViews.sql" >> createAllTablesAndViews.sql
echo. >> createAllTablesAndViews.sql
echo. >> createAllTablesAndViews.sql
type "CardObtainment\createObtainmentColumns.sql" >> createAllTablesAndViews.sql
echo. >> createAllTablesAndViews.sql
echo. >> createAllTablesAndViews.sql
type "CardEquippability\equippedBy.sql" >> createAllTablesAndViews.sql



