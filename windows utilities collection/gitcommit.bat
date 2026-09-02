@echo off
rem gitutils
if "%~1"=="" (
    echo No arguments provided.
    echo.
echo usage: gitcommit [your git commit message]
echo.
echo for example: gitcommit fixed the UI
    goto :end
)

if exist ".git\" (
set "input=%*"
set "msg=%input:"=%"
git add -A
git commit -m "%msg%"
echo.
echo done!
exit /b
) else (
echo you are not in a github repo...
)

:end