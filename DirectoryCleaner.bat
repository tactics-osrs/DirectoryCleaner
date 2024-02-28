@echo off
REM Script Name: DirectoryCleaner
REM Date Written: February 27, 2024
REM Written By: Tactics

color 0A

:start
set "dir="
echo Please enter the directory you want to clear or 'help':
set /p "dir="
if /I "%dir%"=="help" goto Help
REM Failsafe for critical system directories
if "%dir%"=="C:\Windows\System32" (
    echo Error: You cannot clear this directory.
    pause
    goto start
)
if not exist "%dir%" (
    echo Error: Directory does not exist. Please input an existing Directory.
	echo See 'help' for more information on how to find directories.
	echo.
    pause
    goto start
)
echo You have chosen to clear the directory: "%dir%"
set /p "confirm=Is this correct? (YES/NO): "
if /I "%confirm%"=="NO" goto start
cd /d "%dir%"
echo Setting directory to "%dir%"...
echo.
echo Obtaining list of all files in the directory...
echo.
REM Get a list of all files in the directory
for /r %%i in (*) do (
    echo %%~nxi >> filelist.txt
)

echo Deleting all files in "%dir%"...
echo.
REM Delete all files in the directory
del /q *

echo Recreating the files for "%dir%"...
echo.
REM Recreate the files
if exist filelist.txt (
    for /f "delims=" %%i in (filelist.txt) do (
        copy nul "%%i"
    )
)

echo Deleting temporary file list of "%dir%"...
echo.
REM Delete the file list
if exist filelist.txt (
    del filelist.txt
)
echo Successfully cleared "%dir%"
echo.
Pause
goto Start

:Help
echo This script deletes all files in a specified directory and then recreates them as empty files.
echo.
echo To find the directory location of a file, right-click the file, select 'Properties', and look for 'Location'.
echo.
echo When you run this script, it will ask you to enter the directory you want to clear.
echo.
echo After you enter the directory, the script will delete all files in that directory and its subdirectories.
echo Then, it will recreate each file as an empty file automatically and instantly.
echo.
echo Please note that this script will only recreate files, not directories.
echo.
echo Also, the recreated files will be empty - any data they contained will be lost.
echo.
echo Be sure to back up any important data before running this script.
echo.
Pause
goto Start
