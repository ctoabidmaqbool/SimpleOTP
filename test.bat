@echo off
set T=D:\GraalVM-Projects\gluonhq\SimpleOTP\target

REM List all JAR files in the modules directory
for %%i in (%T%\modules\*.jar) do (
    echo %%i
)
