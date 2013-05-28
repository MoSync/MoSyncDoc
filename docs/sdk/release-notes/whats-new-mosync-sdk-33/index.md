<!-- <mosyncheadertags>
<meta name="description" content="MoSync SDK 3.3 Release Notes." />
<meta name="keywords" content="mobile development,sdk,ide,apps,mobile,apps,android,ios,iphone,ipad,mobile,c,c++,open source,porting,dev,application,ide,cross
platform,programming,mosync,native ui,nativeui" />
<title>MoSync SDK 3.3 Release Notes</title>
</mosyncheadertags> -->

# MoSync SDK 3.3 Release Notes

**Note: This page is only valid for the upcoming MoSync SDK 3.3 release.**

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

Find out more by reading the [NativeUI Camera API](http://www.mosync.com/docs/sdk/cpp/guides/camera/native-camera-api/index.html) guide. This guide is dedicated to the new Camera API.

Learn more by trying out the new camera example app, [MoCamera](http://www.mosync.com/docs/sdk/cpp/examples/MoCamera/index.html), which uses the C++ Camera API. This example program is included in the MoSync SDK 3.3 download.

## MoGraph - C++ 3D Graph Library (New!)

Supported platforms: Android, iOS.

With the OpenGL-based MoGraph 3D Graph Library, you can create 3D diagrams and charts, visualise data, animate diagrams, display real-time data (like weather data, traffic data, business data and market information), and create artistic applications and animations, and make various kinds of games.

Check out the [MoGraph example apps](http://www.mosync.com/docs/sdk/cpp/examples/mograph/index.html) to get a feel for what is possible with this library. Commented source code helps you to get started.

For a short tutorial and a basic code example, go to the [MoGraph Library guide](http://www.mosync.com/docs/sdk/cpp/guides/graphics/mograph/index.html).

## Screen transitions for Native UI (New!)

Supported platforms: Android, iOS, Windows Phone.

Native UI Screen transitions have been added to give apps the right the look and feel.

Screen transitions available in this release:

**iOS** | Flip-from-left/right, Curl-up/down
**Android** | Fade-in/out, Slide-left/right
**Windows Phone** | Slide-left/right, Swivel-in/out, Turnstile-forward/backward

Find out more in the [Screen transition documentation guide](http://www.mosync.com/docs/sdk/cpp/guides/nativeui/using-screen-transitions/index.html).

The example app [MoCamera](http://www.mosync.com/docs/sdk/cpp/examples/MoCamera/index.html) uses screen transitions.

There is also a [Screen transition test program](https://github.com/MoSync/MoSync/tree/ThreeThree/testPrograms/native_ui_lib/ScreenTransitionTest) available on GitHub you can try out.

## CustomPicker widget (New!)

Supported platforms: Android and iOS.

With the new NativeUI CustomPicker widget it becomes easy to implement drop-down lists with custom elements. Long lists support scrolling though the items (like a "spinning-wheel").

This is very handy when you wish to display selection lists on as needed, and can be used as an alternative to hierarchically organised lists, for a flatter UI structure and faster navigation experience.

Find out more in the [CustomPicker guide](http://www.mosync.com/docs/sdk/cpp/guides/nativeui/using-custom-picker/index.html). It is easy to get started with the sample code included in the guide.

## Windows Phone Native UI performance improvements (New!)

The inner workings of the MoSync NativeUI API on Windows Phone has been redesigned to boost performance. By using a new asynchronous architecture, performance has almost doubled in average.

Benchmarking has shown that layout intensive applications benefit most from the new architecture, for example apps that feature long lists and/or complex layouts. Performance increase in our tests has ranged from x1.6 to x2 and above.

## Toast notifications on Android

Supported platforms: Android.

In MoSync SDK 3.3 you can use Toast notifications on Android.

The syscall that has been added is [maToast TODO: Add link URL](), which is very easy to use.

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

You can also see an example of using datagrams for UDP multicast in the ReloadClient in class BroadcastHander (see files [BroadcastHandler.h](https://github.com/MoSync/Reload/blob/OneOne/ReloadClient/BroadcastHandler.h) and [BroadcastHandler.cpp](https://github.com/MoSync/Reload/blob/OneOne/ReloadClient/BroadcastHandler.cpp)).

## Mobile-friendly Developer website (New!)

MoSync Developers have a new website, that contains documentation and other developer resources. The site has been created to be mobile-friendly, for easy navigation on mobile devices. It has been created using the jQuery Mobile UI library, and features a responsive menu design. This is part of our ongoing ambition to test and use mobile technologies in all aspects of our work.

The Developer website is found at: [www.mosync.com/docs](http://www.mosync.com/docs)

## Screen orientation API (Updated)

Supported platforms: Android (New!), iOS, Windows Phone.

The MoSync Orientation API has been updated. Syscall maScreenSetOrientation is deprecated. Use syscalls maScreenSetSupportedOrientations instead. See examples below.

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

To see the Screen orientation API in action, run the example app [ScreenOrientation](http://www.mosync.com/docs/sdk/cpp/examples/screenorientation/index.html), which comes with the MoSync SDK download.

## Database SQL API (Updated)

Platforms supported: Android, iOS, MoRE.

The MoSync C Database API has been updated to support the full API on both iOS and Android. The Database API is also supported on the MoSync MoRE emulator.

To see the Databse API in action, run the [DatabaseTest example app](http://www.mosync.com/docs/sdk/cpp/examples/databasetest/index.html), which is included in the MoSync SDK download. Learn more about the details in the [Database API guide](http://www.mosync.com/docs/sdk/cpp/guides/storage/sql-database-api/index.html).

## In-app Purchase API on Android (Updated)

The MoSync C/C++ Purchase API has been updated on Android to use [In-app Billing Version 3](http://developer.android.com/google/play/billing/billing_overview.html). This means that your apps now support the latest version of the Google Play In-app Billing API.

To find out more about the MoSync SDK Purchase API, check out the [In-app Purchase guide](http://www.mosync.com/docs/sdk/cpp/guides/purchases/managing-app-purchases/index.html).

## Fixed Bugs

TODO: Link to Jira filter.
