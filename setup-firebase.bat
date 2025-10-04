@echo off
setlocal enabledelayedexpansion
REM Firebase C++ SDK Setup Script for Windows
REM This script downloads and sets up Firebase C++ SDK for the GDExtension project

echo ========================================
echo Firebase C++ SDK Setup Script
echo ========================================
echo.

REM Check if we're in the right directory
if not exist "SConstruct" (
    echo ERROR: This script must be run from the project root directory!
    echo Please run this script from the directory containing SConstruct.
    echo.
    pause
    exit /b 1
)

echo Setting up Firebase C++ SDK for Windows x86_64...
echo.

REM Create libs directory structure if it doesn't exist
echo Creating directory structure...
if not exist "libs" mkdir libs
if not exist "libs\windows" mkdir libs\windows
if not exist "libs\windows\x86_64" mkdir libs\windows\x86_64

echo Directory structure created.
echo.

REM Download Firebase C++ SDK
set FIREBASE_URL=https://dl.google.com/firebase/sdk/cpp/firebase_cpp_sdk.zip
set FIREBASE_URL_FALLBACK=https://firebase.google.com/download/cpp
set FIREBASE_ZIP=firebase_cpp_sdk.zip
set FIREBASE_EXTRACT=firebase_sdk

echo Downloading Firebase C++ SDK...
echo URL: %FIREBASE_URL%
echo This may take several minutes (1.1GB download)...
echo.

REM Check if curl is available
where curl >nul 2>nul
if %errorlevel%==0 (
    echo Using curl to download...
    curl -L -o "%FIREBASE_ZIP%" "%FIREBASE_URL%" --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" --connect-timeout 10 --max-time 300
    if %errorlevel%==0 (
        if exist "%FIREBASE_ZIP%" (
            REM Check if file is valid (not an error page)
            for %%A in ("%FIREBASE_ZIP%") do set size=%%~zA
            if !size! GTR 100000000 (
                echo Download completed successfully with curl
                goto extract_firebase
            ) else (
                echo Download failed - file too small (likely error page)
                del "%FIREBASE_ZIP%" 2>nul
            )
        )
    )
)

REM Fallback to PowerShell
echo Trying PowerShell download...
powershell -Command "try { $ProgressPreference = 'SilentlyContinue'; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%FIREBASE_URL%' -OutFile '%FIREBASE_ZIP%' -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' -TimeoutSec 300; if (Test-Path '%FIREBASE_ZIP%') { Write-Host 'Download completed successfully with PowerShell' } else { Write-Host 'Download failed - file not created'; exit 1 } } catch { Write-Host 'Download failed:' $_.Exception.Message; exit 1 }"
if %errorlevel%==0 (
    if exist "%FIREBASE_ZIP%" (
        REM Check if file is valid (not an error page)
        for %%A in ("%FIREBASE_ZIP%") do set size=%%~zA
        if !size! GTR 100000000 (
            goto extract_firebase
        ) else (
            echo Download failed - file too small (likely error page)
            del "%FIREBASE_ZIP%" 2>nul
        )
    )
)

echo Primary download failed, trying fallback URL...
set FIREBASE_URL=%FIREBASE_URL_FALLBACK%
echo Trying fallback URL: %FIREBASE_URL%

REM Try fallback download with curl
if %errorlevel%==0 (
    echo Using curl for fallback download...
    curl -L -o "%FIREBASE_ZIP%" "%FIREBASE_URL%" --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" --connect-timeout 10 --max-time 300
    if %errorlevel%==0 (
        if exist "%FIREBASE_ZIP%" (
            REM Check if file is valid (not an error page)
            for %%A in ("%FIREBASE_ZIP%") do set size=%%~zA
            if !size! GTR 100000000 (
                echo Fallback download completed successfully with curl
                goto extract_firebase
            ) else (
                echo Fallback download failed - file too small
                del "%FIREBASE_ZIP%" 2>nul
            )
        )
    )
)

REM Try fallback download with PowerShell
echo Trying PowerShell for fallback download...
powershell -Command "try { $ProgressPreference = 'SilentlyContinue'; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%FIREBASE_URL%' -OutFile '%FIREBASE_ZIP%' -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' -TimeoutSec 300; if (Test-Path '%FIREBASE_ZIP%') { Write-Host 'Fallback download completed successfully with PowerShell' } else { Write-Host 'Fallback download failed - file not created'; exit 1 } } catch { Write-Host 'Fallback download failed:' $_.Exception.Message; exit 1 }"
if %errorlevel%==0 (
    if exist "%FIREBASE_ZIP%" (
        REM Check if file is valid (not an error page)
        for %%A in ("%FIREBASE_ZIP%") do set size=%%~zA
        if !size! GTR 100000000 (
            goto extract_firebase
        ) else (
            echo Fallback download failed - file too small
            del "%FIREBASE_ZIP%" 2>nul
        )
    )
)

