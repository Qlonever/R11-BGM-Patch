@echo off

cd /d %~dp0

IF [%1] == [] (
    echo No argument was provided; cannot proceed with patching.
    goto :END
)
IF NOT EXIST xdelta3\xdelta3.exe (
    echo The included xdelta executable is missing; cannot proceed with patching.
    goto :END
)

IF NOT EXIST patch.xdelta (
    echo The included patch file is missing; cannot proceed with patching.
    goto :END
)

for /F "delims=" %%i in ("%1") do set fileDir=%%~dpi
set bgmpc=%fileDir%bgmpc.afs
set bgmpcen=%fileDir%bgmpc-en.afs

::echo %fileDir%
::echo %bgmpc%
::echo %bgmpcen%

IF NOT EXIST "%bgmpc%" (
    echo Could not find bgmpc.afs at the provided location; cannot proceed with patching.
    goto :END
)

choice /m "Would you like to back-up BGM files before patching?"

set backup=%errorlevel%
set backupen=%errorlevel%

IF EXIST "%bgmpc%.bak" (
    echo A backup of bgmpc.afs already exists; keeping existing backup.
    set backup=1
    ren "%bgmpc%" "bgmpc.afs.bak1"
) ELSE (
    ren "%bgmpc%" "bgmpc.afs.bak"
)

IF EXIST "%bgmpcen%.bak" (
    echo A backup of bgmpc-en.afs already exists; keeping existing backup.
    set backupen=1
    ren "%bgmpcen%" "bgmpc-en.afs.bak1"
) ELSE IF EXIST "%bgmpcen%" (
    ren "%bgmpcen%" "bgmpc-en.afs.bak"
)

xdelta3\xdelta3 -d -s "%bgmpc%.bak" patch.xdelta "%bgmpc%"

IF EXIST "%bgmpc%" (
    IF EXIST "%bgmpcen%.bak" copy "%bgmpc%" "%bgmpcen%" >NUL
    echo Patching succeeded.
) ELSE (
    IF EXIST "%bgmpc%.bak1" ren "%bgmpc%.bak1" "bgmpc.afs" ELSE ren "%bgmpc%.bak" "bgmpc.afs"
    echo Something went wrong during the patching process. Your copy of bgmpc.afs may not be original. (MD5: b99c6c0912e2edc696c7b5966801b584)
)

IF NOT EXIST "%bgmpcen%" (
    IF EXIST "%bgmpcen%.bak1" ren "%bgmpcen%.bak1" "bgmpc-en.afs" ELSE IF EXIST "%bgmpcen%.bak" ren "%bgmpcen%.bak" "bgmpc-en.afs"
)

IF EXIST "%bgmpc%.bak1" del "%bgmpc%.bak1"
IF EXIST "%bgmpcen%.bak1" del "%bgmpcen%.bak1"

IF backup EQU 2 (
    IF EXIST "%bgmpc%.bak" del "%bgmpc%.bak"
)

if backupen EQU 2 (
    IF EXIST "%bgmpcen%.bak" del "%bgmpcen%.bak"
)

:END
PAUSE