setlocal
cd %~dp0
del equippedBy.sql

:: generate SQL file equippedBy.sql
py generateequippedBy.py