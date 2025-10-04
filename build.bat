@echo off
REM Simple Build Script for MyExtension
REM This script builds the extension without interactive menu

echo ========================================
echo MyExtension Simple Build Script
echo ========================================
echo.

REM Check if godot-cpp submodule exists
if not exist "godot-cpp" (
    echo ERROR: godot-cpp submodule not found!
    echo Please initialize submodules first:
    echo   git submodule update --init --recursive
    echo.
    pause
    exit /b 1
)

echo Building Debug version for Windows x86_64...
echo.

scons target=template_debug platform=windows arch=x86_64

if errorlevel 1 (
    echo.
    echo Build failed! Check the error messages above.
    pause
    exit /b 1
)

echo.
echo ========================================
echo Build completed successfully!
echo ========================================
echo.
echo Output: project\addons\myextension\bin\libmyextension.windows.debug.x86_64.dll
echo.
echo You can now test the extension in Godot:
echo   godot --path project\ --editor
echo.
pause
