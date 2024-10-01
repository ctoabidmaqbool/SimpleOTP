@echo off
set JP=D:\GraalVM-Projects\gluonhq\SimpleOTP
set G=%JP%\graalvm
set T=%JP%\target

REM Clean and install the Maven project
call mvn -f "%JP%\pom.xml" clean
call mvn -f "%JP%\pom.xml" install

REM Run the project with GraalVM native-image agent (un-modularized)
java ^
--enable-preview ^
-agentlib:native-image-agent=config-merge-dir="%G%" ^
-cp "%T%\SimpleOTP-1.0.jar;%T%\modules\*" ^
com.simtechdata.Main

REM Run the project on JVM (un-modularized)
java ^
--enable-preview ^
-cp "%T%\SimpleOTP-1.0.jar;%T%\modules\*" ^
com.simtechdata.Main
