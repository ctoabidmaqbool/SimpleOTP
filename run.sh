#!/bin/bash
JP="/mnt/d/GraalVM-Projects/gluonhq/SimpleOTP"
G="$JP/graalvm"
T="$JP/target"

# Clean and install the Maven project
mvn -f "$JP/pom.xml" clean
mvn -f "$JP/pom.xml" install

# Run the project with GraalVM native-image agent
java \
--enable-preview \
-agentlib:native-image-agent=config-merge-dir="$G" \
--module-path "$T/SimpleOTP-1.0.jar:$T/modules" \
-m SimpleOTP/com.simtechdata.Main graalvm

# Run the project on JVM
java \
--enable-preview \
--module-path "$T/SimpleOTP-1.0.jar:$T/modules" \
-m SimpleOTP/com.simtechdata.Main