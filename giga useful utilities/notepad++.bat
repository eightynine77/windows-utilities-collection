@echo off
rem this script is for opening notepad++ program
rem more info: https://notepad-plus-plus.org/

set "FILE=%~1"
if defined FILE (
    cd /D "%~dp1"
)

start "" "[ADD YOUR FULL PATH TO notepad++.exe HERE]" "%FILE%"