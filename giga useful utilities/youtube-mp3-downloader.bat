@echo off
setlocal EnableDelayedExpansion

echo ===============================
echo YT-DLP YouTube to MP3 Downloader
echo ===============================

REM Check if yt-dlp.exe exists in current directory
if exist "%~dp0yt-dlp.exe" (
    set "YTDLP=%~dp0yt-dlp.exe"
) else (
    REM Check if yt-dlp is accessible from PATH
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

echo.
set /p url=Enter YouTube URL: 

echo.
echo === Available m4a (MP4) audio formats ===
%YTDLP% -F --cookies cookies.txt %url% | findstr /C:"audio only"

echo ===============================
echo.
set /p format=Enter the audio format code you want to download: 

echo.
echo Downloading format %format% as MP3...
%YTDLP% -f %format% --extract-audio --audio-format mp3 --no-write-thumbnail --no-playlist --cookies cookies.txt "%url%"

echo.
echo Done!
pause
