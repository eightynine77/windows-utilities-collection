@echo off
rem gitutils
title gitaccount
if "%*"=="" (
    echo No arguments provided.
    echo.
echo usage: gitaccount [your account name] [your account email]
echo.
echo for example: gitaccount linus-torvalds linus_torvalds@email.com
    goto :end
)

if exist ".git\" (
git config user.name "%1"
git config user.email "%2"
echo.
echo done!
exit /b
) else (
echo you are not in a github repo...
)

:end