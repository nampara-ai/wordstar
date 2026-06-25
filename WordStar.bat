@echo off
REM Double-click me to launch WordStar 4.0 on Windows.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0native\lib\launch.ps1"
if errorlevel 1 (
  echo.
  echo WordStar could not start. See the message above.
  pause
)
