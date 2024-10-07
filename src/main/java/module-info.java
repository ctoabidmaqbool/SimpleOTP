module SimpleOTP {
    requires dorkbox.systemtray;
    requires dorkbox.utilities;
    requires dorkbox.desktop;
    requires java.desktop;
    requires javafx.base;
    requires javafx.controls;
    requires javafx.graphics;
    requires javafx.media;
    requires javafx.web;

//    exports dorkbox to javafx.graphics;
    exports dorkbox to org.graalvm.nativeimage.builder;

    opens com.simtechdata;
}