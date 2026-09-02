@echo off
if "%~1"=="" (
    echo Usage: hashcheck ^<the file you want to check its SHA256 hash^>
    exit /b
)

CertUtil -hashfile "%~1" SHA256