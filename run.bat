@echo off
set JP=D:\GraalVM-Projects\gluonhq\SimpleOTP
set G=%JP%\graalvm
set T=%JP%\target

REM Clean and install the Maven project
call mvn -f "%JP%\pom.xml" clean
call mvn -f "%JP%\pom.xml" install

REM Run the project with GraalVM native-image agent
java ^
--enable-preview ^
-agentlib:native-image-agent=config-merge-dir="%G%" ^
--module-path "%T%\SimpleOTP-1.0.jar;%T%\modules" ^
-m SimpleOTP/com.simtechdata.Main graalvm

REM Run the project on JVM
java ^
--enable-preview ^
--module-path "%T%\SimpleOTP-1.0.jar;%T%\modules" ^
-m SimpleOTP/com.simtechdata.Main
