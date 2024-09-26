@echo off
set JP=D:\GraalVM-Projects\gluonhq\SimpleOTP
set G=%JP%\graalvm
set T=%JP%\target

REM Clean and install the Maven project
call mvn -f "%JP%\pom.xml" clean install

echo Running native-image

call native-image ^
--no-fallback ^
--verbose ^
--enable-url-protocols=http ^
--enable-preview ^
--add-modules java.net.http ^
--add-opens java.net.http/java.net.http=ALL-UNNAMED ^
--add-opens java.base/java.net=ALL-UNNAMED ^
--module-path "%T%\SimpleOTP-1.0.jar;%T%\modules" ^
--module SimpleOTP/com.simtechdata.Main ^
-H:+UnlockExperimentalVMOptions ^
-H:+ReportExceptionStackTraces ^
-H:JNIConfigurationFiles="%G%\jni-config.json" ^
-H:DynamicProxyConfigurationFiles="%G%\proxy-config.json" ^
-H:ReflectionConfigurationFiles="%G%\reflect-config.json" ^
-H:ResourceConfigurationFiles="%G%\resource-config.json" ^
-H:SerializationConfigurationFiles="%G%\serialization-config.json" ^
-H:GenerateDebugInfo=1 ^
-H:DebugInfoSourceSearchPath="%T%\src" ^
-H:Name="%T%\SimpleOTP"

REM Copy the resulting executable to the target directory
xcopy /Y "%T%\SimpleOTP.exe" .
