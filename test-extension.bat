@echo off
REM Test MyExtension in Godot
REM This script opens the demo project in Godot

echo ========================================
echo MyExtension Test Script
echo ========================================
echo.

REM Check if the extension is built
if not exist "project\addons\myextension\bin\libmyextension.windows.debug.x86_64.dll" (
    echo WARNING: Extension not built yet!
    echo Please run build.bat first.
    echo.
    set /p build_now="Build now? (y/n): "
    if /i "%build_now%"=="y" (
        echo Building extension...
        scons target=template_debug platform=windows arch=x86_64
        if errorlevel 1 (
            echo Build failed. Cannot test extension.
            pause
            exit /b 1
        )
        echo Build completed successfully!
    ) else (
        echo Cannot test without building the extension first.
        pause
        exit /b 1
    )
)

echo Opening Godot with the demo project...
echo.

REM Try to find Godot executable
set GODOT_PATH=

REM Check for local Godot executable first
if exist "%~dp0Godot_v4.5-stable_win64.exe" (
    set GODOT_PATH="%~dp0Godot_v4.5-stable_win64.exe"
    echo [OK] Found local Godot executable for testing...
) else (
    echo Local Godot executable not found!
    echo.
    echo Options:
    echo 1. Download Godot 4.5 automatically (recommended)
    echo 2. Use existing Godot installation
    echo.
    echo To use option 2, create a file named 'godot_path.txt' in this folder
    echo and put the full path to your Godot executable in it.
    echo Example: C:\Godot\Godot_v4.5-stable_win64.exe
    echo.
    
    REM Check if user has specified a manual path
    if exist "%~dp0godot_path.txt" (
        set /p GODOT_PATH=<"%~dp0godot_path.txt"
        if exist "%GODOT_PATH%" (
            echo [OK] Using Godot from: %GODOT_PATH%
            goto godot_found
        ) else (
            echo [ERROR] Godot not found at: %GODOT_PATH%
            echo Please check the path in godot_path.txt
            del "%~dp0godot_path.txt" 2>nul
        )
    )
    
    echo Downloading Godot 4.5 automatically...
    call "%~dp0download-godot.bat" nopause
    if exist "%~dp0Godot_v4.5-stable_win64.exe" (
        set GODOT_PATH="%~dp0Godot_v4.5-stable_win64.exe"
        echo [OK] Using local downloaded Godot executable for testing...
    ) else (
        echo [ERROR] Download failed!
        echo.
        echo To use your existing Godot installation:
        echo 1. Create a file named 'godot_path.txt' in this folder
        echo 2. Put the full path to your Godot executable in it
        echo 3. Run this script again
        echo.
        pause
        exit /b 1
    )
)

:godot_found
echo Using Godot: %GODOT_PATH%
echo.

REM Import and open the project
echo Importing project...
%GODOT_PATH% --path project\ --import --headless
if errorlevel 1 (
    echo Import failed. Trying to open project directly...
)

echo Opening project in Godot editor...
%GODOT_PATH% --path project\ --editor

echo.
echo ========================================
echo Test completed!
echo ========================================
echo.
echo To test the extension:
echo 1. Open the demo scene: demo\test.tscn
echo 2. Run the scene (F6 or click Play)
echo 3. Check the output console for extension messages
echo 4. Try creating MyNode from the Create Node dialog
echo 5. Test MySingleton in GDScript
echo.
echo Note: This test uses the locally downloaded Godot executable.
echo Run download-godot.bat first to download Godot 4.5 if needed.
echo.
pause