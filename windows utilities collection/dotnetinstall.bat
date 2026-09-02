@echo off
setlocal enabledelayedexpansion
if "%~1" == "" (
    echo installs a dotnet workload package
echo.
    echo Usage: dotnetinstall ^<dotnet workload package name^>
    exit /b
)

for %%a in (%*) do set "powershell_command=!powershell_command! %%a "

dotnet workload install "!powershell_command:~0,-1!"