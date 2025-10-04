@echo off
REM Update Entry Symbol Script for GDExtension
REM This script helps update the entry symbol to be unique

echo ========================================
echo GDExtension Entry Symbol Updater
echo ========================================
echo.

set /p extension_name="Enter your extension name (e.g., myextension): "

if "%extension_name%"=="" (
    echo No extension name provided. Exiting.
    pause
    exit /b 1
)

echo.
echo Updating entry symbol to: %extension_name%_gdextension_init
echo.

REM Update register_types.cpp
if exist "src\register_types.cpp" (
    echo Updating src\register_types.cpp...
    powershell -command "(Get-Content 'src\register_types.cpp') -replace 'gdextension_init\(', '%extension_name%_gdextension_init(' | Set-Content 'src\register_types.cpp'"
    echo Updated register_types.cpp
) else (
    echo WARNING: src\register_types.cpp not found
)

REM Update .gdextension file
set gdextension_file=project\addons\%extension_name%\%extension_name%.gdextension
if exist "%gdextension_file%" (
    echo Updating %gdextension_file%...
    powershell -command "(Get-Content '%gdextension_file%') -replace 'entry_symbol = \"gdextension_init\"', 'entry_symbol = \"%extension_name%_gdextension_init\"' | Set-Content '%gdextension_file%'"
    echo Updated %gdextension_file%
) else (
    echo WARNING: %gdextension_file% not found
)

echo.
echo ========================================
echo Entry symbol updated successfully!
echo ========================================
echo.
echo New entry symbol: %extension_name%_gdextension_init
echo.
echo Updated files:
echo - src\register_types.cpp
echo - %gdextension_file%
echo.
echo You should now rebuild your extension:
echo   build.bat
echo.
pause
