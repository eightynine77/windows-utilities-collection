@echo off
if "%~1"=="" (
    echo Usage: locdet [file or folder path]
    echo.
    echo example
    echo ================
    echo folder directory: locdet "C:\example folder"
    echo file directory: locdet C:\example file.txt
    exit /b
)

set "input=%*"

echo %input% | findstr /C:"\"" 
if %errorlevel% equ 0 (
  set "input=%input:"=%"
)

if exist "%input%\" (
    echo [FOUND FOLDER]: %input% exists!
    goto :done
)

if exist "%input%" (
    echo [FOUND FILE]: %input% exists!
    goto :done
)

echo "%input%" doesn't exist :(
goto :done

:done
echo.
echo Press any key to close this window...
pause >nul
exit /b