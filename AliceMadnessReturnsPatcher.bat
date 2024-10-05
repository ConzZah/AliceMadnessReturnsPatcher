@echo off & title Alice Madness Returns Patcher by ConzZah & setlocal enabledelayedexpansion & set wd=%cd%
set steampath=%ProgramFiles(x86)%\Steam\steamapps\common\Alice Madness Returns
set documentspath=%USERPROFILE%\Documents\My Games
set _7z=%ProgramFiles%\7-Zip\7z.exe
set alice1_gamepath=%steampath%\Alice1
set alice1_cfgpath=%documentspath%\American McGee's Alice
set alice2_cfgpath=%documentspath%\Alice Madness Returns\AliceGame\Config
if not exist "%steampath%\Binaries\Win32\AliceMadnessReturns.exe" echo ALICE MADNESS RETURNS COULD NOT BE FOUND && pause && exit 
call :config_files_check

echo     .:======== ConzZah's ========:.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo   ALICE MADNESS RETURNS PATCHER [v1.0]
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo       [ PRESS ANY KEY TO START ]        
set /p x= & cls
if "%x%"=="alice1" goto dl_alice1
if "%~1"=="alice1" goto dl_alice1

:patch_amr
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo   PATCHING ALICE MADNESS RETURNS
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ & echo.
if not exist "%alice2_cfgpath%" mkdir "%alice2_cfgpath%"
echo [ --^> DELETING INTRO MOVIES ] & echo. & cd "%steampath%\AliceGame\Movies"
del Intro_EA.bik Intro_Nvidia.bik Intro_SH.bik TechLogo_Short.bik >nul 2>&1 & cd %wd%\config_files
echo [ --^> AliceEngine.ini.. ]
copy /y "%wd%\config_files\documents_config\AliceEngine.ini" "%alice2_cfgpath%\AliceEngine.ini" & echo.
echo [ --^> DefaultEngine.ini.. ]
copy /y "%wd%\config_files\steamapps_config\DefaultEngine.ini" "%steampath%\AliceGame\Config\DefaultEngine.ini" & echo.
echo [ --^> BaseEngine.ini.. ]
copy /y "%wd%\config_files\steamapps_config\BaseEngine.ini" "%steampath%\Engine\Config\BaseEngine.ini" & echo.
echo [## DONE PATCHING ALICE MADNESS RETURNS ##] & echo.
if not exist "%alice1_gamepath%\bin\alice.exe" echo HAVE FUN PLAYING :D && pause && exit else goto patch_alice1

:patch_alice1
echo ~~~~~~~~~~~~~~~~~~~~
echo   PATCHING ALICE 1  
echo ~~~~~~~~~~~~~~~~~~~~ & echo.
if not exist "%alice1_cfgpath%" mkdir "%alice1_cfgpath%"
echo [ --^> config.cfg.. ]
copy /y "%wd%\config_files\alice1_config\config.cfg" "%alice1_cfgpath%\config.cfg" & echo.
echo [ --^> default_pc.cfg.. ]
copy /y "%wd%\config_files\alice1_config\default_pc.cfg" "%alice1_gamepath%\bin\base\default_pc.cfg" & echo.
echo [## DONE PATCHING ALICE 1 ##] & echo. & echo HAVE FUN PLAYING :D & cd "%wd%" & pause & exit

:dl_alice1
call :_7zcheck
echo ~~~~~~~~~~~~~~~~~~~
echo  Alice 1 Installer
echo ~~~~~~~~~~~~~~~~~~~ & echo.
if not exist "%alice1_gamepath%" mkdir "%alice1_gamepath%"
cd "%alice1_gamepath%" && cd .. & del Alice1.7z >nul 2>&1
echo [ --^> Downloading Alice1.7z from Archive.org ] & curl -# -L -o Alice1.7z https://archive.org/download/alice1_202405/Alice1.7z
echo [ --^> Extracting Alice1.7z ] & "!_7z!" x -y Alice1.7z
echo [ --^> Cleaning up.. ] & del Alice1.7z & cd "%wd%" & echo.
goto patch_alice1

:_7zcheck
rem (FALLBACK) if 7z couldn't be found at default path, get 7zr and set path 
if not exist "%_7z%" set _7z=%wd%\7zr.exe 
if not exist "!_7z!" echo 7zip not found, downloading.. && curl -# -L -o 7zr.exe https://www.7-zip.org/a/7zr.exe && echo.
cls & exit /b

:config_files_check
rem (FALLBACK) if config_files folder is missing, get config_files.7z from my github
if not exist "%wd%\config_files" ( call :_7zcheck & echo config files not found, downloading..
curl -# -L -o config_files.7z https://github.com/ConzZah/AliceMadnessReturnsPatcher/raw/refs/heads/main/config_files.7z
"!_7z!" x -y config_files.7z >nul 2>&1 & del config_files.7z )
cls & exit /b
