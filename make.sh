#!/bin/bash

JP=$HOME/JetBrainsProjects/IntelliJIdea/SimpleOTP
G=$JP/graalvm
T=$JP/target

mvn -f $JP/pom.xml clean install
echo "Running native-image"
native-image \
--no-fallback \
--verbose \
--enable-preview \
--module-path $T/SimpleOTP-1.0.jar:$T/modules:$HOME/.m2/repository/org/xerial/sqlite-jdbc/3.45.3.0/sqlite-jdbc-3.45.3.0.jar \
--module SimpleOTP/com.simtechdata.Main \
--initialize-at-build-time=org.sqlite.util.ProcessRunner \
-H:+UnlockExperimentalVMOptions \
-H:+ReportExceptionStackTraces \
-H:JNIConfigurationFiles=$G/jni-config.json \
-H:DynamicProxyConfigurationFiles=$G/proxy-config.json \
-H:ReflectionConfigurationFiles=$G/reflect-config.json \
-H:ResourceConfigurationFiles=$G/resource-config.json \
-H:SerializationConfigurationFiles=$G/serialization-config.json \
-H:Name=$T/SimpleOTP

cp $T/SimpleOTP $HOME/JavaBASH/