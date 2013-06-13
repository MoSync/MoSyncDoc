<!-- <mosyncheadertags>
<meta name="description" content="MoSync SDK 3.3 Release Notes." />
<meta name="keywords" content="mobile development,sdk,ide,apps,mobile,apps,android,ios,iphone,ipad,mobile,c,c++,open source,porting,dev,application,ide,cross
platform,programming,mosync,native ui,nativeui" />
<title>What's New in MoSync SDK 3.3</title>
</mosyncheadertags> -->

<style>
.screenshot
{
  width: 240px;
  height: 400px;
}
</style>

# What's New in MoSync SDK 3.3

## Summary of new features

The release of the MoSync SDK 3.3 includes new Native UI features and updates, a new 3D Graph library, UDP networking support, and several other improvements.

Download the new SDK from the [MoSync SDK download page](http://www.mosync.com/download).

Here is a summary of what is new:

* C++ Camera API (New!)
* MoGraph - C++ 3D Graph Library (New!)
* Screen transitions for NativeUI (New!)
* CustomPicker widget (New!)
* Windows Phone Native UI performance improvements (New!)
* Toast notifications on Android (New!)
* UDP networking support (New!)
* Mobile-friendly Developer website (New!)
* Screen orientation API (Updated)
* Database SQL API (Updated)
* In-app Purchase API on Android (Updated)

## C++ Camera API (New!)

Supported platforms: Android, iOS, Windows Phone.

The NativeUI C++ Camera API makes it easy to create apps that make use of the device camera(s). With this API you simply use the new widget class NativeUI::Camera to create a camera preview and manage camera settings. (By comparison, previously, when using the more low-level Syscall API, you had to set up and manage a separate widget and camera object in several steps, which is not required with the new C++ API).

The Camera widget is fully integrated into the MoSync NativeUI C++ library, which makes it straightforward to develop apps that use the camera. The Camera widget provides access to camera properties and enables full control of camera functionality. It is also easy to obtain data from the camera, using event-based image capturing.

This widget is available on the Android, iOS, and Windows Phone platforms, but depending on the OS and the device, some functionality can be limited. Zoom is available only on Android, and receiving a frame data flow is not yet possible on Windows Phone.

Try out the new [MoCamera](TEMPLATE_DOC_PATH/sdk/cpp/examples/MoCamera/index.html) example app, which uses the C++ Camera API. This example program is included in the MoSync SDK 3.3 download.

Screenshots from the MoCamera app:

![](TEMPLATE_DOC_PATH/sdk/cpp/examples/MoCamera/images/Android01.png){: .screenshot} ![](TEMPLATE_DOC_PATH/sdk/cpp/examples/MoCamera/images/Android02.png){: .screenshot}

Learn more by reading the [NativeUI Camera API](TEMPLATE_DOC_PATH/sdk/cpp/guides/camera/native-camera-api/index.html) guide. This guide is dedicated to the new Camera API.

## MoGraph - C++ 3D Graph Library (New!)

Supported platforms: Android, iOS.

With the OpenGL-based MoGraph 3D Graph Library, you can create 3D diagrams and charts, visualise data, animate diagrams, display real-time data (like weather data, traffic data, business data and market information), and create artistic applications and animations.

Check out the [MoGraph example apps](TEMPLATE_DOC_PATH/sdk/cpp/examples/mograph/index.html) to get a feel for what is possible with this library. Commented source code helps you to get started.

Sample screenshots:

![MoGraphWave 1](TEMPLATE_DOC_PATH/sdk/cpp/examples/mograph/images/MoGraphWave-1.png){: .screenshot}
![MoGraphWaveFinance 1](TEMPLATE_DOC_PATH/sdk/cpp/examples/mograph/images/MoGraphFinance-1.png){: .screenshot}
![MoGraphWave 2](TEMPLATE_DOC_PATH/sdk/cpp/examples/mograph/images/MoGraphWave2-1.png){: .screenshot}

For a short tutorial and a basic code example, go to the [MoGraph Library guide](TEMPLATE_DOC_PATH/sdk/cpp/guides/graphics/mograph/index.html).

## Screen transitions for Native UI (New!)

Supported platforms: Android, iOS, Windows Phone.

Native UI Screen transitions have been added to give apps the right the look and feel.

Screen transitions available in this release:

**iOS** | Flip-from-left/right, Curl-up/down
**Android** | Fade-in/out, Slide-left/right
**Windows Phone** | Slide-left/right, Swivel-in/out, Turnstile-forward/backward

Find out more in the [Screen transition documentation guide](TEMPLATE_DOC_PATH/sdk/cpp/guides/nativeui/using-screen-transitions/index.html).

The example app [MoCamera](TEMPLATE_DOC_PATH/sdk/cpp/examples/MoCamera/index.html) uses screen transitions.

There is also a [Screen transition test program](https://github.com/MoSync/MoSync/tree/ThreeThree/testPrograms/native_ui_lib/ScreenTransitionTest) available on GitHub you can try out.

## CustomPicker widget (New!)

Supported platforms: Android and iOS.

With the new NativeUI CustomPicker widget it becomes easy to implement drop-down lists with custom elements. Long lists support scrolling though the items (like a "spinning-wheel").

This is very handy when you wish to display selection lists on as needed, and can be used as an alternative to hierarchically organised lists, for a flatter UI structure and faster navigation experience.

Find out more in the [CustomPicker guide](TEMPLATE_DOC_PATH/sdk/cpp/guides/nativeui/using-custom-picker/index.html). It is easy to get started with the sample code included in the guide.

Here are screenshots from the code example in the guide:

![CustomPicker initial state](TEMPLATE_DOC_PATH/sdk/cpp/guides/nativeui/using-custom-picker/images/CustomPicker_Android_1.png){: .screenshot}
![CustomPicker open state](TEMPLATE_DOC_PATH/sdk/cpp/guides/nativeui/using-custom-picker/images/CustomPicker_Android_2.png){: .screenshot}

## Windows Phone Native UI performance improvements (New!)

The inner workings of the MoSync NativeUI API on Windows Phone has been redesigned to boost performance. By using a new asynchronous architecture, performance has almost doubled in average.

Benchmarking has shown that layout intensive applications benefit most from the new architecture, for example apps that feature long lists and/or complex layouts. Performance increase in our tests has ranged from x1.6 to x2 and above.

## Toast notifications on Android

Supported platforms: Android.

In MoSync SDK 3.3 you can use Toast notifications on Android.

The syscall that has been added is [maToast](http://www.mosync.com/files/imports/doxygen/latest/html/maapi_8h.html#a34e8dcb79eb5bfca2126ac7414aabd07), which is very easy to use.

Toasts display a text string on the device screen, which is visible for a short or long time (duration is controlled by the Android OS).

Here are examples of how to use this syscall:

    maToast("Hello World - Short Duration", MA_TOAST_DURATION_SHORT);
    maToast("Hello World - Long Duration", MA_TOAST_DURATION_LONG);

maToast returns 0 if function is successful, <0 if the duration parameter is invalid or the syscall is not implemented (which is the case for non-Android platforms).

A test program called [ToastNotificationTest](https://github.com/MoSync/MoSync/tree/ThreeThree/testPrograms/ToastNotificationTest) is available, see file [MainScreen.cpp](https://github.com/MoSync/MoSync/blob/ThreeThree/testPrograms/ToastNotificationTest/MainScreen.cpp) for the use of maToast. Note that this is an internal test program used during development, it is not included in the MoSync SDK download and is provided on an as-is basis.

## UDP networking support (New!)

Supported platforms: All.

MoSync SDK 3.3 adds support for the [UDP protocol](http://en.wikipedia.org/wiki/User_Datagram_Protocol). See documentation for the [maConnect](http://www.mosync.com/files/imports/doxygen/latest/html/maapi_8h.html#a1d8051cf12e5cf41b9f3917989995843) syscall. To connect using UDP, specify the "datagram:" protocol in the connect string.

The maConnect syscall is in the C API for MoSync networking. For a C++ API, see class [MAUtil::Connection](http://www.mosync.com/files/imports/doxygen/latest/html/class_m_a_util_1_1_connection.html), which provides a more high-level interface.

Two test programs are available, [udpDns](https://github.com/MoSync/MoSync/blob/ThreeThree/testPrograms/udpDns/main.cpp) and [udpMulti](https://github.com/MoSync/MoSync/blob/ThreeThree/testPrograms/udpMulti/main.cpp). Note that these are internal test programs used during development, they are provided on an as-is basis, and are not included in the official MoSync SDK examples.

You can also see an example of using datagrams for UDP broadcast in the ReloadClient in class BroadcastHander (see files [BroadcastHandler.h](https://github.com/MoSync/Reload/blob/OneOne/ReloadClient/BroadcastHandler.h) and [BroadcastHandler.cpp](https://github.com/MoSync/Reload/blob/OneOne/ReloadClient/BroadcastHandler.cpp)).

## Mobile-friendly Developer website (New!)

MoSync Developers have a new website, that contains documentation and other developer resources. The site has been created to be mobile-friendly, for easy navigation on mobile devices. It has been created using the jQuery Mobile UI library, and features a responsive menu design. This is part of our ongoing ambition to test and use mobile technologies in all aspects of our work.

The Developer website is found at: [www.mosync.com/docs](http://www.mosync.com/docs)

## Screen orientation API (Updated)

Supported platforms: Android (New!), iOS, Windows Phone.

The MoSync Orientation API has been updated. Syscall maScreenSetOrientation is deprecated. Use syscall [maScreenSetSupportedOrientations](http://www.mosync.com/files/imports/doxygen/latest/html/group___orientation_functions.html#gaab6b4b40f88c9375984e37c085e339c8) instead. See examples below.

The updated API works consistently across platforms, and allow for specific orientation settings. For example MA_SCREEN_ORIENTATION_LANDSCAPE_RIGHT, will make the orientation landscape with the home button on the right.

Note that on iOS, the new screen orientation does not take effect until the user actually changes the physical orientation of the device. On Android, the screen orientation is changed instantly.

Old syscall (deprecated, do not use):

    maScreenSetOrientation(SCREEN_ORIENTATION_LANDSCAPE);

New syscall:

    maScreenSetSupportedOrientations(MA_SCREEN_ORIENTATION_LANDSCAPE_RIGHT);

Old syscall (deprecated, do not use):

    maScreenSetOrientation(SCREEN_ORIENTATION_PORTRAIT);

New syscall:

    maScreenSetSupportedOrientations(MA_SCREEN_ORIENTATION_PORTRAIT_UP);

Old syscall (deprecated, do not use):

   maScreenSetOrientation(SCREEN_ORIENTATION_DYNAMIC);

New syscall:

   maScreenSetSupportedOrientations(MA_SCREEN_ORIENTATION_DYNAMIC);

With the new syscall, screen orientation values can be OR:ed together, as in this example:

    maScreenSetSupportedOrientations(
        MA_SCREEN_ORIENTATION_LANDSCAPE_LEFT
        | MA_SCREEN_ORIENTATION_ LANDSCAPE_RIGHT);

(Note that this actually is the same as the MA_SCREEN_ORIENTATION_LANDSCAPE orientation.)

To see the Screen orientation API in action, run the example app [ScreenOrientation](TEMPLATE_DOC_PATH/sdk/cpp/examples/screenorientation/index.html), which comes with the MoSync SDK download.

## Database SQL API (Updated)

Platforms supported: Android, iOS, MoRE.

The MoSync C Database API has been updated to support the full API on both iOS and Android. The Database API is also supported on the MoSync MoRE emulator.

To see the Databse API in action, run the [DatabaseTest example app](TEMPLATE_DOC_PATH/sdk/cpp/examples/databasetest/index.html), which is included in the MoSync SDK download. Learn more about the details in the [Database API guide](TEMPLATE_DOC_PATH/sdk/cpp/guides/storage/sql-database-api/index.html).

## In-app Purchase API on Android (Updated)

The MoSync C/C++ Purchase API has been updated on Android to use [In-app Billing Version 3](http://developer.android.com/google/play/billing/billing_overview.html). This means that your apps now support the latest version of the Google Play In-app Billing API.

To find out more about the MoSync SDK Purchase API, check out the [In-app Purchase guide](TEMPLATE_DOC_PATH/sdk/cpp/guides/purchases/managing-app-purchases/index.html).

## Known limitations

### iOS

If the project name contains spaces, the app will not work on iOS. The iOS Simulator will fail to run. See issue: [MOSYNC-2561](http://jira.mosync.com/browse/MOSYNC-2561)

### Symbian

Building apps for Symbian does not work when building on a Mac running OS X 10.7.5 or lower. See issue: [MOSYNC-2940](http://jira.mosync.com/browse/MOSYNC-2940)

### Downloader limitations

Class MAUtil::Downloader has some known problems, see issues [MOSYNC-3271](http://jira.mosync.com/browse/MOSYNC-3271) and [MOSYNC-3131](http://jira.mosync.com/browse/MOSYNC-3131).

### Issues scheduled for next release

List of [issues to be fixed in the MoSync SDK 3.3.1 release](http://jira.mosync.com/secure/IssueNavigator.jspa?mode=hide&requestId=11219).

### Limitations

List of [long-standing limitations](http://jira.mosync.com/secure/IssueNavigator.jspa?mode=hide&requestId=11218) that cannot be fixed for various reasons, such as platform/operating system limitations.

## Fixed bugs

A list of bugs fixed for MoSync SDK 3.3 release is found in the [MoSync Issue Tracker](http://jira.mosync.com/secure/IssueNavigator.jspa?mode=hide&requestId=11217).


