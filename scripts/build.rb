# Program that builds the documentation website.
# Also handles the import of documentation from Drupal.
# Author: Mikael Kindborg

# This is a way to copy files.
# FileUtils.cp_r(Dir[sourceDir + "*"], destDir)

require "fileutils"
require "pathname"
require "open-uri"
require "kramdown"

# The structure file contains all pages and category info.
load 'structure.rb' 

######################################################
#                     PATH NAMES                     #
######################################################

# Directory of Drupal export.
# Not in git.
def pathExports
  "../mosync-doc-exports-130429/"
end

# Templates used for building the web site.
def pathTemplates
  "../templates/"
end

def pathTemplateJs
  pathTemplates + "js/"
end

def pathPageTemplate
  pathTemplates + "page-template.html"
end

def pathPageDocHome
  pathTemplates + "page-doc-home.html"
end

def pathPageDocMenu
  pathTemplates + "page-doc-menu.html"
end

def pathPageSearch
  pathTemplates + "page-search.html"
end

def pathPageSdkHome
  pathTemplates + "page-sdk-home.html"
end

def pathPageSdkMenu
  pathTemplates + "page-sdk-menu.html"
end

def pathPageReloadHome
  pathTemplates + "page-reload-home.html"
end

def pathPageReloadMenu
  pathTemplates + "page-reload-menu.html"
end

# Documentation source directories.
def pathDocsSdk
  "../docs/sdk/"
end

def pathDocsReload
  "../../ReloadDoc/docs/reload/"
end

# Docs working directory, used during build.
# Contains doc for both SDK and Reload.
# Not in git.
def pathDocs
  "../docs-tmp/"
end

# Directories in documentation web site. Not in git.
def pathWebSite
  "../website/"
end

def pathWebSiteJs
  pathWebSite + "js/"
end

def pathWebSiteSdk
  pathWebSite + "sdk/"
end

def pathWebSiteReload
  pathWebSite + "reload/"
end

######################################################
#                   BUILD WEB SITE                   #
######################################################

# Menu items that can be highlighted
MENU_START_HOME="TEMPLATE_THEME_MENU_START_HOME"
MENU_START_SDK="TEMPLATE_THEME_MENU_START_SDK"
MENU_START_RELOAD="TEMPLATE_THEME_MENU_START_RELOAD"
MENU_START_SEARCH="TEMPLATE_THEME_MENU_START_SEARCH"
MENU_CPP_GUIDES="TEMPLATE_THEME_MENU_CPP_GUIDES"
MENU_CPP_TUTORIALS="TEMPLATE_THEME_MENU_CPP_TUTORIALS"
MENU_CPP_EXAMPLES="TEMPLATE_THEME_MENU_CPP_EXAMPLES"
MENU_JS_GUIDES="TEMPLATE_THEME_MENU_JS_GUIDES"
MENU_JS_TUTORIALS="TEMPLATE_THEME_MENU_JS_TUTORIALS"
MENU_JS_EXAMPLES="TEMPLATE_THEME_MENU_JS_EXAMPLES"
MENU_SDK_GUIDES="TEMPLATE_THEME_MENU_SDK_GUIDES"
MENU_SDK_REFERENCES="TEMPLATE_THEME_MENU_SDK_REFERENCES"
MENU_SDK_RELEASE_NOTES="TEMPLATE_THEME_MENU_SDK_RELEASE_NOTES"
MENU_RELOAD_GUIDES="TEMPLATE_THEME_MENU_RELOAD_GUIDES"
MENU_RELOAD_RELEASE_NOTES="TEMPLATE_THEME_MENU_RELOAD_RELEASE_NOTES"

MENU_ALL = [
MENU_START_HOME,
MENU_START_SDK,
MENU_START_RELOAD,
MENU_START_SEARCH,
MENU_CPP_GUIDES,
MENU_CPP_TUTORIALS,
MENU_CPP_EXAMPLES,
MENU_JS_GUIDES,
MENU_JS_TUTORIALS,
MENU_JS_EXAMPLES,
MENU_SDK_GUIDES,
MENU_SDK_REFERENCES,
MENU_SDK_RELEASE_NOTES,
MENU_RELOAD_GUIDES,
MENU_RELOAD_RELEASE_NOTES,
]

#----------------------------------------------------#
#             Build Website Entry Point              #
#----------------------------------------------------#

def webSiteBuild
  webSiteCopyDocsForBuild
  webSiteConvertMarkdownToHtml
  webSiteClean
  webSiteCopyLibs
  webSiteBuildDocHomePage
  webSiteBuildSearchPage
  webSiteBuildSdkHomePage
  webSiteBuildSdkDocPages
  webSiteBuildSdkIndexPages
  webSiteBuildReloadHomePage
  webSiteBuildReloadDocPages
  webSiteBuildReloadIndexPages
