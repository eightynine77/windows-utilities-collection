@echo off
setlocal enabledelayedexpansion
if "%~1" == "" (
    echo uninstall a dotnet workload package
echo.
    echo Usage: dotnetuninstall ^<dotnet workload package name^>
    exit /b
)

for %%a in (%*) do set "powershell_command=!powershell_command! %%a "

dotnet workload uninstall "!powershell_command:~0,-1!"