# How to use documentation scripts

## Introduction
This document explains how to use the scripts in the documentation system.

Scripts are written in Ruby and are located in the /scripts directory.

The main purpose of the sripts is to build the documentation website files.

Note that the scripts build the complete documentation website, that includes documentation for both MoSync SDK and MoSync Reload.

Also note that the scripts are included only in the MoSyncDoc repository. The ReloadDoc repository contains only documentation files.

## Running scripts
To run scripts manually, cd to the scripts directory and run the scripts from there (the way paths are set up assume this).

## Installing kramdown
kramdown is a Markdown to HTML converter for Ruby. This module must be installed before building the website. Use this one-time command on your machine to install it:

    gem install kramdown
    
For additional details, see the [kramdown home page](http://kramdown.rubyforge.org/installation.html).

## Building the documentation website
To build the website, make sure you have checked out MoSyncDoc and ReloadDoc repositories in a common parent folder. For example like this:

    MyGitRepos
        ReloadDoc
        MoSyncDoc

The website build script will use data from ReloadDoc when building the website. Specifically, the script structure.rb contains information about both MoSync SDK and MoSync Reload documentation pages.

To build the website, first to to the MoSyncDoc/scripts directory:

    cd MoSyncDoc
    cd scripts
    
Then run the build script:

    ruby build.rb buildall
    
This will output website files to MoSyncDoc/website that you can open in a web browser to preview what the documentation looks like.

To build only documentation for SDK or Reload use:

    ruby build.rb buildsdk
    ruby build.rb buildreload
    
Note that if you build all documentation, it is important that both MoSyncDoc and ReloadDoc repos are up-to-date, because structure.rb contains references also to Reload pages, and if they do not exist, you will get a build error (this is one reason for that it can be useful to build only the SDK docs).

## Updating structure.rb
The script structure.rb contains a list of all documentation pages, stored as a Ruby array, referenced by the global variable $pages.

When adding (or removing) a documentation page, this array needs to be updated.

For historical reasons the array with page data contains the page paths of the original Drupal website.

The format of the $pages array is:

    [page-entry-1,
     page-entry-1,
     page-entry-n,]

Where each entry is an array of the form:

    [oldfile,newfile,[tag-1,tag-2,tag-n]],
    
For example:

    ["content/3dlines","sdk/cpp/examples/3dlines",[SDK,CPP,EXAMPLE,GRAPHICS]],

When putting in a new documentation page, just put an empty string as the first array element. Here is an example:

    ["","sdk/cpp/guides/camera/native-camera-api",[SDK,CPP,GUIDE,CAMERA]],

Note that the path of the documentation file does NOT include "index.html", and that the path does NOT contain slashes at the beginning or end.

The list of tags should always include one of SKD or RELOAD, and the document type (GUIDE, EXAMPLE, REFERENCE, RELEASE_NOTE), and at least one topic tag.

It is good to keep the number of topic tags down (preferably use just one), because documentation structure becomes cleaner this way. 