end

#----------------------------------------------------#
#               Copying Website Files                #
#----------------------------------------------------#

# Copy documentation files to a temporary documentation
# directory, containig both SDK and Reload doc files.
def webSiteCopyDocsForBuild
  puts "Cleaning docs temp directory"
  # Clean target directory.
  fileCleanPath(Pathname.new(pathDocs()))
  
  puts "Copying SDK doc files"
  # Copy SDK files.
  FileUtils.cp_r(Dir[pathDocsSdk()], pathDocs())
  
  puts "Copying Reload doc files"
  # Copy Reload files.
  FileUtils.cp_r(Dir[pathDocsReload()], pathDocs())
end

def webSiteClean
  puts "Cleaning website directory"
  # Clean and create target directories.
  fileCleanPath(Pathname.new(pathWebSite()))
  fileCleanPath(Pathname.new(pathWebSiteJs()))
end

def webSiteCopyLibs
  # Copy JavaScript libs.
  FileUtils.cp_r(Dir[pathTemplateJs()], pathWebSite())
  
  # Copy images.
  #FileUtils.cp(
  #  Pathname.new("../templates/mosync_logo.jpg"),
  #  Pathname.new("../docs/pages/mosync_logo.jpg"))
end

#----------------------------------------------------#
#           Build Documentation Home Page            #
#----------------------------------------------------#

def webSiteBuildDocHomePage
  title = "MoSync Documentation"
  webSiteBuildPage(
    :outputFile => pathWebSite() + "index.html",
    :pageFile => pathPageDocHome(),
    :menuFile => pathPageDocMenu(),
    :templateFile => pathPageTemplate(),
    :pageTitle => title,
    :selectedMenuItem => MENU_START_HOME
    )
end

def webSiteBuildSearchPage
  title = "Documentation Search"
  webSiteBuildPage(
    :outputFile => pathWebSite() + "search.html",
    :pageFile => pathPageSearch(),
    :menuFile => pathPageDocMenu(),
    :templateFile => pathPageTemplate(),
    :pageTitle => title,
    :selectedMenuItem => MENU_START_SEARCH
    )
end

#----------------------------------------------------#
#               Build MoSync SDK Pages               #
#----------------------------------------------------#

# Build the SDK home page.
def webSiteBuildSdkHomePage
  title = "MoSync SDK"
  webSiteBuildPage(
    :outputFile => pathWebSiteSdk() + "index.html",
    :pageFile => pathPageSdkHome(),
    :menuFile => pathPageSdkMenu(),
    :templateFile => pathPageTemplate(),
    :pageTitle => title,
    :selectedMenuItem => MENU_START_SDK
    )
end

# Build all SDK documentation pages.
def webSiteBuildSdkDocPages
  webSiteBuildDocPages(
    docSdkPages(), 
    pathPageSdkMenu())
end

# Build SDK index pages for all categories and page types.
def webSiteBuildSdkIndexPages
  title = "C/C++ Coding Guides"
  webSiteBuildSdkIndexPage([SDK,CPP,GUIDE], "sdk/cpp/guides/", title, MENU_CPP_GUIDES)
  
  title = "C/C++ Tutorials"
  webSiteBuildSdkIndexPage([SDK,CPP,TUTORIAL], "sdk/cpp/tutorials/", title, MENU_CPP_TUTORIALS)
  
  title = "C/C++ Examples"
  webSiteBuildSdkIndexPage([SDK,CPP,EXAMPLE], "sdk/cpp/examples/", title, MENU_CPP_EXAMPLES)
  
  title = "JavaScript Coding Guides"
  webSiteBuildSdkIndexPage([SDK,JS,GUIDE], "sdk/js/guides/", title, MENU_JS_GUIDES)
  
  title = "JavaScript Tutorials"
  webSiteBuildSdkIndexPage([SDK,JS,TUTORIAL], "sdk/js/tutorials/", title, MENU_JS_TUTORIALS)
  
  title = "JavaScript Examples"
  webSiteBuildSdkIndexPage([SDK,JS,EXAMPLE], "sdk/js/examples/", title, MENU_JS_EXAMPLES)
  
  #title = "All Examples"
  #webSiteBuildSdkIndexPage([CPP,JS,EXAMPLE], "sdk/overviews/examples/", title)
  
  title = "SDK Tools Guides"
  webSiteBuildSdkIndexPage([SDK,TOOLS,GUIDE], "sdk/tools/guides/", title, MENU_SDK_GUIDES)
  
  title = "SDK Tools References"
  webSiteBuildSdkIndexPage([SDK,TOOLS,REFERENCE], "sdk/tools/references/", title, MENU_SDK_REFERENCES)

  title = "SDK Release Notes"
  webSiteBuildSdkIndexPage([SDK,RELEASE_NOTE], "sdk/release-notes/", title, MENU_SDK_RELEASE_NOTES)
