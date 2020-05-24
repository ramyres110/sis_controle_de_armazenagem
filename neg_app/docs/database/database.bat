@echo off
:: ====================================================
:: Script para criação e configuração de banco de dados
:: para o sistema de Controle de Armazenagem.
:: Autor: Ramyres Aquino @ramyres110
:: Date: 23/05/2020
:: ====================================================
SETLOCAL
echo Checking requirements...
where /q isql
if errorlevel 1 goto not_found_isql
if not exist script_CREATE.sql goto not_found_script_create
if not exist script_DDL.sql goto not_found_script_ddl
if not exist script_USER.sql goto not_found_script_user
if exist ../../data/DATABASE.FDB goto database_exists

echo creating database...
isql < script_CREATE.sql

echo creating tables...
isql < script_DDL.sql

echo insert default user...
isql < script_USER.sql

echo done!
goto end

:not_found_isql
echo ERROR: Interactive SQL Utility - isql - Not Found set then in Environment Variables
goto end

:not_found_script_create
echo ERROR: Create File Not Found - File script_CREATE.sql must be in same folder
goto end

:not_found_script_ddl
echo ERROR: DDL File Not Found - File script_DDL.sql must be in same folder
goto end

:not_found_script_user
echo ERROR: Insert Default User Script Not Found  - File script_USER.sql must be in same folder
goto end

:database_exists
echo ERROR: DATABASE File Exists - The database file is already created
goto end

:end
ENDLOCAL
exit 0