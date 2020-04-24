@echo off
echo The use of server.sh has been deprecated, starting XL Release from run.sh

setlocal ENABLEDELAYEDEXPANSION

REM Get XL Release server home dir
if "%xlrelease_home%"=="" (
    cd /d "%~dp0"
    cd ..
    set xlrelease_home=!CD!
)

if [%1]==[] (
    call "%xlrelease_home%\bin\run.cmd"
) else (
    call "%xlrelease_home%\bin\run.cmd" %*
)

endlocal
