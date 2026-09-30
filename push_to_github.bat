@echo off
setlocal
title Push PGRI Matraman Client ke GitHub
cd /d "%~dp0"

if /i "%~1"=="--check" (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0push_to_github.ps1" -Check
) else (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0push_to_github.ps1"
)
set "RESULT=%ERRORLEVEL%"

echo.
if not "%RESULT%"=="0" (
    echo [ERROR] Proses gagal. Baca pesan di atas.
) else (
    echo [OK] Proses selesai.
)
echo.
pause
exit /b %RESULT%
