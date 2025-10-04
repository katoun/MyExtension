@echo off
REM Package MyExtension for Godot Asset Library Distribution
REM This script creates a properly formatted ZIP file for distribution

echo ========================================
echo MyExtension Package Script
echo ========================================
echo.

REM Check if extension is built
if not exist "project\addons\myextension\bin\libmyextension.windows.debug.x86_64.dll" (
    echo WARNING: Extension not built yet!
    echo Please run build.bat first to build all targets.
    echo.
    set /p build_now="Build all targets now? (y/n): "
    if /i "%build_now%"=="y" (
        echo Building all targets...
        scons target=template_debug platform=windows arch=x86_64
        scons target=template_release platform=windows arch=x86_64
        scons target=template_debug platform=windows arch=arm64
        scons target=template_release platform=windows arch=arm64
        if errorlevel 1 (
            echo Build failed. Cannot package extension.
            pause
            exit /b 1
        )
        echo All builds completed successfully!
    ) else (
        echo Cannot package without built binaries.
        pause
        exit /b 1
    )
)

REM Get version number from VERSION file
if exist "VERSION" (
    set /p version=<VERSION
    echo Using version from VERSION file: %version%
) else (
    set /p version="Enter version number (e.g., 1.0.0): "
    if "%version%"=="" set version=1.0.0
)

echo.
echo Creating package for version %version%...

REM Create temporary directory
set temp_dir=temp_package
if exist "%temp_dir%" rmdir /s /q "%temp_dir%"
mkdir "%temp_dir%"

REM Copy addon files to temp directory
echo Copying addon files...
xcopy "project\addons\myextension\*" "%temp_dir%\myextension\" /E /I /Y

REM Create plugin.cfg if it doesn't exist
if not exist "%temp_dir%\myextension\plugin.cfg" (
    echo Creating plugin.cfg...
    (
        echo [plugin]
        echo name="MyExtension"
        echo description="A GDExtension for Godot 4.5 with example Node and Singleton classes"
        echo author="Your Name"
        echo version="%version%"
        echo script=""
    ) > "%temp_dir%\myextension\plugin.cfg"
)

REM Copy README if it exists
if exist "README.md" (
    echo Copying README...
    copy "README.md" "%temp_dir%\myextension\" >nul
)

REM Create the ZIP file
set zip_name=myextension-v%version%.zip
echo Creating ZIP file: %zip_name%...

REM Use PowerShell to create ZIP (available on Windows 10+)
powershell -command "Compress-Archive -Path '%temp_dir%\*' -DestinationPath '%zip_name%' -Force"

if errorlevel 1 (
    echo ERROR: Failed to create ZIP file.
    echo Make sure you have PowerShell available.
    pause
    exit /b 1
)

REM Clean up temp directory
rmdir /s /q "%temp_dir%"

echo.
echo ========================================
echo Package created successfully!
echo ========================================
echo.
echo File: %zip_name%
echo Size: 
for %%A in (%zip_name%) do echo %%~zA bytes
echo.
echo Contents:
echo - myextension/ (addon folder)
echo   - myextension.gdextension
echo   - bin/ (all platform binaries)
echo   - plugin.cfg
echo   - README.md (if available)
echo.
echo This ZIP file is ready for:
echo 1. Godot Asset Library submission
echo 2. Direct distribution to users
echo 3. GitHub releases
echo.
pause
