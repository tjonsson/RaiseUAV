@echo off
setlocal

set "PROJECT_DIR=%~dp0"
set "PROJECT_FILE=%PROJECT_DIR%RaiseUAV.uproject"
set "UE_ROOT=C:\Program Files\Epic Games\UE_5.4"
set "RUN_UAT=%UE_ROOT%\Engine\Build\BatchFiles\RunUAT.bat"
set "ARCHIVE_DIR=%PROJECT_DIR%Build\Production"
set "OUTPUT_DIR=%ARCHIVE_DIR%\Windows"
set "CLEAN_ARG="

if /i "%~1"=="clean" set "CLEAN_ARG=-clean"
if /i "%~1"=="-clean" set "CLEAN_ARG=-clean"
if /i "%~1"=="--clean" set "CLEAN_ARG=-clean"

if not exist "%PROJECT_FILE%" (
    echo ERROR: Could not find project file:
    echo   %PROJECT_FILE%
    exit /b 1
)

if not exist "%RUN_UAT%" (
    echo ERROR: Could not find Unreal Automation Tool:
    echo   %RUN_UAT%
    echo.
    echo Update UE_ROOT in this script if Unreal Engine is installed elsewhere.
    exit /b 1
)

echo Building RaiseUAV production package...
echo Project:
echo   %PROJECT_FILE%
echo Archive directory:
echo   %ARCHIVE_DIR%
echo Final packaged build will be written to:
echo   %OUTPUT_DIR%
if defined CLEAN_ARG echo Clean build: enabled
echo.

call "%RUN_UAT%" BuildCookRun ^
    -project="%PROJECT_FILE%" ^
    -noP4 ^
    -target=RaiseUAV ^
    -platform=Win64 ^
    -clientconfig=Shipping ^
    %CLEAN_ARG% ^
    -build ^
    -cook ^
    -allmaps ^
    -stage ^
    -pak ^
    -compressed ^
    -archive ^
    -archivedirectory="%ARCHIVE_DIR%" ^
    -utf8output

if errorlevel 1 (
    echo.
    echo Production build failed.
    exit /b 1
)

echo.
echo Production build complete.
echo Written to:
echo   %OUTPUT_DIR%
