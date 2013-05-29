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

Supported platforms: Android and iOS.

## Overview

With the OpenGL-based MoGraph 3D Graph Library, you can create 3D diagrams and charts, visualise data, animate diagrams, display real-time data (like weather data, traffic data, business data and market information), and create artistic applications and animations.

Check out the [MoGraph example apps](TEMPLATE_DOC_PATH/sdk/cpp/examples/mograph/index.html) to get a feel for what is possible with this library. Commented source code helps you to get started.

Below, you can find a simplifed basic example you can use as a starting point. The code snippets used in the following examples are from this sample program. The full source listing is found at the end of this tutorial. There you will also find instructions for how to build the example.

We will use the words "graph" and "diagram" as to refer to what is draw on the screen, they mean essentially the same thing in the context of this tutorial. Names of classes consistenly use "Graph" however.

## Classes and initialization

The example code uses a Moblet class that inherits from GLMoblet. This is the basis for the application, since the MoGraph library uses OpenGL to render diagrams:

    class MyGLMoblet: public GLMoblet
    {
        ...
    };
    
The main graph class is MoGraph::Graph. Create an instance of this class like this:

    mGraph = new MoGraph::Graph();
    
Use class MoGraph::GraphDesc to specify the properties of the graph. Here is a basic example:

    MoGraph::GraphDesc desc;
    desc.scrWidth = EXTENT_X(maGetScrSize());
    desc.scrHeight = EXTENT_Y(maGetScrSize());
    desc.gridX = mGridWidth;
    desc.gridZ = mGridDepth;
    desc.bUseGridValue = false;
    desc.font = mFont;

Next, initialize the graph:

    if (!mGraph->init(&desc))
    {
        maPanic(1, "Failed to initialize Graph");
    }

As seen in the full example listing below, there are several additional settings that can be made. When the set up opf the Graph is complete, you can draw the graph.

# Drawing the graph

Draw the graph in the draw() method, which is called repeatedly by GLMoblet on each frame to render the 3D scene.

What is important to understand, is that diagram data is stored as arrays. There are two arrays, one for height values (an array of floats) and one for colors (an array of glm::vec4 values).

The size of these array is the grid width times the grid depth. Think of the grid as the bottom layer of the diagram. Each grid cell is rendered as a bar in the diagram. For example, a 3x3 grid, has height and color arrays with 9 elements each.

Of every update, pass array values to the graph object, and tell the graph to draw the diagram:

    mGraph->setValues(mBars, mGridSize);
    mGraph->setColors(mColors, mGridSize);
    
    mGraph->draw();

A dynamic/animated diagram is created by updating the height values and/or color values on each frame.

## Full code example

Here follows the full source for the above code snippets. 

It should be noted that the Mograph library uses Newlib, a stardard library that requires special settings for the MoSync project. The quickest way to get started is to copy one of the MoGraph example apps, as this will also copy the required settings. This way, you will also get the required resource files for fonts.

Here is how to build the code example in the MoSync IDE:

* Import the example project "MoGraphWave" into the workspace
* Copy the project by right-clicking it in the Project Explorer and select "Copy"
* Then past it using "Paste", you are asked to rename the project, call it e.g. "MoGraphBasic"
* Open file main.cpp and delete the code in the file
* Copy the code below and paste it into main.cpp
* Build and run the project

