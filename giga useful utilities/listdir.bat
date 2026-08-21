@echo off
powershell -Command "Get-ChildItem -Force | Sort-Object -Property CreationTime -Descending"