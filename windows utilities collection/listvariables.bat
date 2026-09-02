@echo off
echo here are the list of all your variables.
echo.
echo.
echo user variables
echo.
powershell -NoProfile -Command "Get-ChildItem Env: | Where-Object { $_.Name -in [Environment]::GetEnvironmentVariables('User').Keys } | Sort-Object Name | Format-Table Name, Value"
echo.
echo.
echo ========================
echo system variables
echo.
powershell -NoProfile -Command "Get-ChildItem Env: | Where-Object { $_.Name -in [Environment]::GetEnvironmentVariables('Machine').Keys } | Sort-Object Name | Format-Table Name, Value"