end

# Helper function for building an SDK index page.
def webSiteBuildSdkIndexPage(
  labels,
  pageShortPath,
  pageTitle,
  selectedMenuItem)
  
  webSiteBuildIndexPage(
    labels,
    pageShortPath,
    pageTitle,
    selectedMenuItem,
    pathPageSdkMenu())
end

#----------------------------------------------------#
#             Build MoSync Reload Pages              #
#----------------------------------------------------#

# Build the Reload home page.
def webSiteBuildReloadHomePage
  title = "MoSync Reload"
  webSiteBuildPage(
    :outputFile => pathWebSiteReload() + "index.html",
    :pageFile => pathPageReloadHome(),
    :menuFile => pathPageReloadMenu(),
    :templateFile => pathPageTemplate,
    :pageTitle => title,
    :selectedMenuItem => MENU_START_RELOAD
    )
end

# Build all Reload documentation pages.
def webSiteBuildReloadDocPages
  webSiteBuildDocPages(
    docReloadPages(), 
    pathPageReloadMenu())
end

def webSiteBuildReloadIndexPages
  title = "IDE/Tools Guides"
  webSiteBuildReloadIndexPage([RELOAD,GUIDE], "reload/guides/", title, MENU_RELOAD_GUIDES)
  
  title = "Release Notes"
  webSiteBuildReloadIndexPage([RELOAD,RELEASE_NOTE], "reload/release-notes/", title, MENU_RELOAD_RELEASE_NOTES)
end

# Helper function for building a Reload index page.
def webSiteBuildReloadIndexPage(
  labels,
  pageShortPath,
  pageTitle,
  selectedMenuItem)
  
  webSiteBuildIndexPage(
    labels,
    pageShortPath,
    pageTitle,
    selectedMenuItem,
    pathPageReloadMenu())
end

#----------------------------------------------------#
#          Build Website Helper Functions            #
#----------------------------------------------------#

# Build all documentation pages in the given collection
# of page meta data, using the supplied menu file.
def webSiteBuildDocPages(pages, menuFile)

  # Build web page for each documentation page.
  n = 0
  pages.each do |page|
    n = n + 1
    puts "Processing file " + n.to_s + ": " + pageTargetFile(page)
    
    # Set up path names.
    pageFile = pathDocs() + pageTargetFile(page) + "/index.html"
    outputFile = pathWebSite() + pageTargetFile(page) + "/index.html"

    puts "Building #{pageFile} #{outputFile}"
    
    # Build and save page.
    title = htmlGetPageTitle(fileReadContent(pageFile))
    webSiteBuildPage(
      :outputFile => outputFile,
      :pageFile => pageFile,
      :menuFile => menuFile,
      :templateFile => pathPageTemplate(),
      :pageTitle => title,
      :selectedMenuItem => webSiteGetMenuItemTypeForPage(page)
      )
    
    # Copy images to destination directory.
    imageSourceDir = pathDocs() + pageTargetFile(page) + "/images"
    imageDestDir = pathWebSite() + pageTargetFile(page)
    puts "Copy images from " + imageSourceDir + " to " + imageDestDir
    FileUtils.cp_r(Dir[imageSourceDir], imageDestDir)
  end
end

# Builds and saves a page of links for the given
# categories.
# Exampel of pageShortPath: "sdk/cpp/guides/"
def webSiteBuildIndexPage(
  labels,
  pageShortPath,
  pageTitle,
  selectedMenuItem,
  menuFile)
  
  # Create page output path.
  outputFile = pathWebSite() + pageShortPath + "index.html"
  
  puts "Building index page: " + outputFile.to_s
  
  # Get content HTML as a String.
  html = webSiteBuildIndexListForLabels(labels, pageShortPath)
  
  # Build the page. Here we pass the HTML data
  # as a String object using the pageHtml param.
  webSiteBuildPage(
    :outputFile => outputFile,
    :pageHtml => html,
    :menuFile => menuFile,
    :templateFile => pathPageTemplate(),
    :pageTitle => pageTitle,
    :selectedMenuItem => selectedMenuItem
    )
end

