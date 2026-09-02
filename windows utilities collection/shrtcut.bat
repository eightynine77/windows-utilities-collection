:: NOTE: there are two ways to use this script.
:: 1. use it directly by calling the script, like this: call shrtcut.bat "shortcut-file.lnk"
:: 2. use the shortcut.bat file, like this: shortcut.bat "shortcut-file.lnk"
@echo off
setlocal

set "SHORTCUT=%~f1"

for /f "delims=" %%A in ('powershell -NoProfile -Command "$p=$env:SHORTCUT; if (-not (Test-Path -LiteralPath $p -PathType Leaf)) { exit 2 }; $s=New-Object -ComObject WScript.Shell; $t=$s.CreateShortcut($p).TargetPath; if ([string]::IsNullOrWhiteSpace($t)) { exit 3 }; if (Test-Path -LiteralPath $t -PathType Container) { (Resolve-Path -LiteralPath $t).Path } elseif (Test-Path -LiteralPath $t -PathType Leaf) { (Resolve-Path -LiteralPath (Split-Path -LiteralPath $t -Parent)).Path } else { $d=Split-Path -LiteralPath $t -Parent; if ($d) { [IO.Path]::GetFullPath($d) } }"') do set "TARGET=%%A"

if not defined TARGET (
    echo Failed to resolve shortcut: "%~1"
    endlocal
    exit /b 1
)

cd /d "%TARGET%"

endlocal & cd /d "%TARGET%"