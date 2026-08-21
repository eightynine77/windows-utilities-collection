@echo off
if "%~1"=="" (
    echo Usage: %~nx0 ^<the process' name^>
    exit /b
)

set "proc=%~1"

if /i "%proc:~-4%"==".exe" (
    set "target=%proc%"
) else (
    set "target=%proc%.exe"
)

taskkill /f /im "%target%"
echo.
echo press any key to close this script...
pause >nul