Full source code:

    /*
     * Basic MoGraph code example. Displays a 3x3 grid,
     * colored as a Swedish flag.
     */
    #include <mavsprintf.h>
    #include <MAUtil/GLMoblet.h>
    #include <GLES2/gl2.h>
    #include <glm/glm.hpp>
    #include <stdlib.h>
    #include <MoGraph.h>
    #include "MAHeaders.h"

    /**
     * The Moblet class needs to extend GLMoblet.
     */
    class MyGLMoblet: public MAUtil::GLMoblet
    {
    private:

        // ===== Instance variables =====

        // Graph object. This is the main
        // Object in the program.
        MoGraph::IGraph* mGraph;

        // Width of the graph grid.
        int mGridWidth;

        // Depth of the graph grid.
        int mGridDepth;

        // Total number of grid bars/cells.
        int mGridSize;

        // Height values of bars in the graph.
        float* mBars;

        // Color table for graph elements.
        glm::vec4* mColors;

        // Font object (we need to set up a font,
        // even though we do not display any text).
        IFont* mFont;

    public:

        // ===== Constructor/Destructor =====

        MyGLMoblet() : GLMoblet(MAUtil::GLMoblet::GL2)
        {
        }

        virtual ~MyGLMoblet()
        {
            delete mGraph;
            delete mFont;
            delete [] mBars;
            delete [] mColors;
        }

        // ===== Called by the GLMoblet to init the app =====

        void init()
        {
            // Tell GLMoblet our desired frame rate.
            setPreferredFramesPerSecond(50);

            // Set size of graph grid.
            mGridWidth = 3;
            mGridDepth = 3;
            mGridSize = mGridWidth * mGridDepth;

            // Create array that will hold height values.
            mBars = new float[mGridSize];

            // Create array that will hold color values.
            mColors = new glm::vec4[mGridSize];

            // Create Graph object.
            mGraph = new MoGraph::Graph();

            // Set up standard font.
            std::vector<MAHandle> fontTexArray;
            fontTexArray.push_back(R_BOX_TEXTURE);
            mFont = new BMFont();
            mFont->Init(R_BOX_FNT, fontTexArray);

            // Set up graph properties.
            MoGraph::GraphDesc desc;
            desc.scrWidth = EXTENT_X(maGetScrSize());
            desc.scrHeight = EXTENT_Y(maGetScrSize());
            desc.gridX = mGridWidth;
            desc.gridZ = mGridDepth;
            desc.bUseGridValue = false; // Do not display bar values.
            desc.font = mFont;

            // Initialize the graph.
            if (!mGraph->init(&desc))
            {
                maPanic(1, "Failed to initialize Graph");
            }

            // Set graph background color to white.
            glm::vec4 bkcolor(1.0f, 1.0f, 1.0f, 1.0f);
            mGraph->setBGColor(bkcolor);

            // Clear any predefined text labels (this example
            // do not display any texts).
            (mGraph->getScene().getTextMgr().getTextArray()).clear();
            (mGraph->getScene().getAxisMgr().getLineArray()).clear();
        }

        // ===== Called by the GLMoblet to draw the screen =====

        void draw()
        {
            // In this example we could have set the
            // graph data in init(), since it never
            // changes. But if you wish to add some
            // animation or dynamic update of values,
            // this is the place to update bar heights
            // and/or color values.

            // Set grid height values.
            float height1 = 0.5f;
            float height2 = 1.0f;
            mBars[0] = height1;
            mBars[1] = height2;
            mBars[2] = height1;
            mBars[3] = height2;
            mBars[4] = height2;
            mBars[5] = height2;
            mBars[6] = height1;
            mBars[7] = height2;
            mBars[8] = height1;

            // Set grid color values.
            glm::vec4 color1 = glm::vec4(0.0f,0.0f,1.0f,1.0f);
            glm::vec4 color2 = glm::vec4(1.0f,1.0f,0.0f,1.0f);
            mColors[0] = color1;
            mColors[1] = color2;
            mColors[2] = color1;
            mColors[3] = color2;
            mColors[4] = color2;
            mColors[5] = color2;
            mColors[6] = color1;
            mColors[7] = color2;
            mColors[8] = color1;

            // Update graph with data.
            mGraph->setValues(mBars, mGridSize);
            mGraph->setColors(mColors, mGridSize);

            // Draw the graph.
            mGraph->draw();
        }

        // ===== Touch events are forwarded to the Graph object =====

        void multitouchPressEvent(MAPoint2d p, int touchId)
        {
            mGraph->getTouch().multitouchPressEvent(p, touchId);
        }

        void multitouchMoveEvent(MAPoint2d p, int touchId)
        {
            mGraph->getTouch().multitouchMoveEvent(p, touchId);
        }

        void multitouchReleaseEvent(MAPoint2d p, int touchId)
        {
            mGraph->getTouch().multitouchReleaseEvent(p, touchId);
        }

        // ===== Exit application on back key (Android) =====

        void keyPressEvent(int keyCode, int nativeCode)
        {
            if (MAK_BACK == keyCode)
            {
                maExit(0);
            }
        }
    };

    // ===== Main entry point of the program =====

    extern "C" int MAMain()
    {
        MAUtil::Moblet::run(new MyGLMoblet());
        return 0;
    }
