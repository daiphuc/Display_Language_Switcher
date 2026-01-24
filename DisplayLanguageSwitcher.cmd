@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"

:: ============================================================
:: ADMIN CHECK
:: ============================================================
reg query "HKU\S-1-5-19" >nul 2>nul || (
 echo ERROR: Run this script as Administrator
 pause
 exit /b
)

if exist "%windir%\winsxs\pending.xml" (
 echo Pending update detected. Please reboot first.
 pause
 exit /b
)

:: ============================================================
:: WINDOWS VERSION DETECT (23H2 / 24H2 / 25H2)
:: ============================================================
set WINVER=
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DisplayVersion') do set WINVER=%%b

if "%WINVER%"=="" (
 echo ERROR: Cannot detect Windows version
 pause
 exit /b
)

if /i "%WINVER%"=="23H2" set VERFOLDER=23H2
if /i "%WINVER%"=="24H2" set VERFOLDER=24H2
if /i "%WINVER%"=="25H2" set VERFOLDER=25H2

if not defined VERFOLDER (
 echo ERROR: Unsupported Windows version: %WINVER%
 pause
 exit /b
)

echo Detected Windows version: %WINVER%
echo Using folder: %VERFOLDER%
echo.

set LP_DIR=%cd%\LangPack\%VERFOLDER%
set FOD_DIR=%cd%\FOD\%VERFOLDER%

if not exist "%LP_DIR%" (
 echo ERROR: LangPack folder not found: %LP_DIR%
 pause
 exit /b
)

:: ============================================================
:: WINDOWS INFO DISPLAY
:: ============================================================
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName') do set WINNAME=%%b
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild') do set WINBUILD=%%b
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID') do set WINEDITION=%%b
for /f "tokens=2,*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ReleaseId') do set WINREL=%%b

if "%WINREL%"=="" set WINREL=%WINVER%

if /i "%PROCESSOR_ARCHITECTURE%"=="AMD64" set WINARCH=x64
if /i "%PROCESSOR_ARCHITECTURE%"=="ARM64" set WINARCH=ARM64
if /i "%PROCESSOR_ARCHITECTURE%"=="x86" set WINARCH=x86

:: ============================================================
:: BLOCK SLEEP + SCREEN OFF (SAFE MODE)
:: ============================================================
set OLD_AC_SLEEP=15
set OLD_DC_SLEEP=15
set OLD_AC_MONITOR=5
set OLD_DC_MONITOR=5

echo Disabling sleep and screen timeout...

:: Disable sleep
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0

:: Disable screen off
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0

:: ============================================================
:: MAIN MENU
:: ============================================================
:MainMenu
cls
echo ============================================================
echo Windows 11 Display Language Tool
echo ============================================================
echo OS Name      : %WINNAME%
echo Edition      : %WINEDITION%
echo Version      : %WINVER%
echo Build        : %WINBUILD%
echo Architecture : %WINARCH%
echo Folder       : %VERFOLDER%
echo ============================================================
echo.
echo 1. Install new language pack
echo 2. Set installed language as primary
echo 0. Exit
echo.
set /p MENU=Select option: 

if "%MENU%"=="1" goto :InstallLPMenu
if "%MENU%"=="2" goto :SelectInstalledLang
if "%MENU%"=="0" goto :ExitScript
goto :MainMenu

:: ============================================================
:: INSTALL NEW LANGUAGE PACK
:: ============================================================
:InstallLPMenu
set COUNT=0

for %%i in ("%LP_DIR%\*.cab") do (
 set /a COUNT+=1
 expand.exe -f:langcfg.ini "%%i" "%cd%" >nul
 for /f "tokens=2 delims==" %%l in ('findstr /i "Language" langcfg.ini') do (
  set LP!COUNT!=%%i
  set LC!COUNT!=%%l
 )
 del /f /q langcfg.ini
)

if %COUNT%==0 (
 echo No language packs found in %LP_DIR%
 pause
 goto :MainMenu
)

cls
echo ============================================================
echo Available Language Packs [%VERFOLDER%]
echo ============================================================
echo.

for /L %%i in (1,1,%COUNT%) do echo %%i. !LC%%i!
echo.
set /p CHOICE=Select language number (0 = cancel): 

if "%CHOICE%"=="0" goto :MainMenu
if not defined LP%CHOICE% goto :InstallLPMenu

set LangFile=!LP%CHOICE%!
set LangCode=!LC%CHOICE%!
call :%LangCode%