echo All download attempts failed! Please check your internet connection and try again.
echo You can also manually download Firebase C++ SDK from:
echo https://github.com/firebase/firebase-cpp-sdk/releases
echo.
pause
exit /b 1

:extract_firebase
echo.
echo Extracting Firebase C++ SDK...
powershell -Command "try { Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('%FIREBASE_ZIP%', '%FIREBASE_EXTRACT%'); Write-Host 'Extraction completed successfully' } catch { Write-Host 'Extraction failed:' $_.Exception.Message; exit 1 }"

if %errorlevel%==0 (
    if exist "%FIREBASE_EXTRACT%\firebase_cpp_sdk" (
        echo Firebase C++ SDK extracted successfully!
    ) else (
        echo Extraction failed - SDK directory not found
        pause
        exit /b 1
    )
) else (
    echo Extraction failed!
    pause
    exit /b 1
)

echo.
echo Copying Firebase libraries and headers...

REM Copy essential Firebase libraries (Debug versions)
set FIREBASE_SDK_PATH=%FIREBASE_EXTRACT%\firebase_cpp_sdk\libs\windows\VS2019\MD\x64\Debug

echo Copying Firebase libraries...
copy "%FIREBASE_SDK_PATH%\firebase_app.lib" "libs\windows\x86_64\" >nul
copy "%FIREBASE_SDK_PATH%\firebase_auth.lib" "libs\windows\x86_64\" >nul
copy "%FIREBASE_SDK_PATH%\firebase_database.lib" "libs\windows\x86_64\" >nul
copy "%FIREBASE_SDK_PATH%\firebase_storage.lib" "libs\windows\x86_64\" >nul

REM Copy Firebase headers
echo Copying Firebase headers...
xcopy "%FIREBASE_EXTRACT%\firebase_cpp_sdk\include" "libs\windows\x86_64\include" /E /I /Q >nul

REM Verify files were copied
echo.
echo Verifying Firebase setup...
if exist "libs\windows\x86_64\firebase_app.lib" (
    echo ✓ firebase_app.lib copied successfully
) else (
    echo ✗ firebase_app.lib not found
)

if exist "libs\windows\x86_64\firebase_auth.lib" (
    echo ✓ firebase_auth.lib copied successfully
) else (
    echo ✗ firebase_auth.lib not found
)

if exist "libs\windows\x86_64\firebase_database.lib" (
    echo ✓ firebase_database.lib copied successfully
) else (
    echo ✗ firebase_database.lib not found
)

if exist "libs\windows\x86_64\firebase_storage.lib" (
    echo ✓ firebase_storage.lib copied successfully
) else (
    echo ✗ firebase_storage.lib not found
)

if exist "libs\windows\x86_64\include\firebase\app.h" (
    echo ✓ Firebase headers copied successfully
) else (
    echo ✗ Firebase headers not found
)

echo.
echo Cleaning up temporary files...
del "%FIREBASE_ZIP%" 2>nul
powershell -Command "Remove-Item -Recurse -Force '%FIREBASE_EXTRACT%'" 2>nul

echo.
echo ========================================
echo Firebase C++ SDK Setup Complete!
echo ========================================
echo.

echo Firebase C++ SDK has been successfully set up for Windows x86_64!
echo.
echo Files installed:
echo - libs\windows\x86_64\firebase_app.lib
echo - libs\windows\x86_64\firebase_auth.lib
echo - libs\windows\x86_64\firebase_database.lib
echo - libs\windows\x86_64\firebase_storage.lib
echo - libs\windows\x86_64\include\ (Firebase headers)
echo.
echo You can now:
echo 1. Run build.bat to compile the extension with Firebase support
echo 2. Use the FirebaseWrapper class in your GDScript code
echo 3. See NATIVE_DEPENDENCIES.md for detailed usage instructions
echo.
echo Note: The FirebaseWrapper is currently in simulation mode.
echo To enable real Firebase functionality, configure your Firebase project
echo and uncomment the Firebase SDK code in src\firebase_wrapper.cpp
echo.
pause
