# Page table contains mappings from old to new pages
# and labels for each page.

# Special labels
# Do not create the target page. Used for redirect from old site.
REDIRECT="REDIRECT"
# Page is not publised, do not create any target page.
IGNORE="IGNORE"

# Home path of new website (used for redirect).
# TODO: Update this.
HOME_PATH = "HOME_PATH"

# Main documentation categories (main subjects)
COMPANY="Company Info"
CPP="C/C++"
JS="JavaScript"
RELOAD="MoSync Reload"
SDK="MoSync SDK"

# Document types
EXAMPLE="EXAMPLE"
GUIDE="GUIDE" # Coding Guide
TUTORIAL="TUTORIAL"
REFERENCE="REFERENCE"
RELEASE_NOTE="RELEASE_NOTE"

# Topics
ADS="Advertising"
ARCHITECTURE="Architecture"
BASIC="Basic Concepts"
BLUETOOTH="Bluetooth"
CUSTOMERS="Customers"
CAMERA="Camera"
COLLECTIONS="Collections"
COMMUNICATION="Communication"
DATABASE="Database"
DEBUGGING="Debugging"
DEVICE_PROFILES="Device Profiles"
EMULATORS="Emulators"
EVENTS="Event Handling"
EXTENSIONS="Extending MoSync SDK"
FONTS="Fonts"
GLOSSARY="Glossary"
GRAPHICS="Graphics"
HYBRID="Hybrid Apps"
IDE="MoSync IDE"
INSTALL="Installation"
JSON="JSON"
LIBS="Libraries"
LOCATION="Location"
LUA="Lua"
MAPS="Maps"
MAUI="MAUI"
MEMORY="Memory Management"
NFC="Near Field Communication (NFC)"
NATIVEUI="Native UI"
NOTIFICATIONS="Notifications"
OPENGL="OpenGL ES"
PIM="PIM and Contacts"
PRODUCTS="Products"
PURCHASES="Purchases"
QUICK_START="Quick Start"
RESOURCES="Resource Management"
ROADMAP="Roadmap"
SENSORS="Sensors"
SOUND="Sound"
STORAGE="Storage"
SYMBIAN="Symbian"
TESTING="Testing"
TOOLS="Tools"
WEBUI="Web UI"
WORMHOLE="Wormhole"
XML="XML"

