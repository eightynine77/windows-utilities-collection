@echo off
:home
title pingt - simple internet test
ping google.com
echo.
echo.
echo.
echo simple internet test done!
echo.
echo press [a] key to try again
echo press [b] key to exit
CHOICE /C ab /N /M ">"
if errorlevel 2 goto EOL
if errorlevel 1 goto home
goto home

:EOL