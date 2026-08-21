@echo off
setlocal enabledelayedexpansion
if "%~1" == "" (
    echo install a python package
echo.
    echo Usage: pipin ^<python package name^>
    exit /b
)

for %%a in (%*) do set "powershell_command=!powershell_command! %%a "

pip install "!powershell_command:~0,-1!"