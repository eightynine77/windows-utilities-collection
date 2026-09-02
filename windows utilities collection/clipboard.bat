@echo off
if "%*"=="" (
    echo Usage: clip ^<text to copy^>
    echo.
    echo example: clip [an example text]
    exit /b
)

cmd /c echo %* | clip
echo text copied!