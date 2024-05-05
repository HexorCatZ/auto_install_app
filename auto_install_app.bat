@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

break >nul

rem ===== update appinstaller =====
winget -v >nul 2>nul && ( break ) || (
    call :ColorText 04 "[!] APP INSTALLER IS NOT UPDATED."
    echo.
    choice /C yn /N /M "Force update using chocolatey? [Y/N] : "
    set choice=%errorlevel%
    if %choice%==1 (
        powershell "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
        )
    if %choice%==2 (
        echo Please update App Installer from Microsoft Store.
        echo Press any key to exit . . .
        pause 2>nul >nul
    )
    exit /b %errorlevel%
)

rem ===== copy file to desktop =====
rem setlocal
rem if not "%~dp0%~n0.bat" == "%USERPROFILE%\Desktop\%~n0.bat" (
rem   copy "%0" "%USERPROFILE%\Desktop\%~n0.bat"
rem   start "" "%USERPROFILE%\Desktop\%~n0.bat"
rem   exit
rem )

rem ===== check for admin =====
net session >nul 2>nul
if '%errorlevel%' NEQ '0' (
    call :ColorText 01 "[+] Requesting"
    call :ColorText 04 " administrative"
    call :ColorText 01 " privileges..."
    echo.
    powershell start-process -verb runas "%0"
    exit
)

cd /d "%temp%"

REM ====================
REM ===== THE MENU =====
REM ====================

REM default CMD size 120x30 letter :
REM ========================================================================================================================

REM application list
REM to add application here please search the apps name from winget using 'winget search "<app name>"'.
REM the format is '-<id> <name>'
rem ===== menu1 =====
set menu1=System Application
set m1o1=-abbodi1406.vcredist               Microsoft Visual C++ 2005-2023 Redistributable [ALL VERSION]
set m1o2=-Nvidia.GeForceExperience          NVIDIA GeForce Experience
set m1o3=-Microsoft.DirectX                 DirectX End-User Runtime Web Installer
set m1o4=-
set m1o5=-
set m1o6=-
set m1o7=-
set m1o8=-
set m1o9=-
rem ===== menu2 =====
set menu2=Brand-Based Application
set m2o1=-9N7R5S6B0ZZH                      Asus   : MyASUS               [MS Store]
set m2o2=-Asus.ArmouryCrate                 Asus   : ArmouryCrate
set m2o3=-9NVMNJCR03XV                      MSI    : MSI Center           [MS Store]
set m2o4=-9WZDNCRFJ4MV                      Lenovo : Lenovo Vantage       [MS Store]
set m2o5=-
set m2o6=-
set m2o7=-
set m2o8=-
set m2o9=-
rem ===== menu3 =====
set menu3=Internet Explorer
set m3o1=-Google.Chrome                     Google Chrome
set m3o2=-Mozilla.Firefox                   Mozilla Firefox
set m3o3=-Opera.Opera                       Opera Stable
set m3o4=-Opera.OperaGX                     Opera GX
set m3o5=-Brave.Brave                       Brave Browser
set m3o6=-
set m3o7=-
set m3o8=-
set m3o9=-
rem ===== menu4 =====
set menu4=Office Application
set m4o1=-Microsoft.Office                  Microsoft Office 365
set m4o2=-Kingsoft.WPSOffice                WPS Office
set m4o3=-Kingsoft.WPSOffice.CN             WPS Office Chinese
set m4o4=-TheDocumentFoundation.LibreOffice LibreOffice
set m4o5=-Apache.OpenOffice                 OpenOffice
set m4o6=-
set m4o7=-
set m4o8=-
set m4o9=-
rem ===== menu5 =====
set menu5=Online Chatting Application
set m5o1=-Alibaba.DingTalk                  DingTalk
set m5o2=-Discord.Discord                   Discord
set m5o3=-Microsoft.Skype                   Skype
set m5o4=-Telegram.TelegramDesktop          Telegram Desktop
set m5o5=-XPFCKBRNFZQ62G                    WeChat                        [MS Store]
set m5o6=-9NKSQGP7F2NH                      WhatsApp                      [MS Store]
set m5o7=-Facebook.Messenger                Facebook Messenger
set m5o8=-9NBLGGH5L9XT                      Instagram
set m5o9=-
rem ===== menu6 =====
set menu6=Online Meeting and Remote Desktop Application
set m6o1=-AnyDeskSoftwareGmbH.AnyDesk       AnyDesk
set m6o2=-Microsoft.Teams                   Microsoft Teams
set m6o3=-Parsec.Parsec                     Parsec
set m6o4=-TeamViewer.TeamViewer             TeamViewer
set m6o5=-GlavSoft.TightVNC                 TightVNC
set m6o6=-Zoom.Zoom                         Zoom
set m6o7=-
set m6o8=-
set m6o9=-
rem ===== menu7 =====
set menu7=Multimedia Software
set m7o1=-VideoLAN.VLC                      VLC media player
set m7o2=-GOMLab.GOMPlayer                  GOM Player
set m7o3=-Winamp.Winamp                     Winamp
set m7o4=-CodecGuide.K-LiteCodecPack.Basic  K-Lite Codec Pack Basic
set m7o5=-9NCBCSZSJRSB                      Spotify - Music and Podcasts  [MS Store]
set m7o6=-Ytmdesktop.Ytmdesktop             YouTube Music Desktop App
set m7o7=-Audacity.Audacity                 Audacity
set m7o8=-MiXXX.MiXXX                       mixxx
set m7o9=-
rem ===== menu8 =====
set menu8=Utilities Software
set m8o1=-7zip.7zip                         7-Zip
set m8o2=-Adobe.Acrobat.Reader.32-bit       Adobe Acrobat Reader
set m8o3=-Notepad++.Notepad++               Notepad++
set m8o4=-CodeSector.TeraCopy               TeraCopy
set m8o5=-RARLab.WinRAR                     WinRAR
set m8o6=-qBittorrent.qBittorrent           qBittorrent
set m8o7=-FastCopy.FastCopy                 FastCopy
set m8o8=-
set m8o9=-
rem ===== menu9 =====
set menu9=Game Related Application
set m9o1=-Valve.Steam                       Steam
set m9o2=-EpicGames.EpicGamesLauncher       Epic Games Launcher
set m9o3=-ElectronicArts.EADesktop          EA app
set m9o4=-
set m9o5=-
set m9o6=-
set m9o7=-
set m9o8=-
set m9o9=-
rem ===== menu10 =====
set menu10=System Monitor Application
set m10o1=-CPUID.CPU-Z                       CPUID CPU-Z
set m10o2=-CPUID.HWMonitor                   CPUID HWMonitor
set m10o3=-REALiX.HWiNFO                     HWiNFO
set m10o4=-Guru3D.Afterburner                Afterburner
set m10o5=-FinalWire.AIDA64.Extreme          AIDA64 Extreme
set m10o6=-Unigine.SuperpositionBenchmark    Unigine Superposition Benchmark
set m10o7=-Unigine.HeavenBenchmark           Unigine Heaven Benchmark
set m10o8=-
set m10o9=-
goto mainmenu