# Returns HTML with list items for each label found in 
# pages of the given category and type.
# baseDir is a string naming the directory of the
# target page, e.g. "sdk/cpp/guides/".
def webSiteBuildIndexListForLabels(labels, baseDir)
  # Filter pages.
  pages = docPages()
  pages = pagesForLabels(pages, labels)

  # Get all labels except the ones given in the labels param.
  allLabels = pagesGetAllLabels(pages).sort
  allLabels = allLabels - labels
  
  # Generate lists for each label.
  html = ""
  allLabels.each do |label|
    html += webSiteBuildLinkListForPages(
      pagesForLabel(pages, label),
      label,
      baseDir)
  end

  # Return the result String.
  html
end

# Return HTML for a list with links to the given pages.
# baseDir is a string naming the directory of the
# target page, e.g. "cpp/guides/".
# TODO: Sort list by title of pages.
def webSiteBuildLinkListForPages(pages, label, baseDir)
  html = "<ul data-role=\"listview\" data-inset=\"true\">\n"
  html += "<li data-role=\"list-divider\">#{label}</li>\n"
  pages.each do |page|
    title = pageGetTitleFromTargetFile(page)
    target = pageTargetFile(page) + "/index.html"
    url = target.split(baseDir)[1]
    html += "<li><a data-ajax=\"false\" href=\"#{url}\">#{title}</a></li>\n"
  end
  html += "</ul>\n"
  html
end

# Builds a page from the given content files
# and template files. Saves the result to the
# ouput file. File parameters are path Strings.
def webSiteBuildPage params
  # Get parameters.
  outputFile = params[:outputFile]
  pageFile = params[:pageFile]
  pageHtml = params[:pageHtml]
  menuFile = params[:menuFile]
  templateFile = params[:templateFile]
  pageTitle = params[:pageTitle]
  selectedMenuItem = params[:selectedMenuItem]

  # Create Pathname objects.
  outputPath = Pathname.new(outputFile)
  menuPath = Pathname.new(menuFile)
  templatePath = Pathname.new(templateFile)
  
  # Web site Pathname objects.
  webRootPath = Pathname.new(pathWebSite())
  webJsPath = Pathname.new(pathWebSiteJs())

  # Read files.
  if (pageFile != nil) then
    pageData = fileReadContent(Pathname.new(pageFile))
  else
    pageData = pageHtml
  end
  menuData = fileReadContent(menuPath)
  templateData = fileReadContent(templatePath)
  
  # Relative paths used for links and js/css imports.
  relativeDocPath = webRootPath.relative_path_from(outputPath.dirname)
  relativeJsPath = webJsPath.relative_path_from(outputPath.dirname)

=begin
  puts "outputPath:  " + outputPath.dirname.to_s
  puts "webRootPath: " + webRootPath.to_s
  puts "webJsPath:   " + webJsPath.to_s
  puts "relDocPath:  " + relativeDocPath.to_s
  puts "relJsPath:   " + relativeJsPath.to_s
=end

  # Fill in template data.
  html = webSiteBuildPageFromTemplateData(
    :pageTitle => pageTitle,
    :pageData => pageData,
    :menuData => menuData,
    :templateData => templateData,
    :selectedMenuItem => selectedMenuItem,
    :relativeDocPath => relativeDocPath.to_s,
    :relativeJsPath => relativeJsPath.to_s
    )
    
  # Make sure dest path exists and save page.
  outputPath.parent.mkpath()
  fileSaveContent(outputPath, html)
end

# Builds a page from the given page data
# (all data params are String objects).
# Returns HTML String for page built from template.
def webSiteBuildPageFromTemplateData(params)
  # Get parameters.
  pageTitle = params[:pageTitle]
  pageData = params[:pageData]
  menuData = params[:menuData]
  templateData = params[:templateData]
  selectedMenuItem = params[:selectedMenuItem]
  relativeDocPath = params[:relativeDocPath]
  relativeJsPath = params[:relativeJsPath]
  
  # Substitute template placeholders.
  # Order of these statements is important since included
  # parts in turn contain placeholders to be replaced.
  
  # Insert content and title.
  html = templateData.gsub("TEMPLATE_PAGE_CONTENT", pageData)
  html = html.gsub("TEMPLATE_PAGE_TITLE", pageTitle)
  
  # Insert menu at two places with different insets.
  html = html.gsub("TEMPLATE_PAGE_MENU", menuData)
  html = html.gsub("TEMPLATE_MENU_INSET", "true")
  html = html.gsub("TEMPLATE_PANEL_MENU", menuData)
  html = html.gsub("TEMPLATE_MENU_INSET", "false")
  
  # Set selected menu item.
  MENU_ALL.each do |menuItem|
    if menuItem == selectedMenuItem then
      html = html.gsub(menuItem, "data-theme=\"b\"")
    else
      html = html.gsub(menuItem, "")
    end
  end
  
  # Insert relative paths for urls.
  html = html.gsub("TEMPLATE_JS_PATH", relativeJsPath)
  html = html.gsub("TEMPLATE_DOC_PATH", relativeDocPath)
  
  # Return generated HTML code.
  html
