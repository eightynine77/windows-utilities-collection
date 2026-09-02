@echo off
if "%~1"=="" (
    echo Usage: %~nx0 ^<file you want to edit^>
    goto :EOL
)

notepad "%~1"