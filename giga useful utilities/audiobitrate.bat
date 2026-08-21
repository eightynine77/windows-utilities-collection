rem
rem NOTE: you must first have downloaded ffprobe
rem
@echo off
if "%~1"=="" (
echo.
echo this tool is used to check the audio quality of an mp4 video
echo.
echo.
    echo Usage: %~nx0 <^mp4 video file^>
    echo.
    echo example: pg video.mp4
    exit /b
)

ffprobe -v error -select_streams a:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "%~1"