end

# Get the menu item template placeholder for a 
# documentation page.
def webSiteGetMenuItemTypeForPage(page)
  if pageHasAllLabels?(page, [SDK,CPP,GUIDE]) then
    MENU_CPP_GUIDES
  elsif pageHasAllLabels?(page, [SDK,CPP,TUTORIAL]) then
    MENU_CPP_TUTORIALS
  elsif pageHasAllLabels?(page, [SDK,CPP,EXAMPLE]) then
    MENU_CPP_EXAMPLES
  elsif pageHasAllLabels?(page, [SDK,JS,GUIDE]) then
    MENU_JS_GUIDES
  elsif pageHasAllLabels?(page, [SDK,JS,TUTORIAL]) then
    MENU_JS_TUTORIALS
  elsif pageHasAllLabels?(page, [SDK,JS,EXAMPLE]) then
    MENU_JS_EXAMPLES
  elsif pageHasAllLabels?(page, [SDK,TOOLS,GUIDE]) then
    MENU_SDK_GUIDES
  elsif pageHasAllLabels?(page, [SDK,TOOLS,GUIDE]) then
    MENU_SDK_REFERENCES
  elsif pageHasAllLabels?(page, [SDK,RELEASE_NOTE]) then
    MENU_SDK_RELEASE_NOTES
  elsif pageHasAllLabels?(page, [RELOAD,GUIDE]) then
    MENU_RELOAD_GUIDES
  elsif pageHasAllLabels?(page, [RELOAD,RELEASE_NOTE]) then
    MENU_RELOAD_RELEASE_NOTES
  end
end

######################################################
#                 IMPORT FROM DRUPAL                 #
######################################################

# Not used for now.
def convertHtmlToMarkdown
  root = pathExports()
  n = 1
  Pathname.glob(pathExports() + "**/*.html").each  do |p|
    puts "File " + n.to_s + ": " + p.to_s
    n = n + 1
    infile = p.to_s
    outfile = p.sub_ext(".md").to_s
    command = "pandoc -f html -t markdown -o #{outfile} #{infile}"
    puts command
    sh(command)
  end
end

def docImportAll
  docImportHTML
  docDownloadImages
  docUpdateImageTags
end

# Import HTML files exported from Drupal.
def docImportHTML
  sourceDir = Pathname.new pathExports
  destDir = Pathname.new pathDocs
  
  # Process and copy pages to dest dir.
  n = 0
  docPages().each do |page|
    n = n + 1
    
    sourceFile = sourceDir + pageOriginalFile(page) + "index.html"
    destPath = destDir + pageTargetFile(page)
    destFile = destPath + "index.html"
    
    puts "Importing File #{n.to_s}: #{sourceFile} #{destFile}"
    puts " "
    
    destPath.mkpath()
    html = File.open(sourceFile, "rb") { |f| f.read }
    html = htmlUpdateLinks(html)
    html = htmlStripTOC(html)
    html = htmlReplaceSyntaxHighlighterTags(html)
    html = htmlReplaceTabsWithSpaces(html)
    html = htmlPrettify(html)
    fileSaveContent(destFile, html)
  end
end

# Iterate over all pages and all image urls
# and download images to local files.
def docDownloadImages
  puts "Downloading images"
  
  externalImages = "EXTERNAL IMAGES:\n"
  
  # Find all files.
  n = 0
  Pathname.glob(pathDocs() + "**/*.html").each do |filePath|
    n = n + 1
    puts "Processing File " + n.to_s + ": " + filePath.to_s
    # Iterate over all images in the file.
    html = fileReadContent(filePath)
    html.scan(/<img.*?>/) do |imgTag|
      puts "  img: " + imgTag
      # Get the scr url of the img tag
      # and download and save image.
      url = docGetImageDownloadURL(imgTag)
      if url != nil then
        destFile = docGetImagePath(url, filePath.parent)
        puts "    downloading from: " + url
        puts "    writing image to: " + destFile.to_s
        docDownloadImage(url, destFile)
        puts "    done"
      else
        puts "    *** IMAGE NOT DOWNLOADED: " + imgTag
        # A hack indeed.
        externalImages += filePath.to_s + ": " + $lastImageUrl + "\n"
      end
    end
  end
  
  puts externalImages
end

