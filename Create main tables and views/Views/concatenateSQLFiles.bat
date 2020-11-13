setlocal
cd "%~dp0"
del createAllViews.sql

for %%I in (*.sql) do (
    type "%%I" >> createAllViews.sql
    echo. >> createAllViews.sql
    echo. >> createAllViews.sql
)