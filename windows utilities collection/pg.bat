@echo off
if "%~1"=="" (
    echo Usage: %~nx0 ^<website domain^>
    echo.
    echo example: pg example.com
    exit /b
)

"C:\Windows\System32\PING.EXE" "%~1"