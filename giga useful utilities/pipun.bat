@echo off
setlocal enabledelayedexpansion
if "%~1" == "" (
echo uninstall a python package
echo.
    echo Usage: pipun ^<python package name^>
    exit /b
)

for %%a in (%*) do set "powershell_command=!powershell_command! %%a "

pip uninstall "!powershell_command:~0,-1!"