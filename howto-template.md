<!-- <mosyncheadertags>
<meta name="description" content="This is a template page for MoSync documentation." />
<meta name="keywords" content="mobile,app,apps,application,mobile app,mobile apps,mobile application,mobile applications,mobile dev,mobile development,sdk,ide,android,ios,iphone,ipad,
windows phone,c,c++,open source,porting,cross
platform,programming,mosync" />
<title>Example MoSync Documentation Page</title>
</mosyncheadertags> -->

# Example MoSync Documentation Page

**Note: View the source of this file to see how the Markdown markup is used.**

## kramdown

The documentation system uses [kramdown](http://kramdown.rubyforge.org/) to convert Markdown to HTML.

## Page structure

Comment with meta tags goes at the top (see example below.)

Use one and only one h1 header for the title of the page.

Use h2 headers for subsections.

## File encoding

Save files as UTF-8.

## Line breaks

Do not line-break paragraphs, make the editor soft-wrap your lines. Like in this paragraph that is written as one long line that wraps in the editor.

If you want to make a line break, you can end the line with two backslash characters (\\\\). This is [kramdown syntax](http://kramdown.rubyforge.org/syntax.html#paragraphs). This can for example be useful to insert breaks in list items, like in this example:

* Item 1, Line 1\\
Item 1, Line 2\\
Item 1, Line 3
* Item 2
* Item 3

## Links

To link within the documentation, use the template tag TEMPLATE_DOC_PATH to represent the root path. Example of link:

    [Reload documentation home](TEMPLATE_DOC_PATH/reload/index.html)

## Anchor links

Anchor links link within a documentation page, as in this example: [Good to know](#mosync-anchor-good-to-know)

To link within the documentation, some conventions need to be followed.

The target anchor tag must have an id attribute that begins with "mosync-anchor". This is used to differentiate this type of anchor from other anchor tags used in the documention system (e.g. ids used by jQuery Mobile).

Example of target anchor (note the use of HTML markup). This tag shoud be put before the heading it targets. Also make sure to have a blank line before and after the tag. Inspect the source of this file to see an example:

    <a id="mosync-anchor-good-to-know"></a>

Example of link:
    
    [Good to know](#mosync-anchor-good-to-know)

<a id="mosync-anchor-good-to-know"></a>
    
## Good to know

You can always insert HTML code into a Markdown document.