# Iterate over all pages and all image urls
# and convert img tags to refer to local files.
def docUpdateImageTags
  puts "Updating image tags"

  # Find all files.
  n = 0
  Pathname.glob(pathDocs() + "**/*.html").each do |filePath|
    n = n + 1
    puts "Updating File " + n.to_s + ": " + filePath.to_s
    
    # Iterate over all images in the file.
    html = fileReadContent(filePath)
    html.scan(/<img.*?>/) do |imgTag|
      puts "  img: " + imgTag
      url = docGetImageDownloadURL(imgTag)
      if url != nil then
        # Update img tag.
        parts = imgTag.split(/src="(.*?)"/)
        imageFileName = docGetImagePath(url, "")
        imageFileName = imageFileName.gsub(" ", "%20")
        newImgTag = parts[0] + "src=\"" + imageFileName + "\"" + parts[2]
        puts "  new img: " + newImgTag
        # Update image tag.
        html = html.gsub(imgTag, newImgTag)
      else
        puts "    *** IMAGE IGNORED: " + imgTag
      end
    end

    # Write the updated file.
    fileSaveContent(filePath, html)
  end
end

# Get URL to download image from. Return nil
# if the image should not be downloaded.
def docGetImageDownloadURL(imgTag)
  srcMatch = imgTag.scan(/src="(.*?)"/)
  if not srcMatch.empty? then 
    src = srcMatch[0][0]
    $lastImageUrl = src # Useful for logging when returning nil below
    if src.start_with?("http://www.mosync.com") then
      return src
    elsif src.start_with?("https://raw.github.com") then
      return src
    elsif src.start_with?("http://") or 
      src.start_with?("https://") then
      # Return nil here if images from other domains
      # should not be downloaded.
      puts "    *** External image: " + src
      return nil
    elsif src.start_with?("/") then
      # Download from http://www.mosync.com/
      return "http://www.mosync.com" + src
    else 
      puts "    *** UKNOWN IMAGE SOURCE: " + src
    end
  end
  return nil
end

# Given a url and a path, get the 
# file path to the image file.
def docGetImagePath(url, dirPath)
  imageFileName = Pathname(url).basename.to_s
  return dirPath + "images/" + imageFileName
end

# Download an image to the destination file.
def docDownloadImage(url, destFile)
  # Fix the image url, it cannot contain spaces.
  url = url.gsub(" ", "%20")
  begin
    open(url) do |f|
      Pathname(destFile).parent.mkpath()
      File.open(destFile,"wb") do |file| file.puts(f.read) end
    end
  rescue
    puts "*** CANNOT DOWNLOAD IMAGE: " + url.to_s + " ***"
  end
end

######################################################
#                   GET PAGE DATA                    #
######################################################


def docAllPages()
  $pages
end

def docAllPagesNotIgnore()
  docAllPages().select { |page|
    not pageIsIgnore?(page) }
end

def docPages()
  docAllPages().select { |page| 
    #puts "Page:" + page.to_s
    not pageIsRedirect?(page) and not pageIsIgnore?(page) }
end

def docSdkPages()
  $pages.select { |page| 
    pageHasLabel?(page, SDK) }
end

def docReloadPages()
  $pages.select { |page| 
    pageHasLabel?(page, RELOAD) }
end

def docRedirectPages()
  $pages.select { |page| pageIsRedirect?(page) }
end

def pagesForLabel(pages, label)
  pages.select { |page| pageHasLabel?(page, label) }
end

def pagesForLabels(pages, labels)
  pages.select { |page| pageHasAllLabels?(page, labels) }
end

def pagesGetAllLabels(pages)
  (pages.inject([]) { |result,page| 
    result + pageLabels(page) }).uniq
end

def pageIsRedirect?(page)
  pageHasLabel?(page, REDIRECT)
end

def pageIsIgnore?(page)
  pageHasLabel?(page, IGNORE)
end

def pageOriginalFile(page)
  page[0]
end

def pageTargetFile(page)
  page[1]
end

def pageLabels(pageData)
  pageData[2]
end

def pageHasLabel?(page, label)
  pageLabels(page).include? label
end

def pageHasAllLabels?(page, labels)
  labels.each do |label|
    if not pageHasLabel?(page,label) then
      return false
    end
  end
  return true
end

def pageGetTitleFromTargetFile(page)
  dir = Pathname.new(pathDocs())
  file = dir + pageTargetFile(page) + "index.html"
  fileGetPageTitle(file)
end

def htmlGetPageTitle(html)
  htmlGetTagContents(html, "title")
end

######################################################
#                  HTML PROCESSING                   #
######################################################

def htmlGetPageContent(html)
  htmlGetTagContents(html, "body")
end

