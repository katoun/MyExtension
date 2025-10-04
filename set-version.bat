@echo off
REM Set Version Script for MyExtension
REM This script updates the version in VERSION file and plugin.cfg

echo ========================================
echo MyExtension Version Manager
echo ========================================
echo.

REM Get current version
if exist "VERSION" (
    set /p current_version=<VERSION
    echo Current version: %current_version%
) else (
    echo No current version found.
    set current_version=1.0.0
)

echo.
set /p new_version="Enter new version (e.g., 1.0.1): "

if "%new_version%"=="" (
    echo No version entered. Exiting.
    pause
    exit /b 1
)

echo.
echo Updating version to %new_version%...

REM Update VERSION file
echo %new_version% > VERSION
echo Updated VERSION file

REM Update plugin.cfg
if exist "project\addons\myextension\plugin.cfg" (
    echo Updating plugin.cfg...
    
    REM Create temporary file with updated version
    (
        echo [plugin]
        echo name="MyExtension"
        echo description="A GDExtension for Godot 4.5 with example Node and Singleton classes"
        echo author="Catalin Alexandru Nastase"
        echo version="%new_version%"
        echo script=""
    ) > "project\addons\myextension\plugin.cfg"
    
    echo Updated plugin.cfg file
) else (
    echo WARNING: plugin.cfg not found at project\addons\myextension\plugin.cfg
)

REM Update extension.gdextension if it has version info
if exist "project\addons\myextension\myextension.gdextension" (
    echo Checking myextension.gdextension for version info...
    REM The gdextension file doesn't typically contain version info, but we'll note it
    echo Note: myextension.gdextension doesn't contain version info (this is normal)
)

echo.
echo ========================================
echo Version updated successfully!
echo ========================================
echo.
echo New version: %new_version%
echo Updated files:
echo - VERSION
echo - project\addons\myextension\plugin.cfg
echo.
echo You can now:
echo 1. Build the extension: build.bat
echo 2. Package for distribution: package-extension.bat
echo.
pause