cls
echo Installing Language Pack: %LangName% [%LangCode%]
echo.

dism /Online /NoRestart /Add-Package /PackagePath:"%LangFile%"
if errorlevel 2 (
 echo Failed to install language pack
 pause
 goto :MainMenu
)

call :InstallFOD
call :ApplyLanguage
exit /b

:: ============================================================
:: INSTALL FOD (AUTO VERSION)
:: ============================================================
:InstallFOD
echo.
echo Installing Language Features On Demand...
echo.

if not exist "%FOD_DIR%" (
 echo No FOD folder found: %FOD_DIR%
 exit /b
)

set FOUND=0
for %%i in ("%FOD_DIR%\Microsoft-Windows-LanguageFeatures-*-%LangCode%-Package-*.cab") do (
 set FOUND=1
 echo Installing %%~nxi
 dism /Online /NoRestart /Add-Package /PackagePath:"%%i"
)

if "%FOUND%"=="0" echo No FOD packages found for %LangCode%
exit /b

:: ============================================================
:: SELECT INSTALLED LANGUAGE (NO DUPLICATE en-US)
:: ============================================================
:SelectInstalledLang
cls
echo ============================================================
echo Installed Display Languages
echo ============================================================
echo.

set COUNT=0
set FOUND_EN=0

for /f "tokens=7 delims=\" %%i in (
 'reg query HKLM\SYSTEM\CurrentControlSet\Control\MUI\UILanguages'
) do (
 set /a COUNT+=1
 set IL!COUNT!=%%i
 echo !COUNT!. %%i
 if /i "%%i"=="en-US" set FOUND_EN=1
)

if "!FOUND_EN!"=="0" (
 set /a COUNT+=1
 set IL!COUNT!=en-US
 echo !COUNT!. en-US (Base)
)

echo.
set /p CHOICE=Select language number (0 = cancel): 

if "%CHOICE%"=="0" goto :MainMenu
if not defined IL%CHOICE% goto :SelectInstalledLang

set LangCode=!IL%CHOICE%!
call :%LangCode%
call :ApplyLanguage
exit /b

:: ============================================================
:: APPLY LANGUAGE
:: ============================================================
:ApplyLanguage
cls
echo Applying Windows 11 Language...
echo.

set LangHexL=0000%LangHex%

reg add HKLM\SYSTEM\CurrentControlSet\Control\MUI\UILanguages\%LangCode% /v LCID /t REG_DWORD /d 0x%LangHex% /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Control\MUI\UILanguages\%LangCode% /v Type /t REG_DWORD /d 0x%LangType% /f >nul

reg add HKLM\SYSTEM\CurrentControlSet\Control\Nls\Language /v InstallLanguage /d %LangHex% /f >nul
reg add HKLM\SYSTEM\CurrentControlSet\Control\Nls\Locale /d %LangHexL% /f >nul

reg add "HKCU\Control Panel\International\User Profile" /v Languages /t REG_MULTI_SZ /d %LangCode% /f >nul
reg add "HKCU\Control Panel\Desktop" /v PreferredUILanguages /t REG_MULTI_SZ /d %LangCode% /f >nul

bcdedit /set {current} locale %LangCode% >nul

echo Rebuilding language cache...
%windir%\system32\mcbuilder.exe /s

echo.
echo DONE! Reboot required.
call :RestoreSleep
shutdown /r /t 0
exit /b

:: ============================================================
:: RESTORE POWER SETTINGS
:: ============================================================
:RestoreSleep
echo Restoring power settings...

:: Restore sleep timeout (minutes)
powercfg /change standby-timeout-ac %OLD_AC_SLEEP%
powercfg /change standby-timeout-dc %OLD_DC_SLEEP%

:: Restore screen timeout (minutes)
powercfg /change monitor-timeout-ac %OLD_AC_MONITOR%
powercfg /change monitor-timeout-dc %OLD_DC_MONITOR%

exit /b

:: ============================================================
:: LANGUAGE DEFINITIONS
:: ============================================================
:en-US
set LangName=English
set LangHex=0409
set LangType=111
goto :eof

:ru-RU
set LangName=Russian
set LangHex=0419
set LangType=112
goto :eof

:zh-CN
set LangName=Chinese (Simplified)
set LangHex=0804
set LangType=112
goto :eof

:: ============================================================
:: EXIT
:: ============================================================
:ExitScript
call :RestoreSleep
exit /b