# Works for simple cases.
def htmlGetTagContents(html, tagName)
  html.split("<#{tagName}>")[1].split("</#{tagName}>")[0]
end

# TODO: Implement. Make a fun that insert pre tags.
def htmlClean(html)
  html
end

def htmlPrettify(html)
  newLineAfterOpeningAndClosingTags = ["html", "head", "body", "div", "ul", "ol", "table"]
  newLineAfterClosingTags = ["title", "h1", "h2", "h3", "h4", "p", "pre", "li", "tr"]
  #start = html.index("</p>", 0)
  (newLineAfterOpeningAndClosingTags + newLineAfterClosingTags).each do |tagName|
    tag = "</" + tagName + ">"
    html = html.gsub(tag, tag + "\n")
  end
  newLineAfterOpeningAndClosingTags.each do |tagName|
    tag = "<" + tagName + ">"
    html = html.gsub(tag, tag + "\n")
  end
  html
end

def htmlReplaceSyntaxHighlighterTags(html)
  html = html.gsub(/{syntaxhighlighter brush: cpp.*?}/, "<pre class=\"mosync-code-cpp\">")
  html = html.gsub(/{syntaxhighlighter brush: jscript.*?}/, "<pre class=\"mosync-code-js\">")
  html = html.gsub(/{syntaxhighlighter brush: css.*?}/, "<pre class=\"mosync-code-css\">")
  html = html.gsub(/{syntaxhighlighter brush: xml.*?}/, "<pre class=\"mosync-code-xml\">")
  html = html.gsub(/{\/syntaxhighlighter}/, "</pre>")
end

def htmlReplaceTabsWithSpaces(html)
  html.gsub("\t", "    ")
end

# Update links to point to new urls.
def htmlUpdateLinks(html)
  #puts "Page BEFORE URL update: " + html
  #puts " "
  
  # Step 1: Update urls and insert marker
  allPages().each do |page|
    # Replace full urls
    html = html.gsub(
      "http://www.mosync.com/" + pageOriginalFile(page), 
      "/NEWDOC_UPDATED_URL_TEMPLATE_DOC_PATH/" + pageTargetFile(page) + "/index.html")
    # Replace short urls
    html = html.gsub(
      pageOriginalFile(page), 
      "NEWDOC_UPDATED_URL_TEMPLATE_DOC_PATH/" + pageTargetFile(page) + "/index.html")
  end
  
  # Step 2: Strip off absolute urls and markers
  html = html.gsub("http://www.mosync.com/NEWDOC_UPDATED_URL_", "")
  html = html.gsub("/NEWDOC_UPDATED_URL_", "")
  html = html.gsub("NEWDOC_UPDATED_URL_", "")
  
  # Step 3: Clean up weird urls
  html = html.gsub("//index.html", "/index.html")
  html = html.gsub("//index.html", "/index.html")
  html = html.gsub("index.html/", "index.html")
  html = html.gsub("TEMPLATE_DOC_PATH//", "TEMPLATE_DOC_PATH/")
  
  #puts "Page AFTER URL update: " + html
  #puts " "
  
  html
end

def htmlStripTOC(html)
  html.gsub("[toc]", "")
end

######################################################
#                    FILE HELPERS                    #
######################################################

# Clean (and create) directory.
def fileCleanPath(pathName) 
  pathName.mkpath()
  begin
    pathName.rmtree()
  rescue
    puts "Cannot delete: " + pathName.to_s
  end
  pathName.mkpath()
end

def fileReadContent(filePath)
  File.open(filePath, "rb") { |f| f.read }
end

def fileSaveContent(destFile, content)
  File.open(destFile, "wb") { |f| f.write(content) }
end

def fileGetPageTitle(filePath)
  html = fileReadContent(filePath)
  htmlGetPageTitle(html)
end

######################################################
#                    MARKDOWN PROCESSING                    #
######################################################

# Convert all .md files in the docs-tmp directory
# to HTML.
# TODO: How should we handle syntax highlight of code
# blocks in markdown?
def webSiteConvertMarkdownToHtml
  puts "Converting Markdown files to HTML"
  template = "<html>
<head>
<title>TEMPLATE_TITLE</title>
</head>
<body>
TEMPLATE_BODY
</body>
</html>"
  n = 0
  Pathname.glob(pathDocs() + "**/*.md").each do |path|
    n = n + 1
    puts "Converting File " + n.to_s + ": " + path.to_s
    infile = path.to_s
    outfile = path.sub_ext(".html").to_s
    markdown = fileReadContent(infile)
    htmlBody = Kramdown::Document.new(markdown, :auto_ids => false).to_html
    title = htmlGetTagContents(htmlBody, "h1")
    fullHtml = template
      .gsub("TEMPLATE_TITLE", title)
      .gsub("TEMPLATE_BODY", htmlBody)
    fileSaveContent(outfile, fullHtml)
  end
