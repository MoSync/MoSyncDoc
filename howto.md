# How to use the documentation system

## Introduction
This document explains how to use the documentation system.

It should be noted that the documenation in this repository is NOT in the final format displayed on the web site. A build script is used to process the pages in this reposiotory, to produce HTML pages for the web site.

The purpose with this repository is to have the documentation under version control.

## File format

You can use HTML or Markdown. At present Markdown files need to be manually converted to HTML. A tool for this is [Pandoc](http://johnmacfarlane.net/pandoc/).

Each documentation page goes into its own subdirectory.

Markdown pages must be named "index.md"

HTML pages  must be named "index.html"

Images should go into the "images" subdirectory. 

See example below.

## Folder structure

The documentation uses the following folder structure:

    docs
      sdk
        cpp
          examples
          guides
          tutorials
        js
          examples
          guides
          tutorials
        release-notes
        tools
          guides
          references

Under each directory are subdirectories for different topics.

To give an example, these are the files for an actual documentation page:

    docs
      sdk
        cpp
          ads
            using-advertising-library-and-api
              images
                advertising-android-annotated.png
              index.html

It should be noted that the actual classification of document categories is specified in the file scripts/structure.rb. It is however essential to maintain the directory structure and place documents where they logically belong, to make it easy to update and manage documentation files.

## Guides vs. Tutorials

The difference is not clear in the current documentation, but here is a characterisation. A guide and is shorter than a tutorial, and covers a specific topic. A tutorial is longer and can have a broader scope. A tutorial can also be more of a step-by-step description compared to a guide.

## Images

Put images into the "images" subdirectory of the directory for the documentation page, and link using relative URLs.

Image formats/extensions used are ".png" or ".jpg".

Here is an example of an image tag:

    <img src="images/advertising-android-annotated.png" />

## Links

On the generated website, relative URLs are used to the greatest possible extent. To make this work, while at the same time having a system that allows for pages to be moved and links to be updated, a special syntax is used. 

URLs used as links should begin with the string "TEMPLATE\_DOC\_PATH" and then the full path to the page under the docs directory should follow. Here is an example:

    <a href="TEMPLATE_DOC_PATH/cpp/examples/nativeuidemo/index.html>NativeUIDemo</a>

## Flavour of Markdown

If you use Markdown, it is good to know that GitHub uses its own flavour. To play well with both GitHub Markdown and Standard Markdown, the following should be used:

* Do not use new lines in paragraphs. Write a paragraph as a single link (soft wrapped in the editor).

* Do not use underscore for bold/italics, used asterisks instead. \*Italics\* and \*\*Bold\*\*. We will escape underscores so that they can be used do document CONSTANTS\_WITH\_UNDERSCORES.

Markdown guide: http://daringfireball.net/projects/markdown/

## Scripts

The scripts directory contains scripts for building the documentation web site, and for managing analysing the documentation.

This directory also contains a central script called "structure.rb" with contains a list of all pages in the documentation. When adding a new page, it needs to be added to this script. Further details about how to do this will follow. In the mean time, ask the documentation administrator to do this.

## Attitude

Think of documentation as a catalouge of goodies to pick from. Or a bowl of candy with colourful and inviting items to try out. Or use your own picture to help create documentation that makes the reader to eagerly want to try out things and discover more. And writing plain on-the-spot documentation is always useful and appreciated ;-)