$pages = [
#[oldfile,newfile,[tag-1,tag-2,tag-n]]
["blog/2010/03/creating-xml-documents","sdk/cpp/tutorials/xml/creating-xml-documents",[SDK,CPP,TUTORIAL,XML]],
["blog/2010/03/working-json-data","sdk/cpp/tutorials/json/working-with-json-data", [SDK,CPP,TUTORIAL,JSON]],
["blog/2010/05/serial-data-access","sdk/cpp/tutorials/storage/serial-data-access",[SDK,CPP,TUTORIAL,STORAGE]],
["blog/2013/01/how-extend-javascript-custom-c-code-opening-google-maps-hybrid-app","sdk/js/tutorials/ui/extend-javascript-with-custom-cpp-code",[SDK,JS,TUTORIAL,WEBUI,HYBRID]],
["content/3dlines","sdk/cpp/examples/3dlines",[SDK,CPP,EXAMPLE,GRAPHICS]],
["content/advertising-banner-ads",HOME_PATH,[REDIRECT]],
["content/advgraphics","sdk/cpp/examples/advgraphics",[SDK,CPP,EXAMPLE,GRAPHICS]],
["content/api-reference-manuals",HOME_PATH,[REDIRECT]],
["content/audio-sound-music-0",HOME_PATH,[REDIRECT]],
["content/beginners-guide",HOME_PATH,[REDIRECT]],
["content/cameras-capture",HOME_PATH,[REDIRECT]],
["content/c-libraries-and-c-apis",HOME_PATH,[REDIRECT]],
["content/collections-containers-0",HOME_PATH,[REDIRECT]],
["content/communications-http-bluetooth",HOME_PATH,[REDIRECT]],
["content/connections","sdk/cpp/examples/connections",[SDK,CPP,EXAMPLE,COMMUNICATION]],
["content/creating-html5javascript-apps","sdk/js/tutorials/quick-start/getting-started-html5-and-javascript",[REDIRECT]],
["content/databases-stores-files-storage",HOME_PATH,[REDIRECT]],
["content/debugging","sdk/cpp/examples/debugging",[SDK,CPP,EXAMPLE,DEBUGGING]],
["content/debugging-testing-performance",HOME_PATH,[REDIRECT]],
["content/demo-examples",HOME_PATH,[REDIRECT]],
["content/developing-application-using-maui","sdk/cpp/guides/maui/gui-based-applications-with-maui",[SDK,CPP,GUIDE,MAUI]],
["content/developing-classic-procedural-applications","sdk/cpp/tutorials/basic/classic-procedural-applications",[SDK,CPP,TUTORIAL,BASIC]],
["content/developing-event-driven-object-oriented-applications","sdk/cpp/tutorials/basic/event-driven-object-oriented-applications",[SDK,CPP,TUTORIAL,BASIC]],
["content/development-models","sdk/cpp/tutorials/basic/development-models",[SDK,CPP,TUTORIAL,BASIC]],
["content/events-keys-touch-moblets",HOME_PATH,[REDIRECT]],
["content/example-application-descriptions",HOME_PATH,[REDIRECT]],
["content/extending-html5-apps-lua","sdk/js/tutorials/lua/extending-html5-apps-lua",[SDK,JS,TUTORIAL,LUA]],
["content/facebook-wikipedia-twitter",HOME_PATH,[REDIRECT]],
["content/fonts",HOME_PATH,[REDIRECT]],
["content/fun-things-do-lovesms-example-application","sdk/js/tutorials/ui/fun-things-do-lovesms-example-application",[SDK,JS,TUTORIAL,WEBUI]],
["content/graphics-drawing-opengl-es",HOME_PATH,[REDIRECT]],
["content/hellomoblet","sdk/cpp/examples/hellomoblet",[SDK,CPP,EXAMPLE,BASIC]],
["content/html5-javascript-wormhole","sdk/js/guides/wormhole/html5-javascript-wormhole",[SDK,JS,GUIDE,WORMHOLE,LIBS]],
["content/location-gps","sdk/cpp/examples/location-gps",[SDK,CPP,EXAMPLE,LOCATION]],
["content/location-gps-maps-0",HOME_PATH,[REDIRECT]],
["content/mastx","sdk/cpp/examples/mastx",[SDK,CPP,EXAMPLE,MEMORY]],
["content/memory-heap-stack-0",HOME_PATH,[REDIRECT]],
["content/mixing-javascript-and-lua-dynamic-language-interplay","sdk/js/tutorials/lua/mixing-javascript-and-lua-dynamic-language-interplay",[SDK,JS,TUTORIAL,LUA]],
["content/mosketch-0","sdk/cpp/examples/mosketch",[SDK,CPP,EXAMPLE,GRAPHICS]],
["content/mosound","sdk/cpp/examples/mosound",[SDK,CPP,EXAMPLE,SOUND]],
["content/motooth","sdk/cpp/examples/motooth",[SDK,CPP,EXAMPLE,BLUETOOTH]],
["content/motris-0","sdk/cpp/examples/motris",[SDK,CPP,EXAMPLE,GRAPHICS]],
["content/notifications-1",HOME_PATH,[REDIRECT]],
["content/otaload","sdk/cpp/examples/otaload",[SDK,CPP,EXAMPLE,COMMUNICATION]],
["content/pim-contacts",HOME_PATH,[REDIRECT]],
["content/platforms-devices-profiles",HOME_PATH,[REDIRECT]],
["content/programming-mosync",HOME_PATH,[REDIRECT]],
["content/rendering-particles-mixing-html5-and-native-ui-opengl-using-mosync","sdk/js/tutorials/graphics/rendering-particles-mixing-html5-and-native-ui-opengl-using-mosync",[SDK,JS,TUTORIAL,GRAPHICS]],
["content/resources-binaries-placeholders-0",HOME_PATH,[REDIRECT]],
["content/screencasts","screencasts",[REDIRECT]],
["content/sensors-orientation-nfc",HOME_PATH,[REDIRECT]],
["content/simple","sdk/cpp/examples/simple",[SDK,CPP,EXAMPLE,EVENTS]],
["content/standard-cc-libraries-0","sdk/cpp/guides/libs/standard-cc-libraries",[SDK,CPP,GUIDE,LIBS]],
["content/stylus","sdk/cpp/examples/stylus",[SDK,CPP,EXAMPLE,GRAPHICS]],
["content/timer","sdk/cpp/examples/timer",[SDK,CPP,EXAMPLE,EVENTS]],
["content/unit-test","sdk/cpp/examples/unit-test",[SDK,CPP,EXAMPLE,TESTING]],
["content/user-interfaces-nativeui-maui-0",HOME_PATH,[REDIRECT]],
["content/using-mosync-ide-2",HOME_PATH,[REDIRECT]],
["content/using-mosync-reload","reload/guides/quick-start/mosync-reload-overview",[RELOAD,GUIDE,QUICK_START]],
["content/using-mosync-visual-studio","sdk/tools/guides/extensions/using-mosync-visual-studio",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["content/whats-new-release-notes",HOME_PATH,[REDIRECT]],
["content/xml-soap-json",HOME_PATH,[REDIRECT]],
["contributions","sdk/tools/guides/extensions/extending-mosync-sdk",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/architecture",HOME_PATH,[REDIRECT]],
["documentation/billing-app-purchases",HOME_PATH,[REDIRECT]],
["documentation/manualpage/creating-your-first-application","sdk/cpp/tutorials/quick-start/creating-your-first-cpp-application",[SDK,CPP,TUTORIAL,QUICK_START]],
["documentation/manualpage/emulating-device","sdk/tools/guides/emulators/emulating-device",[SDK,TOOLS,GUIDE,EMULATORS]],
["documentation/manualpage/finalizing-applications","sdk/tools/guides/ide/finalizing-applications",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpage/font-tools","sdk/cpp/guides/maui/font-tools",[SDK,CPP,GUIDE,MAUI,FONTS]],
["documentation/manualpage/installing-mosync","sdk/tools/guides/ide/installing-mosync",[SDK,TOOLS,GUIDE,INSTALL]],
["documentation/manualpage/launching-mosync","sdk/tools/guides/ide/launching-mosync",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpage/mosync-glossary","sdk/tools/guides/architecture/mosync-glossary",[SDK,TOOLS,GUIDE,GLOSSARY]],
["documentation/manualpage/resource-compiler-tutorial","sdk/tools/guides/ide/resource-compiler-tutorial",[SDK,TOOLS,GUIDE,IDE,RESOURCES]],
["documentation/manualpage/scanning-device","sdk/tools/guides/ide/scanning-for-device",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpage/sending-device","sdk/tools/guides/ide/sending-to-device",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpage/using-device-profiles","sdk/tools/guides/ide/using-device-profiles",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/accelerometeropengles","sdk/cpp/examples/accelerometeropengles",[SDK,CPP,EXAMPLE,SENSORS,OPENGL]],
["documentation/manualpages/adding-application-icons","sdk/tools/guides/ide/adding-application-icons",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/app-advertisement-javascript-developers","sdk/js/guides/ads/app-advertisement-javascript",[SDK,JS,GUIDE,ADS]],
["documentation/manualpages/application-profiling-mosync-emulator","sdk/tools/guides/emulators/application-profiling-mosync-emulator",[SDK,CPP,GUIDE,EMULATORS]],
["documentation/manualpages/audio","sdk/cpp/guides/sound/audio",[SDK,CPP,GUIDE,SOUND]],
["documentation/manualpages/bluetoothclient","sdk/cpp/examples/bluetoothclient",[SDK,CPP,EXAMPLE,BLUETOOTH]],
["documentation/manualpages/bluetoothserver","sdk/cpp/examples/bluetoothserver",[SDK,CPP,EXAMPLE,BLUETOOTH]],
["documentation/manualpages/buidling-and-running-examples","sdk/tools/guides/ide/building-and-running-examples",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/build-configurations","sdk/tools/guides/ide/build-configurations",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/build-configurations","sdk/tools/guides/ide/build-configurations",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/building-moblin-runtimes","sdk/tools/guides/extensions/building-moblin-runtimes-linux",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/manualpages/building-mosync-sdk-source-os-x","sdk/tools/guides/extensions/building-mosync-sdk-source-os-x",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/manualpages/building-mosync-source-linux","sdk/tools/guides/extensions/building-mosync-source-linux",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/manualpages/building-mosync-source-windows","sdk/tools/guides/extensions/building-mosync-source-windows",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/manualpages/building-photo-gallery","sdk/js/examples/photogallery-explained",[SDK,JS,EXAMPLE,TUTORIAL,CAMERA,COMMUNICATION]],
["documentation/manualpages/camerademo","sdk/cpp/examples/camerademo",[SDK,CPP,EXAMPLE,CAMERA,NATIVEUI]],
["documentation/manualpages/coding-conventions","sdk/tools/guides/extensions/coding-conventions",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/manualpages/controlling-cameras","sdk/cpp/guides/camera/controlling-cameras",[SDK,CPP,GUIDE,CAMERA]],
["","sdk/cpp/guides/camera/native-camera-api",[SDK,CPP,GUIDE,CAMERA]],
["documentation/manualpages/controlling-sensors","sdk/cpp/guides/sensors/controlling-sensors",[SDK,CPP,GUIDE,SENSORS]],
["documentation/manualpages/creating-new-workspace","sdk/tools/guides/ide/creating-new-workspace",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/creating-user-interfaces-mosync","sdk/cpp/guides/ui/creating-user-interfaces-mosync",[SDK,CPP,GUIDE,NATIVEUI,WEBUI,MAUI]],
["documentation/manualpages/c-standard-template-library-stl","sdk/cpp/guides/libs/c-standard-template-library-stl",[SDK,CPP,GUIDE,LIBS]],
["documentation/manualpages/databasetest","sdk/cpp/examples/databasetest",[SDK,CPP,EXAMPLE,DATABASE]],
["documentation/manualpages/debugging-javascript-device","sdk/tools/guides/ide/debugging-javascript-device",[SDK,TOOLS,GUIDE,JS,IDE,DEBUGGING]],
["documentation/manualpages/debugging-javascript-ios-mosync-reload","reload/guides/debugging/debugging-javascript-ios-mosync-reload",[RELOAD,GUIDE,DEBUGGING]],
["documentation/manualpages/debugging-javascript-rlog","reload/guides/debugging/debugging-javascript-rlog",[RELOAD,GUIDE,DEBUGGING]],
["documentation/manualpages/developing-android-applications","sdk/tools/guides/ide/developing-android-applications",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/developing-iphone-applications","sdk/tools/guides/ide/developing-iphone-applications",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/developing-windows-phone-applications","sdk/tools/guides/ide/developing-windows-phone-applications",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/devicefonts","sdk/cpp/examples/devicefonts",[SDK,CPP,EXAMPLE,FONTS]],
["documentation/manualpages/devicefontsnativeui","sdk/cpp/examples/devicefontsnativeui",[SDK,CPP,EXAMPLE,FONTS,NATIVEUI]],
["documentation/manualpages/device-profile-database","sdk/tools/guides/ide/device-profile-database",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/documentation-latest-nightly-builds","",[IGNORE]],
["documentation/manualpages/essential-guide-developing-apps-html5javascript","",[IGNORE]],
["documentation/manualpages/europeancountries","sdk/cpp/examples/europeancountries",[SDK,CPP,EXAMPLE,NATIVEUI]],
["documentation/manualpages/event-handling-mosync-hybrid-app","sdk/js/guides/basic/event-handling-mosync-hybrid-app",[SDK,JS,GUIDE,BASIC,HYBRID,ARCHITECTURE]],
["documentation/manualpages/facebookdemo","sdk/cpp/examples/facebookdemo",[SDK,CPP,EXAMPLE,NATIVEUI]],
["documentation/manualpages/featureplatform-matrix-old","",[IGNORE]],
["documentation/manualpages/file-storage-syscall-functions","sdk/cpp/guides/storage/file-storage-syscall-functions",[SDK,CPP,GUIDE,STORAGE]],
["documentation/manualpages/forum-posters","",[IGNORE]],
["documentation/manualpages/framebuffer-api","sdk/cpp/guides/graphics/framebuffer-api",[SDK,CPP,GUIDE,GRAPHICS]],
["documentation/manualpages/getting-started-html5-and-javascript","sdk/js/tutorials/quick-start/getting-started-html5-and-javascript",[SDK,JS,TUTORIAL,QUICK_START]],
["documentation/manualpages/getting-started-mosync-ide","sdk/tools/guides/ide/tour-of-the-mosync-sdk-ide",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/glmobletopengles1","sdk/cpp/examples/glmobletopengles1",[SDK,CPP,EXAMPLE,GRAPHICS,OPENGL]],
["documentation/manualpages/glmobletopengles2","sdk/cpp/examples/glmobletopengles2",[SDK,CPP,EXAMPLE,GRAPHICS,OPENGL]],
["documentation/manualpages/gpsareacalculator","",[IGNORE]],
["documentation/manualpages/graphics-clipping-draw-targets","sdk/cpp/guides/graphics/graphics-clipping-draw-targets",[SDK,CPP,GUIDE,GRAPHICS]],
["documentation/manualpages/graphics-primitives","sdk/cpp/guides/graphics/graphics-primitives",[SDK,CPP,GUIDE,GRAPHICS]],
["documentation/manualpages/graphun","sdk/cpp/examples/graphun",[SDK,CPP,EXAMPLE,GRAPHICS,NATIVEUI,OPENGL]],
["documentation/manualpages/hellomap","sdk/cpp/examples/hellomap",[SDK,CPP,EXAMPLE,MAUI,MAPS]],
["documentation/manualpages/hellomaui","sdk/cpp/examples/hellomaui",[SDK,CPP,EXAMPLE,MAUI]],
["documentation/manualpages/hellonativeui","sdk/cpp/examples/hellonativeui",[SDK,CPP,EXAMPLE,NATIVEUI]],
["documentation/manualpages/helloopengles","sdk/cpp/examples/helloopengles",[SDK,CPP,EXAMPLE,OPENGL]],
["documentation/manualpages/helloworld","sdk/cpp/examples/helloworld",[SDK,CPP,EXAMPLE,BASIC]],
["documentation/manualpages/hello-world-deconstructed","sdk/cpp/tutorials/hello-world-deconstructed",[SDK,CPP,TUTORIAL,BASIC]],
["documentation/manualpages/how-communicate-between-javascript-and-c-mosync","sdk/js/guides/wormhole/extending-javascript-with-cpp",[SDK,CPP,JS,GUIDE,WORMHOLE,HYBRID]],
["documentation/manualpages/how-create-html5-project-mosync","sdk/js/tutorials/quick-start/how-create-html5-project-mosync",[SDK,JS,TUTORIAL,QUICK_START]],
["documentation/manualpages/http-connections","sdk/cpp/guides/communication/http-connections",[SDK,CPP,GUIDE,COMMUNICATION]],
["documentation/manualpages/importing-example-applications","sdk/tools/guides/ide/importing-example-applications",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/installing-mosync-os-x","sdk/tools/guides/ide/installing-mosync-os-x",[SDK,TOOLS,GUIDE,INSTALL]],
["documentation/manualpages/installing-mosync-reload","reload/guides/quick-start/mosync-reload-quick-start",[REDIRECT]],
["documentation/manualpages/interacting-user-through-javascript","sdk/js/guides/ui/interacting-with-users-using-javascript",[SDK,JS,GUIDE,WEBUI]],
["documentation/manualpages/issue-tracker","sdk/tools/guides/extensions/issue-tracker",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/manualpages/javascripthtml5-cross-platform-user-interfaces-0","sdk/cpp/guides/ui/javascript-html5-cross-platform-user-interfaces",[SDK,CPP,JS,GUIDE,WEBUI]],
["documentation/manualpages/javascripthtml5-cross-platform-user-interfaces","",[IGNORE]],
["documentation/manualpages/jsnativeui-library","sdk/js/guides/nativeui/jsnativeui-library",[SDK,JS,GUIDE,NATIVEUI,LIBS]],
["documentation/manualpages/mafs-library-cc","sdk/cpp/guides/storage/mafs-library",[SDK,CPP,GUIDE,STORAGE,LIBS]],
["documentation/manualpages/managing-app-purchases","sdk/cpp/guides/purchases/managing-app-purchases",[SDK,CPP,GUIDE,PURCHASES]],
["documentation/manualpages/map-class","sdk/cpp/guides/collections/dictionaries",[SDK,CPP,GUIDE,COLLECTIONS]],
["documentation/manualpages/mapdemo","sdk/cpp/examples/mapdemo",[SDK,CPP,EXAMPLE,MAPS]],
["documentation/manualpages/map-library-c","sdk/cpp/guides/maps/map-library",[SDK,CPP,GUIDE,MAPS]],
["documentation/manualpages/mauiex","sdk/cpp/examples/mauiex",[SDK,CPP,EXAMPLE,MAUI]],
["documentation/manualpages/mautilconnection-sockets","sdk/cpp/guides/communication/mautil-connection-sockets",[SDK,CPP,GUIDE,COMMUNICATION]],
["documentation/manualpages/mautil-framebuffer-cc","sdk/cpp/guides/graphics/mautil-framebuffer",[SDK,CPP,GUIDE,GRAPHICS]],
["documentation/manualpages/mautil-graphics-cc","sdk/cpp/guides/graphics/mautil-graphics",[SDK,CPP,GUIDE,GRAPHICS]],
["documentation/manualpages/mdlbenchmark","sdk/cpp/examples/mdlbenchmark",[SDK,CPP,EXAMPLE,GRAPHICS]],
["documentation/manualpages/mosync-reload","reload/guides/quick-start/mosync-reload-quick-start",[RELOAD,GUIDE,QUICK_START]],
["documentation/manualpages/more-mosync-runtime-environment","sdk/tools/guides/emulators/more-mosync-runtime-environment",[SDK,TOOLS,GUIDE,EMULATORS]],
["documentation/manualpages/mosync-user-forum","",[IGNORE]],
["documentation/manualpages/mosync-visual-studio-2010","sdk/tools/guides/extensions/mosync-visual-studio-2010",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/manualpages/multitouch","sdk/cpp/examples/multitouch",[SDK,CPP,EXAMPLE,EVENTS]],
["documentation/manualpages/nativeuidemo","sdk/cpp/examples/nativeuidemo",[SDK,CPP,EXAMPLE,NATIVEUI,ADS]],
["documentation/manualpages/nativeuimap","sdk/cpp/examples/nativeuimap",[SDK,CPP,EXAMPLE,NATIVEUI]],
["documentation/manualpages/new-doxygen-front-cover-do-not-delete-or-publish","",[IGNORE]],
["documentation/manualpages/nfcexample","sdk/js/examples/nfcexample",[SDK,JS,EXAMPLE,NFC,WEBUI,HYBRID]],
["documentation/manualpages/optimizing-mobile-applications","sdk/cpp/guides/testing/optimizing-mobile-applications",[SDK,CPP,GUIDE,TESTING]],
["documentation/manualpages/photogallery","sdk/js/examples/photogallery",[SDK,JS,EXAMPLE,WEBUI,NATIVEUI,CAMERA,HYBRID]],
["documentation/manualpages/pim-access-and-control","sdk/cpp/guides/pim/pim-access-and-control",[SDK,CPP,GUIDE,PIM]],
["documentation/manualpages/pimdemo","sdk/cpp/examples/pimdemo",[SDK,CPP,EXAMPLE,PIM]],
["documentation/manualpages/projects-and-templates","sdk/tools/guides/ide/projects-and-templates",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/purchaseexample","sdk/cpp/examples/purchaseexample",[SDK,CPP,EXAMPLE,PURCHASES]],
["documentation/manualpages/purchase-library-and-api","sdk/cpp/guides/libs/purchase-library-and-api",[SDK,CPP,GUIDE,PURCHASES,LIBS]],
["documentation/manualpages/reading-sensors-javascript","sdk/js/guides/sensors/reading-sensors-javascript",[SDK,JS,GUIDE,SENSORS]],
["documentation/manualpages/resource-compiler-reference","sdk/tools/guides/ide/resource-compiler-reference",[SDK,TOOLS,GUIDE,IDE,RESOURCES]],
["documentation/manualpages/resourcetest","sdk/cpp/examples/resourcetest",[SDK,CPP,EXAMPLE,RESOURCES]],
["documentation/manualpages/reload-command-line-tool","reload/guides/tools/reload-command-line-tool",[RELOAD,GUIDE,TOOLS]],
["documentation/manualpages/rockpaperscissors","sdk/cpp/examples/rockpaperscissors",[SDK,CPP,EXAMPLE,NATIVEUI]],
["documentation/manualpages/running-phonegap-app-mosync","sdk/js/guides/wormhole/running-phonegap-app-mosync",[SDK,JS,GUIDE,WORMHOLE]],
["documentation/manualpages/runtime-architecture","sdk/tools/guides/architecture/runtime-architecture",[SDK,TOOLS,GUIDE,ARCHITECTURE]],
["documentation/manualpages/runtimes","sdk/tools/guides/architecture/runtimes",[SDK,TOOLS,GUIDE,ARCHITECTURE]],
["documentation/manualpages/screenorientation","sdk/cpp/examples/screenorientation",[SDK,CPP,EXAMPLE,SENSORS]],
["documentation/manualpages/sensortest","sdk/cpp/examples/sensortest",[SDK,CPP,EXAMPLE,SENSORS]],
["documentation/manualpages/setting-application-permissions","sdk/tools/guides/ide/setting-application-permissions",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/soap","sdk/cpp/examples/soap",[SDK,CPP,EXAMPLE,COMMUNICATION]],
["documentation/manualpages/sql-database-api","sdk/cpp/guides/storage/sql-database-api",[SDK,CPP,GUIDE,STORAGE]],
["documentation/manualpages/stopwatch","",[IGNORE]],
["documentation/manualpages/symbian-packaging-parameters","sdk/tools/guides/ide/symbian-packaging-parameters",[SDK,TOOLS,IDE,SYMBIAN]],
["documentation/manualpages/testify-test-framework","sdk/cpp/guides/testing/testify-test-framework",[SDK,CPP,GUIDE,TESTING]],
["documentation/manualpages/toolchain","sdk/tools/guides/architecture/toolchain",[SDK,TOOLS,GUIDE,ARCHITECTURE]],
["documentation/manualpages/update-wormhole","sdk/js/guides/wormhole/update-wormhole",[SDK,JS,GUIDE,WORMHOLE]],
["documentation/manualpages/using-advertising-library-and-api","sdk/cpp/guides/ads/advertising-library-and-api",[SDK,CPP,GUIDE,ADS]],
["documentation/manualpages/using-audio-api","sdk/cpp/guides/sound/using-audio-api",[SDK,CPP,GUIDE,SOUND]],
["documentation/manualpages/using-c-notification-library","sdk/cpp/guides/notifications/using-notification-library",[SDK,CPP,GUIDE,NOTIFICATIONS]],
["documentation/manualpages/using-capture-api","sdk/cpp/guides/camera/using-capture-api",[SDK,CPP,GUIDE,CAMERA]],
["documentation/manualpages/using-debugger","sdk/tools/guides/ide/using-debugger",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/using-facebook-library","sdk/cpp/guides/communication/using-facebook-library",[SDK,CPP,GUIDE,COMMUNICATION]],
["documentation/manualpages/using-javascript-callbacks","sdk/js/guides/basic/using-javascript-callbacks",[SDK,JS,GUIDE,BASIC]],
["documentation/manualpages/using-listview-widget","sdk/cpp/guides/nativeui/using-listview-widget",[SDK,CPP,GUIDE,NATIVEUI]],
["documentation/manualpages/using-nativeui-library","sdk/cpp/guides/nativeui/using-nativeui-library",[SDK,CPP,GUIDE,NATIVEUI]],
["documentation/manualpages/using-nativeui-map-widget","sdk/cpp/guides/nativeui/using-nativeui-map-widget",[SDK,CPP,GUIDE,NATIVEUI,MAPS]],
["documentation/manualpages/using-pipe-tool","sdk/tools/guides/ide/using-pipe-tool",[SDK,TOOLS,GUIDE,IDE]],
["documentation/manualpages/using-placeholders-and-handles","sdk/cpp/guides/memory/using-placeholders-and-handles",[SDK,CPP,GUIDE,MEMORY]],
["documentation/manualpages/using-reloads-javascript-workbench","reload/guides/tools/using-javascript-workbench",[RELOAD,GUIDE,DEBUGGING]],
["documentation/manualpages/using-sql-hybrid-apps","sdk/js/guides/storage/using-sql-hybrid-apps",[SDK,JS,GUIDE,STORAGE,HYBRID]],
["documentation/manualpages/using-web-sql-mosync-apps","sdk/js/guides/storage/using-web-sql",[SDK,JS,GUIDE,STORAGE]],
["documentation/manualpages/vector-class","sdk/cpp/guides/collections/vector",[SDK,CPP,GUIDE,COLLECTIONS]],
["documentation/manualpages/videonativeuiexample","sdk/cpp/examples/videonativeuiexample",[SDK,CPP,EXAMPLE,NATIVEUI]],
["documentation/manualpages/webviewgeolocation","sdk/js/examples/webviewgeolocation",[SDK,JS,EXAMPLE,WEBUI,NATIVEUI,LOCATION,HYBRID]],
["documentation/manualpages/webviewlovesms","sdk/js/examples/webviewlovesms",[SDK,JS,EXAMPLE,WEBUI,HYBRID]],
["documentation/manualpages/webviewtwitter","sdk/js/examples/webviewtwitter",[SDK,JS,EXAMPLE,WEBUI,COMMUNICATION]],
["documentation/release-notes/whats-new-mosync-reload-10","reload/release-notes/whats-new-mosync-reload-10",[RELOAD,TOOLS,RELEASE_NOTE]],
["documentation/release-notes/whats-new-mosync-30","sdk/release-notes/whats-new-mosync-sdk-30",[SDK,TOOLS,RELEASE_NOTE]],
["documentation/release-notes/whats-new-mosync-31","sdk/release-notes/whats-new-mosync-sdk-31",[SDK,TOOLS,RELEASE_NOTE]],
["documentation/release-notes/whats-new-mosync-sdk-32","sdk/release-notes/whats-new-mosync-sdk-32",[SDK,TOOLS,RELEASE_NOTE]],
["documentation/release-notes/whats-new-mosync-sdk-321","sdk/release-notes/whats-new-mosync-sdk-321",[SDK,TOOLS,RELEASE_NOTE]],
["documentation/manualpages/wikisearchnativeui","sdk/cpp/examples/wikisearchnativeui",[SDK,CPP,GUIDE,NATIVEUI,COMMUNICATION]],
["documentation/manualpages/working-device-fonts-api","sdk/cpp/guides/fonts/working-with-device-fonts-api",[SDK,CPP,GUIDE,FONTS]],
["documentation/manualpages/working-javascript-prototypes","sdk/js/guides/basic/working-with-javascript-prototypes",[SDK,JS,GUIDE,BASIC]],
["documentation/manualpages/working-mosync-libraries","sdk/cpp/guides/libs/working-with-mosync-libraries",[SDK,CPP,GUIDE,LIBS]],
["documentation/manualpages/working-opengl-es","sdk/cpp/guides/graphics/using-opengles",[SDK,CPP,GUIDE,OPENGL,GRAPHICS]],
["documentation/manualpages/wormholedemo","sdk/js/examples/wormholedemo",[SDK,JS,GUIDE,WEBUI,SENSORS,LOCATION,STORAGE,WORMHOLE]],
["documentation/manualpages/wormholenativeui","sdk/js/examples/wormholenativeui",[SDK,JS,GUIDE,NATIVEUI]],
["documentation/manualpages/writing-new-extensions-mosync","sdk/tools/guides/extensions/writing-extensions",[SDK,TOOLS,GUIDE,EXTENSIONS]],
["documentation/manualpages/xml-mtxml-parser-c","sdk/cpp/guides/xml/xml-mtxml-parser-c",[SDK,CPP,GUIDE,XML]],
["documentation/manualpages/xml-mtxml-parser","sdk/cpp/guides/xml/xml-mtxml-parser",[SDK,CPP,GUIDE,XML]],
["documentation/mosync-architecture",HOME_PATH,[REDIRECT]],
["documentation/tutorials/adding-resources-mosync-project","sdk/cpp/tutorials/adding-resources-mosync-project",[SDK,CPP,TUTORIAL,RESOURCES]],
["documentation/tutorials/collections-mosync","sdk/cpp/tutorials/collections/collections-mosync",[SDK,CPP,TUTORIAL,COLLECTIONS]],
["documentation/tutorials/creating-bluetooth-clients","sdk/cpp/tutorials/communication/creating-bluetooth-clients",[SDK,CPP,TUTORIAL,BLUETOOTH]],
["documentation/tutorials/creating-bluetooth-server","sdk/cpp/tutorials/communication/creating-bluetooth-server",[SDK,CPP,TUTORIAL,BLUETOOTH]],
["documentation/tutorials/creating-new-fonts","sdk/cpp/tutorials/maui/creating-new-fonts",[SDK,CPP,TUTORIAL,MAUI,FONTS]],
["documentation/tutorials/creating-new-screens","sdk/cpp/tutorials/maui/creating-new-screens",[SDK,CPP,TUTORIAL,MAUI]],
["documentation/tutorials/custom-downloaders","sdk/cpp/tutorials/communication/custom-downloaders",[SDK,CPP,TUTORIAL,COMMUNICATION]],
["documentation/tutorials/detecting-events-cc","sdk/cpp/guides/events/detecting-events",[SDK,CPP,GUIDE,EVENTS]],
["documentation/tutorials/determining-location","sdk/cpp/tutorials/sensors/determining-location",[SDK,CPP,TUTORIAL,LOCATION,SENSORS]],
["documentation/tutorials/discovering-devices-and-services-bluetooth","sdk/cpp/tutorials/bluetooth/discovering-devices-and-services-bluetooth",[SDK,CPP,TUTORIAL,BLUETOOTH]],
["documentation/tutorials/downloading-audio-internet","sdk/cpp/tutorials/communication/downloading-audio",[SDK,CPP,TUTORIAL,COMMUNICATION,SOUND]],
["documentation/tutorials/downloading-data-internet-0","sdk/cpp/tutorials/communication/downloading-data",[SDK,CPP,TUTORIAL,COMMUNICATION]],
["documentation/tutorials/downloading-images-internet","sdk/cpp/tutorials/communication/downloading-images",[SDK,CPP,TUTORIAL,COMMUNICATION,GRAPHICS]],
["documentation/tutorials/introduction-maui","sdk/cpp/tutorials/maui/introduction-maui",[SDK,CPP,TUTORIAL,MAUI]],
["documentation/tutorials/mosync-java-and-c-developers","sdk/cpp/guides/basic/mosync-for-java-and-csharp-developers",[SDK,CPP,GUIDE,BASIC]],
["documentation/tutorials/processing-xml","sdk/cpp/tutorials/xml/processing-xml",[SDK,CPP,TUTORIAL,XML]],
["documentation/tutorials/push-notification-tutorial","sdk/cpp/guides/notifications/push-notification-tutorial",[SDK,CPP,GUIDE,NOTIFICATIONS]],
["documentation/tutorials/reading-and-writing-data","sdk/cpp/tutorials/storage/reading-and-writing-data",[SDK,CPP,TUTORIAL,STORAGE]],
["documentation/tutorials/starting-mosync-development-java-and-c-developers","",[IGNORE]],
["documentation/tutorials/starting-new-moblet-project","sdk/cpp/tutorials/maui/starting-new-moblet-project",[SDK,CPP,TUTORIAL,MAUI]],
["documentation/tutorials/using-layouts","sdk/cpp/tutorials/maui/using-layouts",[SDK,CPP,TUTORIAL,MAUI]],
["documentation/using-mosync-ide",HOME_PATH,[REDIRECT]],
["documentation/wormhole-guides-tutorials-examples",HOME_PATH,[REDIRECT]],
["widepage/feature-platform-support", "sdk/tools/references/feature-platform-support",[SDK,REFERENCE,LIBS]],
]
