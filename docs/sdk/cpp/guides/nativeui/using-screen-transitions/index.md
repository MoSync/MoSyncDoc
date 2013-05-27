<!-- <mosyncheadertags>
<meta name="description" content="This guide shows how to use the MoSync Camera API." /> <meta name="keywords" content="mobile development,sdk,ide,apps,mobile,apps,android,ios,iphone,ipad,camera,
mobile,c,c++,open source,porting,dev,application,ide,cross
platform,programming,mosync,screen transitions" />
<title>Screen Transitions</title>
</mosyncheadertags> -->

# Screen Transitions

**Note: This page is only valid for the upcoming MoSync SDK 3.3 release.**

Now it is easy to add animated transitions for all the screens pushed and popped into a [StackScreen](http://www.mosync.com/files/imports/doxygen/latest/html/class_native_u_i_1_1_stack_screen.html) or for any [Screen](http://www.mosync.com/files/imports/doxygen/latest/html/class_native_u_i_1_1_screen.html) shown separately.

In this way your application will be better integrated in the environment in which it is deployed and the user experience will be enhanced.

***

## Available transitions

You can find the animated transition available in MoSync [here](http://www.mosync.com/files/imports/doxygen/latest/html/group___screen_transition_types.html#ga2d86f91cd1a9b9aea0e5f55b5b9ce0cb). Please read carefully their platform availability.\\
All of these transition types are compliant with the user experience of the platform they are available on since the native animations are used.

For example:

**MAW_TRANSITION_TYPE_SLIDE_LEFT** is a transition that will show the next screen by sliding it from right to left. It is available on Android and Windows Phone.

or

**MAW_TRANSITION_TYPE_CURL_UP** is a transition that curls a view up from the bottom and it is available only on iOS (4.0 and later).

***

## StackScreen’s push/pop transitions

The push and pop animated transitions can be set using the [setPushTransition](http://www.mosync.com/files/imports/doxygen/latest/html/group___native_u_i_lib.html#ga7c6178ce62cf7a2a5c0a8e042539ffd0) and [setPopTransition](http://www.mosync.com/files/imports/doxygen/latest/html/group___native_u_i_lib.html#ga8c9835e86c42b7b38f6e25fd868d1e5c) methods. When using these methods you need to specify the type of the screen transition and its duration in milliseconds.

    StackScreen* myStackScreen = new StackScreen();
    myStackScreen->setPushTransition(MAW_TRANSITION_TYPE_SLIDE_LEFT, 300);
    myStackScreen->setPopTransition(MAW_TRANSITION_TYPE_SLIDE_RIGHT, 300);

Also if the pop/push transitions of a [StackScreen](http://www.mosync.com/files/imports/doxygen/latest/html/class_native_u_i_1_1_stack_screen.html) can be set by using the [setProperty](http://www.mosync.com/files/imports/doxygen/latest/html/group___native_u_i_lib.html#ga50ea5aa06657934b537e8766e52b966a) method or directly using the [maWidgetSetProperty](http://www.mosync.com/files/imports/doxygen/latest/html/group___widget_a_p_i_functions.html#gae72c5d1bbd14bf4faeeac9dc27e13709) syscall with the following properties:

* **MAW_STACK_SCREEN_PUSH_TRANSITION_TYPE**\\
This represents the type of the animated transition used when pushing a screen from the current screen stack.\\More information related to this property can be found
[here](http://www.mosync.com/files/imports/doxygen/latest/html/group___widget_stack_screen_properties.html#gae958087f46ea25242043598d67fa844e)
and also the transition types types available for each platform can be found [here](http://www.mosync.com/files/imports/doxygen/latest/html/group___screen_transition_types.html#ga2d86f91cd1a9b9aea0e5f55b5b9ce0cb).

* **MAW_STACK_SCREEN_POP_TRANSITION_TYPE**\\
Type of the animated transition used when popping a screen from the current screen stack.\\More information related to this property can be found
[here](http://www.mosync.com/files/imports/doxygen/latest/html/group___widget_stack_screen_properties.html#gac85a50bd91bf05cd08950668a1460cd2)
and also the transition types types available for each platform can be found [here](http://www.mosync.com/files/imports/doxygen/latest/html/group___screen_transition_types.html#ga2d86f91cd1a9b9aea0e5f55b5b9ce0cb).

* **MAW_STACK_SCREEN_PUSH_TRANSITION_DURATION**\\
Duration of the animated transition used when pushing a screen from the current screen stack.\\More information related to this property can be found
[here](http://www.mosync.com/files/imports/doxygen/latest/html/group___widget_stack_screen_properties.html#ga4ee4e18aedf136c7ea63a84811b0759f)
and also the transition types types available for each platform can be found [here](http://www.mosync.com/files/imports/doxygen/latest/html/group___screen_transition_types.html#ga2d86f91cd1a9b9aea0e5f55b5b9ce0cb).

* **MAW_STACK_SCREEN_POP_TRANSITION_DURATION**\\
Duration of the animated transition used when popping a screen from the current screen stack.\\More information related to this property can be found
[here](http://www.mosync.com/files/imports/doxygen/latest/html/group___widget_stack_screen_properties.html#ga80f4a56d680dd9f224ddb6b7ab495fa1)
and also the transition types types available for each platform can be found [here](http://www.mosync.com/files/imports/doxygen/latest/html/group___screen_transition_types.html#ga2d86f91cd1a9b9aea0e5f55b5b9ce0cb).

Example:

    StackScreen* myStackScreen = new StackScreen();
    char valueBuffer[32];

    sprintf(valueBuffer, "%d", MAW_TRANSITION_TYPE_SLIDE_LEFT);
    myStackScreen->setProperty(MAW_STACK_SCREEN_PUSH_TRANSITION_TYPE, valueBuffer);

    sprintf(valueBuffer, "%d", MAW_TRANSITION_TYPE_SLIDE_RIGHT);
    myStackScreen->setProperty(MAW_STACK_SCREEN_POP_TRANSITION_TYPE, valueBuffer );

    sprintf(valueBuffer, "%d", 300);
    myStackScreen->setProperty(MAW_STACK_SCREEN_PUSH_TRANSITION_DURATION, valueBuffer);
    myStackScreen->setProperty(MAW_STACK_SCREEN_POP_TRANSITION_DURATION, valueBuffer);

***

## Screen's transitions

Any screen can be shown with an animated transition just by using [showWithTransition](http://www.mosync.com/files/imports/doxygen/latest/html/group___native_u_i_lib.html#ga67f351687d0e388255afe6c4d0f138f1) method of a [Screen](http://www.mosync.com/files/imports/doxygen/latest/html/class_native_u_i_1_1_screen.html) object. Similar to the methods shown above for the StackScreen, this method needs a screen transition type and a duration of the transition in milliseconds.

Here is an example:

    Screen simpleScreen = new Screen();
    // Show simpleScreen
    simpleScreen->showWithTransition(MAW_TRANSITION_TYPE_CURL_UP, 300);

Also, a screen can be shown by using the [maWidgetScreenShowWithTransition](http://www.mosync.com/files/imports/doxygen/latest/html/group___widget_a_p_i_functions.html#gadd2a8d9c1e37a4ea4aa1f4480c749902) syscall.

Here is an example of how to use this syscall:

    maWidgetScreenShowWithTransition(aScreenHandle, MAW_TRANSITION_TYPE_CURL_UP, 300);

It is important that you consult the [Transition constants](http://www.mosync.com/files/imports/doxygen/latest/html/group___screen_transition_types.html#ga2d86f91cd1a9b9aea0e5f55b5b9ce0cb) in order to check the availability of the transitions types on each platform.

***

This is a video that shows some of the screen transitions available in MoSync:

<div>
<iframe width="640" height="360" src="http://www.youtube.com/embed/lygGHeQtNI8?feature=player_detailpage" frameborder="0" allowfullscreen></iframe>
</div>

Another example where screen transitions are used is the [MoCamera](TEMPLATE_DOC_PATH/sdk/cpp/examples/MoCamera/index.html) example app.

***