@echo off
REM Show Current Version Script for MyExtension

echo ========================================
echo MyExtension Version Information
echo ========================================
echo.

REM Get version from VERSION file
if exist "VERSION" (
    set /p version=<VERSION
    echo Current version: %version%
) else (
    echo No VERSION file found.
    set version=Not set
)

REM Check plugin.cfg version
if exist "project\addons\myextension\plugin.cfg" (
    echo.
    echo Plugin.cfg version:
    findstr "version=" "project\addons\myextension\plugin.cfg"
) else (
    echo.
    echo WARNING: plugin.cfg not found
)

echo.
echo ========================================
echo Version Management Commands:
echo ========================================
echo.
echo To update version: set-version.bat
echo To build extension: build.bat
echo To package extension: package-extension.bat
echo.
pause
