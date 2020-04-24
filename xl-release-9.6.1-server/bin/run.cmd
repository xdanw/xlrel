@echo off
REM
REM Batch script to start the XL Release Server
REM

setlocal ENABLEDELAYEDEXPANSION

REM Get Java executable
if "%JAVA_HOME%"=="" (
  set JAVACMD=java
) else (
  set JAVACMD="%JAVA_HOME%\bin\java"
)

REM Get XL Release server home dir
if "%XL_RELEASE_SERVER_HOME%"=="" (
  cd /d "%~dp0"
  cd ..
  set XL_RELEASE_SERVER_HOME=!CD!
)

cd /d "%XL_RELEASE_SERVER_HOME%"

REM Build XL Release server classpath, JVM and logging options
FOR /F "tokens=1* delims==" %%A IN ('type "%XL_RELEASE_SERVER_HOME%\conf\xlr-wrapper-win.conf"') DO (
    set key=%%A
    IF "!key:~0,23!"=="wrapper.java.classpath." (
        set value=%%B
        IF "!value:~-2!" neq "/*" (
            set XL_RELEASE_SERVER_CLASSPATH=!XL_RELEASE_SERVER_CLASSPATH!;%%B
        ) ELSE (
            set XL_RELEASE_SERVER_CLASSPATH=!XL_RELEASE_SERVER_CLASSPATH!;%%B
            for /d %%i in ("%%B") do set XL_RELEASE_SERVER_CLASSPATH=!XL_RELEASE_SERVER_CLASSPATH!;!value:~0,-1!%%i
        )
    )
    IF "!key:~0,24!"=="wrapper.java.additional." (
        set XL_RELEASE_SERVER_OPTS=!XL_RELEASE_SERVER_OPTS! %%B
    )
)

REM Run XL Release server
%JAVACMD% %XL_RELEASE_SERVER_OPTS% -cp "%XL_RELEASE_SERVER_CLASSPATH%" com.xebialabs.xlrelease.XLReleaseBootstrapper %*

endlocal