:autoconfig
call :ColorText 01 "[+] loading . . ."
echo.

REM ##### NVIDIA GRAPHIC CARD #####
wmic path win32_videocontroller get name | find /i "nvidia" && set m1o2=+%m1o2:~1%

REM ##### ASUS MOTHERBOARD #####
wmic baseboard get manufacturer | find /i "asus" && set m2o1=+%m2o1:~1%

REM ##### MSI MOTHERBOARD #####
wmic baseboard get manufacturer | find /i "Micro-Star International" && set m2o3=+%m2o3:~1%

REM ##### LENOVO MOTHERBOARD #####
wmic baseboard get manufacturer | find /i "LENOVO" && set m2o4=+%m2o4:~1%
goto list

:mainmenu
cls
echo Choose Template or use Custom Install :
echo.
echo 1. TMT Customer Recomended Software
echo 2. Office Only PC
echo 3. Gaming Only PC
echo.
echo.
echo.
echo.
echo.
echo 9. Auto Config
echo.
echo.
echo  Press "C" for Custom Setting
echo  Press "Q" to Quit
choice /C 123456789cq /N /M "Your choice: "
set choice=%errorlevel%
if %choice%==10 goto start
if %choice%==11 goto :EOF
if %choice%==1 (
    set m3o1=+%m3o1:~1% & :: Google.Chrome
    set m7o1=+%m7o1:~1% & :: VideoLAN.VLC
    set m8o2=+%m8o2:~1% & :: Adobe.Acrobat.Reader.32-bit
    set m8o5=+%m8o5:~1% & :: RARLab.WinRAR
    goto list )
if %choice%==2 (
    set m3o1=+%m3o1:~1% & :: Google.Chrome
    set m7o1=+%m7o1:~1% & :: VideoLAN.VLC
    set m8o2=+%m8o2:~1% & :: Adobe.Acrobat.Reader.32-bit
    set m8o5=+%m8o5:~1% & :: RARLab.WinRAR
    set m4o1=+%m4o1:~1% & :: Microsoft.Office
    set m6o6=+%m6o6:~1% & :: Zoom.Zoom
    set m6o2=+%m6o2:~1% & :: Microsoft.Teams
    set m5o6=+%m5o6:~1% & :: Microsoft.Skype
    goto list )
