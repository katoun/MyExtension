@echo off
setlocal enabledelayedexpansion
REM Download Godot 4.5 for testing
REM Usage: download-godot.bat [nopause]
REM If "nopause" is passed, script won't pause at the end

if "%1"=="nopause" (
    set NO_PAUSE=1
) else (
    set NO_PAUSE=0
)

echo ========================================
echo Godot 4.5 Download Script
echo ========================================
echo.

set "GODOT_URL=https://downloads.godotengine.org/?version=4.5&flavor=stable&slug=win64.exe.zip&platform=windows.64"
set GODOT_ALT_URL=https://godotengine.org/download/windows/
set GODOT_ZIP=%~dp0Godot_v4.5-stable_win64.zip
set GODOT_PATH=%~dp0Godot_v4.5-stable_win64.exe

echo Downloading Godot 4.5 to: %GODOT_PATH%
echo.

REM Check if Godot already exists
if exist "%GODOT_PATH%" (
    echo ✓ Godot 4.5 already exists at: %GODOT_PATH%
    echo You can run test-extension.bat now!
    goto end
)

REM Try to download using curl first, then PowerShell
echo Attempting to download Godot 4.5...

REM Check if curl is available
where curl >nul 2>nul
if %errorlevel%==0 (
    echo Using curl to download ZIP...
    curl -L -o "%GODOT_ZIP%" "%GODOT_URL%" --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" --connect-timeout 10 --max-time 60
    if %errorlevel%==0 (
        if exist "%GODOT_ZIP%" (
            REM Check if file is valid (not an error page)
            for %%A in ("%GODOT_ZIP%") do set size=%%~zA
            if !size! GTR 1000000 (
                echo Download completed successfully with curl
                goto extract_zip
            ) else (
                echo Download failed - file too small (likely error page)
                del "%GODOT_ZIP%" 2>nul
            )
        )
    )
)

REM Fallback to PowerShell
echo Trying PowerShell download...
powershell -Command "try { $ProgressPreference = 'SilentlyContinue'; [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%GODOT_URL%' -OutFile '%GODOT_ZIP%' -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' -TimeoutSec 30; if (Test-Path '%GODOT_ZIP%') { Write-Host 'Download completed successfully with PowerShell' } else { Write-Host 'Download failed - file not created'; exit 1 } } catch { Write-Host 'Download failed:' $_.Exception.Message; exit 1 }"
if %errorlevel%==0 (
    if exist "%GODOT_ZIP%" (
        REM Check if file is valid (not an error page)
        for %%A in ("%GODOT_ZIP%") do set size=%%~zA
        if !size! GTR 1000000 (
            goto extract_zip
        ) else (
            echo Download failed - file too small (likely error page)
            del "%GODOT_ZIP%" 2>nul
        )
    )
)

echo All download methods failed!
goto download_failed

:extract_zip
echo Extracting Godot executable from ZIP...
powershell -Command "try { Add-Type -AssemblyName System.IO.Compression.FileSystem; [System.IO.Compression.ZipFile]::ExtractToDirectory('%GODOT_ZIP%', '%~dp0temp_extract'); $exe = Get-ChildItem '%~dp0temp_extract' -Filter '*.exe' | Select-Object -First 1; if ($exe) { Move-Item $exe.FullName '%GODOT_PATH%'; Remove-Item '%~dp0temp_extract' -Recurse -Force; Write-Host 'Extraction completed successfully' } else { Write-Host 'No executable found in ZIP'; exit 1 } } catch { Write-Host 'Extraction failed:' $_.Exception.Message; exit 1 }"
if %errorlevel%==0 (
    if exist "%GODOT_PATH%" (
        echo ✓ Godot 4.5 extracted successfully!
        del "%GODOT_ZIP%" 2>nul
        goto download_success
    )
)
echo Extraction failed!
del "%GODOT_ZIP%" 2>nul
goto download_failed

:download_success
if exist "%GODOT_PATH%" (
    echo.
    echo ✓ Godot 4.5 downloaded successfully!
    echo Location: %GODOT_PATH%
    echo.
    echo You can now run test-extension.bat to test your extension.
) else (
    echo.
    echo ✗ Download failed - file not found!
    echo Please manually download Godot 4.5 from:
    echo https://godotengine.org/download/windows/
    echo.
    echo Save it as: %GODOT_PATH%
)
goto end

:download_failed
echo.
echo ✗ Download failed!
echo Please manually download Godot 4.5 from:
echo https://godotengine.org/download/windows/
echo.
echo Save it as: %GODOT_PATH%

:end

echo.
if %NO_PAUSE%==0 (
    pause
)