end

######################################################
#                       UNUSED                       #
######################################################

def not_used_cleanmd
  root = Pathname.new pathExports
  n = 1
  Pathname.glob(pathExports + "**/*.md").each  do |p|
    puts "rm " + n.to_s + ": " + p.to_s
    n = n + 1
    file = p.to_s
    File.delete file
  end
end

# Used for one shot conversion of symbolic path names.
def not_used_updatePathSymbols
  puts "Updating path symbols"

  # Find all files.
  n = 0
  Pathname.glob("../**/*.html").each do |filePath|
    n = n + 1
    puts "Updating File " + n.to_s + ": " + filePath.to_s
    
    # Replace all symbols in file.
    html = fileReadContent(filePath)
    html = html.gsub("RELATIVE_", "TEMPLATE_")

    # Write the updated file.
    fileSaveContent(filePath, html)
  end
end

######################################################
#                   ANALYSIS TOOLS                   #
######################################################

def listExportedPagesNotInDocs
  exportedFileNames = 
    Pathname.glob(pathExports + "**/*.html").collect do |filename|
      filename.to_s.gsub(pathExports, "").gsub("/index.html", "")
    end
  importedFileNames = allPages().collect do |page|
    pageOriginalFile(page)
  end
  
  puts exportedFileNames - importedFileNames
end

def listTargetFileNames
  targetFileNames = allPages().collect do |page|
    pageTargetFile(page)
  end
  
  puts targetFileNames.sort
end

def generateRedirectSQL
  deleteTemplate = "DELETE FROM mosyncweb_path_redirect where source = 'ORIGINAL_PATH';"
  insertTemplate = "INSERT INTO mosyncweb_path_redirect (rid,source,redirect,query,fragment,type,last_used,language)
VALUES (NULL,'ORIGINAL_PATH','TARGET_PATH',NULL,NULL,'301',NOW(),'');"

  sql = ""
  targetFileNames = docAllPagesNotIgnore().collect do |page|
    originalPath = pageOriginalFile(page)
    targetPath = pageTargetFile(page)
    if (targetPath == HOME_PATH) then
      targetPath = "docs/index.html"
    else
      targetPath = "docs/" + targetPath + "/index.html"
    end
    deleteStatement = deleteTemplate.gsub("ORIGINAL_PATH", originalPath)
    insertStatement = insertTemplate.
        gsub("ORIGINAL_PATH", originalPath).
            gsub("TARGET_PATH", targetPath)
    sql += deleteStatement + "\n" + insertStatement + "\n"
  end
  
  puts sql
end

######################################################
#                 UTILITY FUNCTIONS                  #
######################################################

# Helper function to run shell commands.
def sh(cmd)
  #TODO: optimize by removing the extra shell
  #the Process class should be useful.
  $stderr.puts cmd
  if (!system(cmd)) then
    error "Command failed: '#{$?}'"
  end
end

######################################################
#              COMMAND INVOKATION TABLE              #
######################################################

# Commands
if (ARGV.include? "html2md")
  #convertHtmlToMarkdown
elsif (ARGV.include? "md2html")
  #webSiteCopyDocsForBuild
  #webSiteConvertMarkdownToHtml
elsif (ARGV.include? "cleanmd")
  #cleanmd
elsif (ARGV.include? "importall")
  #docImportAll
elsif (ARGV.include? "importhtml")
    #docImportHTML
elsif (ARGV.include? "downloadimages")
    #docDownloadImages
elsif (ARGV.include? "updateimagetags")
  #docUpdateImageTags
elsif (ARGV.include? "cleandoc")
  #docClean
elsif (ARGV.include? "buildweb")
  webSiteBuild
elsif (ARGV.include? "cleanweb")
  #webSiteClean
elsif (ARGV.include? "listexports")
  #listExportedPagesNotInDocs
elsif (ARGV.include? "listtargets")
  #listTargetFileNames
elsif (ARGV.include? "redirects")
  generateRedirectSQL
else
  puts "Options:"
  #puts "  html2md"
  #puts "  cleanmd"
  #puts "  importall (importhtml + downloadimages + updateimagetags)"
  #puts "  importhtml (imports HTML from Drupal export)"
  #puts "  downloadimages (download images)"
  #puts "  updateimagetags (update img urls)"
  #puts "  cleandoc (cleans documentation folder)"
  puts "  buildweb (builds website)"
  puts "  redirects (generete SQL for Drupal redirects)"
  #puts "  cleanweb (cleans website folder)"
end