if %choice%==3 (
    set m3o1=+%m3o1:~1% & :: Google.Chrome
    set m7o1=+%m7o1:~1% & :: VideoLAN.VLC
    rem set m8o2=+%m8o2:~1% & :: Adobe.Acrobat.Reader.32-bit
    set m8o5=+%m8o5:~1% & :: RARLab.WinRAR
    set m1o1=+%m1o1:~1% & :: vcredist
    set m1o2=+%m1o2:~1% & :: Nvidia.GeForceExperience
    set m3o4=+%m3o4:~1% & :: Opera.OperaGX
    set m5o2=+%m5o2:~1% & :: Discord.Discord
    set m9o1=+%m9o1:~1% & :: Valve.Steam
    set m9o2=+%m9o2:~1% & :: EpicGames.EpicGamesLauncher
    set m9o3=+%m9o3:~1% & :: ElectronicArts.EADesktop
    goto list )
if %choice%==9 goto autoconfig
goto mainmenu

:start
set menu=1
set menumax=10
:chooseapps
cls
if %menu% leq 0 goto mainmenu
if %menu% gtr %menumax% goto list
for /f "tokens=1* delims==" %%i in ('set menu%menu%') do (
    echo [%menu%/%menumax%] Choose %%j to add :
)
echo.
for /l %%b in (1,1,9) do (
    for /f "tokens=2,* delims== " %%i in ('set m!menu!o%%b') do (
        set appname=%%i
        if not "!appname!"=="-" (
            echo [!appname:~0,1!] %%b. %%j
        ) else (
            echo.
        )
    )
)
echo.
echo.
if !menu!==1 (
    echo  Press "N" for Next, and "I" to install.
) else (
    echo  Press "N" for Next, "B" for Back, and "I" to install.
)

echo  Press "Q" to Quit
choice /C 123456789nbqi /N /M "Your choice: "
set choice=%errorlevel%
if %choice%==13 goto list
if %choice%==12 goto mainmenu
if %choice%==11 ( set /a menu=!menu!-1 )
if %choice%==10 ( set /a menu=!menu!+1 )

for /f "tokens=2,* delims==" %%i in ('set m!menu!o!choice!') do (
    set toggle=%%i
    if not "!toggle!"=="-" (
        if "!toggle:~0,1!"=="-" (
            set m%menu%o%choice%=+!toggle:~1!
        ) else (
            set m%menu%o%choice%=-!toggle:~1!
        )
    )
)

goto chooseapps

:list
cls
echo List all application to install :
set totalapp=0
set currentinstall=1
for /l %%a in (1,1,%menumax%) do (
    for /l %%b in (1,1,9) do (
        for /f "tokens=2,* delims== " %%i in ('set m%%ao%%b') do (
            set appname=%%i
            if "!appname:~0,1!"=="+" (
                set /a totalapp=!totalapp!+1
                echo [+] !totalapp!. %%j
            )
        )
    )
)

echo.
echo [+] TOTAL = %totalapp%
echo.
echo  Press "I" To Install, and "E" to Edit
echo  Press "Q" to Quit
choice /C ieq /N /M "Your choice: "
set choice=%errorlevel%
if %choice%==1 goto install
if %choice%==2 goto start
if %choice%==3 goto mainmenu
goto list

:install
cls
call :ColorText 01 "[+] waiting for internet connection..."
:loop
    ping 1.1.1.1 -n 1 | find /i "TTL" > nul
    if ERRORLEVEL 1 timeout 3 > nul && goto loop
call :ColorText 0a " connected"
echo.
echo y | winget upgrade
cls
winget list > "%temp%\WinGet\list.txt"

for /l %%a in (1,1,%menumax%) do (
    for /l %%b in (1,1,9) do (
        for /f "tokens=2,* delims==" %%i in ('set m%%ao%%b') do (
            set install=%%i
            if "!install:~0,1!"=="+" call :winstall !install:~1!
        )
    )
)

cls
echo === Installation Summary ===
winget list > "%temp%\WinGet\list.txt"
for /l %%a in (1,1,9) do (
    for /l %%b in (1,1,9) do (
        for /f "tokens=2,* delims==" %%i in ('set m%%ao%%b') do (
            set install=%%i
            if "!install:~0,1!"=="+" (
                call :wincheck !install:~1!
            )
        )
    )
)
pause
goto :EOF

:winstall
type %temp%\WinGet\list.txt | find /i "%1" > nul && (
    set /a currentinstall=%currentinstall%+1
    call :ColorText 01 "[-] (%currentinstall% of %totalapp%)"
    call :ColorText 0a " %1 already install. skipping..."
    echo.
) || (
    set /a currentinstall=%currentinstall%+1
    call :ColorText 01 "[+] (%currentinstall% of %totalapp%) installing"
    call :ColorText 04 " %1"
    echo.
    echo y | winget install %1
)
goto :EOF

:wincheck
type %temp%\WinGet\list.txt | find /i "%1" > nul && (
    call :ColorText 01 "[+]"
    call :ColorText 0a " %1 installed"
    echo.
) || (
    call :ColorText 01 "[-] "
    call :ColorText 04 " %1 not installed"
    echo.
)
goto :EOF

:ColorText
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
