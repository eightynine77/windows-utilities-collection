@echo off
if "%~1"=="" (
  echo Usage:  pipe ^| %~nx0 search words here
  echo.
  echo for example: dir ^| filter banana box.jpg
  exit /b 1
)

rem Use %* (all arguments) as a single quoted search phrase
findstr /c:"%*"