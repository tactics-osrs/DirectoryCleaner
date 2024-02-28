@echo off
REM Script Name: DirectoryCleaner
REM Date Written: February 27, 2024
REM Written By: Tactics

color 0A

:start
powershell -Command "Get-Date"
set "dir="
echo Please enter the directory you want to clear or 'help':
set /p "dir="
if /I "%dir%"=="help" goto Help
REM Errorhandling for non-existent directory input
if not exist "%dir%" (
    echo Error: Directory does not exist. Please input an existing Directory.
	echo See 'help' for more information on how to find directories.
	echo.
    pause
    goto start
)
cd /d "%dir%"
echo Setting directory to "%dir%"...
echo.
echo Obtaining list of all files in the directory...
echo.
REM Get a list of all files in the directory
for /r %%i in (*) do (
    echo %%~nxi >> filelist.txt
)

echo Are you sure you want to delete all files in "%dir%"? (Y/N)
set /p "confirm="
if /I "%confirm%"=="Y" (
    echo Deleting all files in "%dir%"...
    echo.
    REM Delete all files in the directory and log the deleted files
    for /r %%i in (*) do (
        echo Deleting %%~nxi >> tempdeletionlog.txt
        del /q "%%i"
    )
) else (
    echo Operation cancelled by user.
    goto start
)

if exist tempdeletionlog.txt (
    echo Do you want to save the log of deleted files? (Y/N)
    set /p "log="
    if /I "%log%"=="Y" (
        move /Y tempdeletionlog.txt deletionlog.txt
    ) else (
        del /q tempdeletionlog.txt
    )
)

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
echo Written by Tactics
echo.
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
echo After you enter the directory, the script will ask for confirmation before deleting the files.
echo Then, it will recreate each file as an empty file automatically and instantly.
echo.
echo Please note that this script will only recreate files, not directories.
echo.
echo Also, the recreated files will be empty - any data they contained will be lost.
echo.
echo Be sure to back up any important data before running this script.
echo.
echo Written by Tactics
echo.
echo.
Pause
goto Start
