@echo off
setlocal enabledelayedexpansion

if "%~1" == "" (
    echo Usage: %~nx0 ^<PowerShell command^>
    exit /b
)

for %%a in (%*) do set "powershell_command=!powershell_command! %%a "

powershell -command "!powershell_command:~0,-1!"