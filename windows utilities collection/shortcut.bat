@echo off

if "%~1"=="" (
    echo Usage: shortcut "shortcut.lnk"
    echo.
    echo using this script will change the directory to your shortcut file's directory
    exit /b 1
)

call "%~dp0shrtcut.bat" %*