@echo off
if "%~1"=="" (
    echo Usage: %~nx0 ^<PowerShell script file^>
    exit /b
)

powershell -ExecutionPolicy Bypass -File "%~1".ps1