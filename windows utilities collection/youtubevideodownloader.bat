@echo off
setlocal enabledelayedexpansion
cls
color 0f

:: Check for the cookies parameter
if /I "%~1"=="--cookies" goto :cookiesMenu
if /I "%~1"=="-c" goto :cookiesMenu

:: Load cookie settings if the file exists
set "COOKIES_PARAM="
if exist "%~dp0ytdownloader.settings" (
    for /f "tokens=1,2 delims==" %%A in ('type "%~dp0ytdownloader.settings"') do (
        if "%%A"=="cookiesPath" (
            set "COOKIES_PARAM=--cookies %%B"
        )
    )
)

if exist "%~dp0yt-dlp.exe" (
    set "YTDLP=%~dp0yt-dlp.exe"
) else (
    where yt-dlp >nul 2>&1
    if errorlevel 1 (
        echo.
        echo Error: yt-dlp not found!
        echo Make sure yt-dlp.exe is in the same folder OR added to PATH.
        pause
        exit /b
    ) else (
        set "YTDLP=yt-dlp"
    )
)

set "HAS_FFMPEG=0"
if exist "%~dp0ffmpeg.exe" (
    set "FFMPEG=%~dp0ffmpeg.exe"
    set "HAS_FFMPEG=1"
) else (
    where ffmpeg >nul 2>&1
    if errorlevel 1 (
      echo.
        echo note: ffmpeg not found.
        echo.
        echo you can continue using this script to download youtube videos but you can't download
        echo youtube videos with thumnail
        echo.
        echo if you want to download youtube videos with thumbnail, download ffmpeg: https://ffmpeg.org/download.html
        echo and put ffmpeg in the same folder as this script OR added to the windows environment PATH variable
        goto :input
    ) else (
        set "FFMPEG=ffmpeg"
        set "HAS_FFMPEG=1"
    )
)

IF EXIST "%~dp0download folder\" (
  goto :input
) ELSE (
  mkdir "download folder"
  goto :input
)

:input
cd "%~dp0download folder\"
title piepod - youtube video downloader
echo.
echo.
echo =====================================
echo   piepod - youtube video downloader
echo =====================================
echo.
set /p "url=the youtube video URL you want to download: "
goto :thumbnailChoice

:thumbnailChoice
echo.
echo.
echo Choose an option:

if "!HAS_FFMPEG!"=="1" (
    powershell -NoProfile -Command ^
      "Write-Host '[1] Download video ' -NoNewline; " ^
      "Write-Host 'with' -ForegroundColor Yellow -NoNewline; " ^
      "Write-Host ' thumbnail';" ^
      "Write-Host '[2] Download video ' -NoNewline; " ^
      "Write-Host 'without' -ForegroundColor Red -NoNewline; " ^
      "Write-Host ' thumbnail'"
    echo.
    echo.
    CHOICE /C 12 /N /M "Enter your choice (1 or 2): "
    if errorlevel 2 goto :DownloadWithoutThumbnail
    if errorlevel 1 goto :DownloadWithThumbnail
) else (
    powershell -NoProfile -Command ^
      "Write-Host '[1] Download video ' -NoNewline; " ^
      "Write-Host 'with' -ForegroundColor Yellow -NoNewline; " ^
      "Write-Host ' thumbnail ' -NoNewline;" ^
      "write-host '(unavailable)' -ForegroundColor red;" ^
      "Write-Host '[2] Download video ' -NoNewline; " ^
      "Write-Host 'without' -ForegroundColor Red -NoNewline; " ^
      "Write-Host ' thumbnail'"
    echo.
    echo.
    echo WARNING: since you don't have ffmpeg put in the same folder as this script OR added to the windows environment PATH variable then you cannot download youtube videos with thumbnail.
    echo.
    powershell -NoProfile -Command ^
      "Write-Host 'you can download ffmpeg here: ' -NoNewline; " ^
      "Write-Host 'https://ffmpeg.org/download.html' -ForegroundColor cyan -NoNewline;" ^
      "Write-Host '';" ^
      "Write-Host '' "
    echo.
    CHOICE /C 2 /N /M "Enter your choice: "
    goto :DownloadWithoutThumbnail
)
goto :theend


:ListFormats
echo.
echo Listing available formats for %url%
echo ===================================
echo.
echo.
%YTDLP% %COOKIES_PARAM% -F %url%
exit /b

