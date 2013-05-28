<!-- <mosyncheadertags>
<meta name="description" content="This guide shows how to use the MoGraph API." />
<meta name="keywords" content="mobile development,sdk,ide,apps,mobile,apps,android,ios,iphone,ipad,opengl,
graph,diagram,mobile,c,c++,open source,porting,dev,application,ide,cross
platform,programming,mosync,native ui,nativeui" />
<title>MoGraph C++ Library Guide</title>
</mosyncheadertags> -->

<style>
.screenshot
{
  width: 240px;
  height: 400px;
}
</style>

# MoGraph C++ Library Guide

**Note: This page is only valid for the upcoming MoSync SDK 3.3 release.**

Supported platforms: Android and iOS.

## Overview

With the OpenGL-based MoGraph 3D Graph Library, you can create beautiful 3D diagrams and charts, visualise data, animate diagrams, display real-time data (like weather data, traffic data, business data and market information), and create artistic applications and animations, and make various kinds of games.

Check out the [MoGraph example apps](TEMPLATE_DOC_PATH/sdk/cpp/examples/mograph/index.html) to get a feel for what is possible with this library. Commented source code helps you to get started.

## Classes

The examples use a Moblet class that inherits from GLMoblet. This is the basis for the application, since the MoGraph library uses OpenGL to render diagrams:

    class MyGLMoblet: public GLMoblet
    {
        ...
    };
    
The main graph class is MoGraph::Graph. Create an instance of this class like this:

    mGraph = new MoGraph::Graph();
    
Use class MoGraph::GraphDesc to specify the properties of the graph. Here is a simple example that creates a 3x3 diagram:

    MoGraph::GraphDesc desc;
    desc.scrWidth = EXTENT_X(maGetScrSize());
    desc.scrHeight = EXTENT_Y(maGetScrSize());
    desc.gridX = 3; // amount of bars in X axis
    desc.gridZ = 3; // amount of bars in Z axis (depth)
    desc.gridYLines = 10; // amount of horisontal lines to be displayed in graph
    desc.gridStepYLines = 0.5f; // the step Y position between the lines

Next, initialize the graph:

    if (!mGraph->init(&desc))
        maPanic(1,"Failed to initiate Graph");

Set the background color:

    glm::vec4 bkcolor(0.0f, 0.0f, 0.0f, 1.0f);
    mGraph->setBGColor(bkcolor);

Draw the diagram in the draw() method, this is called by GLMoblet to render the 3D scene:

    void draw()
    {
        // Arrays for colors and bar heights. The size of
        // the arrays is the width * depth of the graph.
        int size = 3 * 3;
        float bars[size];
        glm::vec4 colors[size];
    
        // Build the data arrays for colors and for tables.
        for (int i = 0; i < size; ++i)
        {
            bars[i] = 2.0f;
            colors[i] = glm::vec4(1.0f,0.0f,0.0f,1.0f);
        }

        // Set the bar data and colors of the graph.
        mGraph->setValues(bars, size);
        mGraph->setColors(colors, size);

        // Draw the graph.
        mGraph->draw();
    }
    
Additionaly, you can use text labels, specify gridlines etc of the graph.

Here is the full source code of the above example. You can build this program in the MoSync IDE by creating a new project based on the "C++ OpenGL" template, and then copy the code below and paste into file main.cpp (replacing its content).

    // Full code example goes here.
