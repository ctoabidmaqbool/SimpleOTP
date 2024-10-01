@echo off
setlocal enabledelayedexpansion

REM Set up paths for project and GraalVM
set JP=D:\GraalVM-Projects\gluonhq\SimpleOTP
set G=%JP%\graalvm
set T=%JP%\target

REM Clean and install the Maven project
call mvn -f "%JP%\pom.xml" clean install

REM Initialize classpath with the main JAR
set CLASSPATH=%T%\SimpleOTP-1.0.jar

REM Dynamically add all JAR files in the modules directory to the classpath
for %%i in ("%T%\modules\*.jar") do (
    set CLASSPATH=!CLASSPATH!;%%i
)

echo Classpath: %CLASSPATH%

echo Running native-image...

REM Invoke native-image tool to create the native executable
call native-image ^
--no-fallback ^
--verbose ^
--enable-url-protocols=http ^
--enable-preview ^
--add-modules java.net.http ^
--add-opens java.net.http/java.net.http=ALL-UNNAMED ^
--add-opens java.base/java.net=ALL-UNNAMED ^
-cp "%CLASSPATH%" ^
com.simtechdata.Main ^
-H:+UnlockExperimentalVMOptions ^
-H:+ReportExceptionStackTraces ^
-H:JNIConfigurationFiles="%G%\jni-config.json" ^
-H:DynamicProxyConfigurationFiles="%G%\proxy-config.json" ^
-H:ReflectionConfigurationFiles="%G%\reflect-config.json" ^
-H:ResourceConfigurationFiles="%G%\resource-config.json" ^
-H:SerializationConfigurationFiles="%G%\serialization-config.json" ^
-H:GenerateDebugInfo=1 ^
-H:DebugInfoSourceSearchPath="%JP%\src" ^
-H:Name="%T%\SimpleOTP"

REM Copy the resulting executable to the target directory
xcopy /Y "%T%\SimpleOTP.exe" .