:DownloadWithThumbnail
call :ListFormats
echo.
echo.
echo.
echo Enter the format code to download.
echo.
powershell -NoProfile -Command ^
  "Write-Host 'how to use: ' -NoNewline; " ^
  "Write-Host '[VIDEO FORMAT NUMBER]' -ForegroundColor green -NoNewline;" ^
  "Write-Host '+' -NoNewLine;" ^
  "write-host '[AUDIO FORMAT NUMBER] ' -ForegroundColor green;" ^
  "write-host ' ';" ^
  "write-host 'for example: ' -nonewline; " ^
  "write-host '298+140' -ForegroundColor green"
echo.
set /p format="the format code: "
echo.
echo downloading with thumbnail...
echo.
%YTDLP% %COOKIES_PARAM% -f %format% --embed-thumbnail %url%
goto :theend

:DownloadWithoutThumbnail
call :ListFormats
echo.
echo.
echo.
echo Enter the format code to download.
echo.
powershell -NoProfile -Command ^
  "Write-Host 'how to use: ' -NoNewline; " ^
  "Write-Host '[VIDEO FORMAT NUMBER]' -ForegroundColor green -NoNewline;" ^
  "Write-Host '+' -NoNewLine;" ^
  "write-host '[AUDIO FORMAT NUMBER] ' -ForegroundColor green;" ^
  "write-host ' ';" ^
  "write-host 'for example: ' -nonewline; " ^
  "write-host '298+140' -ForegroundColor green"
echo.
set /p format="the format code: "
echo.
echo downloading...
echo.
%YTDLP% %COOKIES_PARAM% -f %format% %url%
goto :theend

:theend
echo.
echo Download completed.
echo.
echo.
echo you can find your download youtube videos in:
powershell -Command "Write-Host '%~dp0download folder' -ForegroundColor cyan"
echo.
echo press any key to close this script...
pause >nul
goto :eof

:cookiesMenu
cls
echo cookies settings
echo A) enable cookies
echo S) change cookies file path
echo D) disable cookies
echo W) exit
echo.
CHOICE /C ASDW /N /M "press letter keys on the menu to choose: "
if errorlevel 4 goto :EOL
if errorlevel 3 goto :disableCookies
if errorlevel 2 goto :changeCookies
if errorlevel 1 goto :enableCookies

:enableCookies
cls
echo enter the path to your cookies file.
echo note: make sure you use quotations for your cookiesfile path. for example: "C:\example\directory\cookies.txt"
echo.
echo type "back"/"b" to go back.
set /p "cookie_path=> "

if /I "%cookie_path%"=="back" goto :cookiesMenu
if /I "%cookie_path%"=="b" goto :cookiesMenu

:: Create a temporary file containing the regex pattern
set "cookie_regex_file=%TEMP%\cookie_quote_%RANDOM%_%RANDOM%.txt"
> "!cookie_regex_file!" echo(".*"

:: Validate that the input starts and ends with a double quote
echo(!cookie_path!| findstr /r /x /g:"!cookie_regex_file!" >nul
set "cookie_path_is_quoted=!errorlevel!"

:: Remove the temporary regex file
del "!cookie_regex_file!" >nul 2>&1

if not "!cookie_path_is_quoted!"=="0" (
    echo.
    echo error: your path must start and end with a quotation mark.
    pause
    goto :enableCookies
)

echo cookiesPath=!cookie_path!> "%~dp0ytdownloader.settings"
echo.
echo settings saved successfully.
pause
goto :cookiesMenu

:changeCookies
if not exist "%~dp0ytdownloader.settings" (
    echo.
    echo settings file not found. enable cookies first.
    pause
    goto :cookiesMenu
)
start notepad "%~dp0ytdownloader.settings"
goto :cookiesMenu

:disableCookies
if not exist "%~dp0ytdownloader.settings" (
    echo.
    echo settings file not found. cookies are already disabled.
    pause
    goto :cookiesMenu
)
echo.
CHOICE /C YN /N /M "do you want to disable cookies? [Y / N]: "
if errorlevel 2 goto :cookiesMenu
if errorlevel 1 (
    del "%~dp0ytdownloader.settings"
    echo.
    echo cookies disabled. settings file deleted.
    pause
    goto :cookiesMenu
)

:EOL
