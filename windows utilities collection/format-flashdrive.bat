@echo off

net session >nul 2>&1
if %errorlevel% neq 0 (
  echo ERROR: This batch script must be run with Administrator privileges.
  echo.
  echo Right-click this batch script and choose "Run as administrator"
  pause
  exit /b 1
)

echo.
echo USB flash drive formater by jebbidan
echo my channel: https://www.youtube.com/jebbidan
echo.
echo ==============================================
echo WARNING: This will ERASE the selected disk!
echo Backup data first. This operation is destructive.
echo ==============================================
echo.
pause

echo Showing disks (look at "Disk ###" and sizes)...
echo list disk > "dp_list.txt"
diskpart /s "dp_list.txt"
del "dp_list.txt"

echo.
set /p DISKNUM=Enter the DISK NUMBER to wipe (e.g. 1) : 

if "%DISKNUM%"=="" (
  echo No disk number entered. Aborting.
  exit /b 1
)

echo.
echo You entered: Disk %DISKNUM%
set /p CONFIRM=Type YES (all caps) to CONFIRM wiping disk %DISKNUM%: 
if /I not "%CONFIRM%"=="YES" (
  echo Aborted by user.
  exit /b 1
)

echo.
echo Creating DiskPart script...
(
  echo select disk %DISKNUM%
  echo clean
  echo create partition primary
  echo select partition 1
  echo active
  echo format fs=fat32 quick
  echo assign
  echo exit
) > "dp_script.txt"

echo Running DiskPart against Disk %DISKNUM%...
diskpart /s "dp_script.txt"

set rc=%errorlevel%
del "dp_script.txt" 2>nul

if %rc%==0 (
  echo.
  echo Done. Disk %DISKNUM% has been wiped, partitioned, formatted (FAT32), and assigned a letter.
) else (
  echo.
  echo DiskPart returned error code %rc%. Check output above for details.
)

pause
exit /b %rc%