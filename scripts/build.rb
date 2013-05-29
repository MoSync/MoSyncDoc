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
#                DOCUMENTAION VERSION                #
######################################################

def docVersionSdk
  "<p><b>MoSync SDK 3.3</b></p>"
end

def docVersionReload
  "<p><b>MoSync Reload 1.1</b></p>"
end

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

def pathTemplateImages
  pathTemplates + "images/"
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

def pathWebSiteImages
  pathWebSite + "images/"
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
# Unused here, because these will be set
# to be highlighted also for all pages
# in the documentation.
#MENU_START_SDK,
#MENU_START_RELOAD,
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

# Theme Swatches

def swatchDocHome
  "b"
end

def swatchSdk
  "c"
end

def swatchReload
  "a"
end

def swatchItem
  "e"
end

def swatchMenuDivider
  "d"
end

#----------------------------------------------------#
#             Build Website Entry Point              #
#----------------------------------------------------#

# You can specify to build only SDK or Reload
# by supplying and array with what to build.
# Build SDK:    webSiteBuild ["sdk"]
# Build Reload: webSiteBuild ["reload"]
# Build all:    webSiteBuild
def webSiteBuild what=[]
  if what == [] then
    what = ["sdk","reload"]
  end

  webSiteCleanDocsForBuild
  if what.include?("sdk") then
    webSiteCopySdkDocsForBuild
  end
  if what.include?("reload") then
    webSiteCopyReloadDocsForBuild
  end

  webSiteConvertMarkdownToHtml
  webSiteClean
  webSiteCopyLibs
  webSiteBuildDocHomePage
  webSiteBuildSearchPage

  if what.include?("sdk") then
    webSiteBuildSdkSpecialPages
    webSiteBuildSdkHomePage
    webSiteBuildSdkDocPages
    webSiteBuildSdkIndexPages
  end

  if what.include?("reload") then
    webSiteBuildReloadHomePage
    webSiteBuildReloadDocPages
    webSiteBuildReloadIndexPages
  end
end


#----------------------------------------------------#
#               Copying Website Files                #
#----------------------------------------------------#

# Copy documentation files to a temporary documentation
# directory, containing both SDK and Reload doc files.

def webSiteCleanDocsForBuild
  puts "Cleaning docs temp directory"
  # Clean target directory.
  fileCleanPath(Pathname.new(pathDocs()))
end

def webSiteCopySdkDocsForBuild
  puts "Copying SDK doc files"
  # Copy SDK files.
  FileUtils.cp_r(Dir[pathDocsSdk()], pathDocs())
end

def webSiteCopyReloadDocsForBuild
  puts "Copying Reload doc files"
  # Copy Reload files.
  FileUtils.cp_r(Dir[pathDocsReload()], pathDocs())
end

# Clean website output folder.

def webSiteClean
  puts "Cleaning website directory"
  # Clean and create target directories.
  fileCleanPath(Pathname.new(pathWebSite()))
  fileCleanPath(Pathname.new(pathWebSiteJs()))
end

# Copy templates and JavaScript libs to website folder.

def webSiteCopyLibs
  # Copy JavaScript libs.
  FileUtils.cp_r(Dir[pathTemplateJs()], pathWebSite())
  
  # Copy images.
  FileUtils.cp_r(Dir[pathTemplateImages()], pathWebSite())
end

#----------------------------------------------------#
#           Build Documentation Home Page            #
#----------------------------------------------------#

def webSiteBuildDocHomePage
  webSiteBuildPage(
    :outputFile => pathWebSite() + "index.html",
    :pageFile => pathPageDocHome(),
    :menuFile => pathPageDocMenu(),
    :templateFile => pathPageTemplate(),
    :swatch => swatchDocHome(),
    :pageHeading => fileGetPageTitle(pathPageDocHome()),
    :pageHeaderTags => fileGetHeaderTags(pathPageDocHome()),
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
    :swatch => swatchDocHome(),
    :pageHeading => title,
    :pageHeaderTags => "", # TODO: Add headertags.
    :selectedMenuItem => MENU_START_SEARCH
    )
end

#----------------------------------------------------#
#               Build MoSync SDK Pages               #
#----------------------------------------------------#

# Builds the feature-platform-support page.
def webSiteBuildSdkSpecialPages
  puts "Building special pages"
  
  webSiteBuildSdkFeaturePlatformSupportPage
end

# Builds the feature-platform-support page.
# TODO: We can add all kinds of feature to the table,
# sorting, colouring etc. This is basic version.
def webSiteBuildSdkFeaturePlatformSupportPage
  puts "Building Feature-Platform Support page"
  
  # File names.
  dataFile = "../docs-tmp/sdk/tools/references/feature-platform-support/feature-platform-support.csv"
  htmlFile = "../docs-tmp/sdk/tools/references/feature-platform-support/index.html"
  
  # Generate the table from the CSV file.
  firstRow = true
  rowToggle = true
  table = "<table>\n"
  File.readlines(dataFile).each do |line|
    # Remove trailing newline.
    line = line.gsub(/\n$/, "")
    
    # Add some basic colouring to make table easier to read.
    # These styles are defined in the index.html file.
    rowToggle = ! rowToggle
    if rowToggle then
      classAttr = "mosync-feature-table-row-odd"
    else
      classAttr = "mosync-feature-table-row-even"
    end
    # Overwrite style if first row (header row).
    if firstRow then
      firstRow = false
      classAttr = "mosync-feature-table-head"
    end
    
    # Open row.
    table = table + "<tr class=\"#{classAttr}\">"
    
    # Get row fields.
    line.split("\t").each do |field|
      # Do not show NONE fields.
      if field == "NONE"
        field = "&nbsp;"
      end
	  # Add classes that colour "Yes", "No", and "N/A" fields.
	  # Default is no colour class.
	  colorClass = ""
	  if field == "Yes" then
	    colorClass = " class='color-yes'"
	  elsif field == "No" then
	    colorClass = " class='color-no'"
	  elsif field == "N/A" then
	    colorClass = " class='color-na'"
	  end
      table = table + "<td#{colorClass}>#{field}</td>"
    end
    
    # Close row.
    table = table + "</tr>\n"
  end
  table = table + "</table>\n"
  
  # Read the HTML file with table header.
  html = fileReadContent(htmlFile)
  
  # Insert the table.
  html = html.gsub("TEMPLATE_FEATURE_PLATFORM_SUPPORT_TABLE", table);
  
  # Save the page.
  fileSaveContent(htmlFile, html)
end

# Build the SDK home page.
def webSiteBuildSdkHomePage
  webSiteBuildPage(
    :outputFile => pathWebSiteSdk() + "index.html",
    :pageFile => pathPageSdkHome(),
    :menuFile => pathPageSdkMenu(),
    :templateFile => pathPageTemplate(),
    :swatch => swatchSdk(),
    :pageHeading => fileGetPageTitle(pathPageSdkHome()),
    :pageHeaderTags => fileGetHeaderTags(pathPageSdkHome()),
    :selectedMenuItem => MENU_START_SDK,
    :docVersion => docVersionSdk()
    )
end

# Build all SDK documentation pages.
def webSiteBuildSdkDocPages
  webSiteBuildDocPages(
    docSdkPages(), 
    pathPageSdkMenu(),
    swatchSdk(),
    docVersionSdk())
end

# Build SDK index pages for all categories and page types.
def webSiteBuildSdkIndexPages
  title = "C/C++ Guides"
  webSiteBuildSdkIndexPage([SDK,CPP,GUIDE], "sdk/cpp/guides/", title, MENU_CPP_GUIDES)
  
  #title = "C/C++ Tutorials"
  #webSiteBuildSdkIndexPage([SDK,CPP,TUTORIAL], "sdk/cpp/guides/", title, #MENU_CPP_TUTORIALS)
  
  title = "C/C++ Examples"
  webSiteBuildSdkIndexPage([SDK,CPP,EXAMPLE], "sdk/cpp/examples/", title, MENU_CPP_EXAMPLES)
  
  title = "JavaScript Guides"
  webSiteBuildSdkIndexPage([SDK,JS,GUIDE], "sdk/js/guides/", title, MENU_JS_GUIDES)
  
  #title = "JavaScript Guides"
  #webSiteBuildSdkIndexPage([SDK,JS,TUTORIAL], "sdk/js/tutorials/", title, #MENU_JS_TUTORIALS)
  
  title = "JavaScript Examples"
  webSiteBuildSdkIndexPage([SDK,JS,EXAMPLE], "sdk/js/examples/", title, MENU_JS_EXAMPLES)
  
  #TODO: This could be useful
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
    pathPageSdkMenu(),
    swatchSdk(),
    docVersionSdk())
end

#----------------------------------------------------#
#             Build MoSync Reload Pages              #
#----------------------------------------------------#

# Build the Reload home page.
def webSiteBuildReloadHomePage
  webSiteBuildPage(
    :outputFile => pathWebSiteReload() + "index.html",
    :pageFile => pathPageReloadHome(),
    :menuFile => pathPageReloadMenu(),
    :templateFile => pathPageTemplate,
    :swatch => swatchReload(),
    :pageHeading => fileGetPageTitle(pathPageReloadHome()),
    :pageHeaderTags => fileGetHeaderTags(pathPageReloadHome()),
    :selectedMenuItem => MENU_START_RELOAD,
    :docVersion => docVersionReload()
    )
end

# Build all Reload documentation pages.
def webSiteBuildReloadDocPages
  webSiteBuildDocPages(
    docReloadPages(), 
    pathPageReloadMenu(),
    swatchReload(),
    docVersionReload())
end

# Build all Reload index pages.
def webSiteBuildReloadIndexPages
  title = "Reload Guides"
  webSiteBuildReloadIndexPage([RELOAD,GUIDE], "reload/guides/", title, MENU_RELOAD_GUIDES)
  
  title = "Reload Release Notes"
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
    pathPageReloadMenu(),
    swatchReload(),
    docVersionReload())
end

#----------------------------------------------------#
#          Build Website Helper Functions            #
#----------------------------------------------------#

# Build all documentation pages in the given collection
# of page meta data, using the supplied menu file.
def webSiteBuildDocPages(pages, menuFile, swatch, docVersion)

  # Build web page for each documentation page.
  n = 0
  pages.each do |page|
    n = n + 1
    puts "Building page " + n.to_s + ": " + pageTargetFile(page)
    
    # Set up path names.
    pageFile = pathDocs() + pageTargetFile(page) + "/index.html"
    outputFile = pathWebSite() + pageTargetFile(page) + "/index.html"

    #puts "Building #{pageFile} #{outputFile}"
    
    #puts "Heading: " + fileGetPageHeading(pageFile)

    # Read page content.
    pageHtml = htmlGetPageContent(fileReadContent(pageFile))
    
    # Insert syntax higlighter tags.
    pageHtml = htmlAddSyntaxHighligting(pageHtml)
    
    # Build and save page.
    webSiteBuildPage(
      :outputFile => outputFile,
      :pageHtml => pageHtml,
      :menuFile => menuFile,
      :templateFile => pathPageTemplate(),
      :swatch => swatch,
      :pageHeading => pageGetHeadingFromDocumentationType(page),
      :pageHeaderTags => fileGetHeaderTags(pageFile),
      :selectedMenuItem => webSiteGetMenuItemTypeForPage(page),
      :docVersion => docVersion
      )
    
    # Copy images to destination directory.
    imageSourceDir = pathDocs() + pageTargetFile(page) + "/images"
    imageDestDir = pathWebSite() + pageTargetFile(page)
    #puts "Copy images from " + imageSourceDir + " to " + imageDestDir
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
  menuFile,
  swatch,
  docVersion)
  
  # Create page output path.
  outputFile = pathWebSite() + pageShortPath + "index.html"
  
  puts "Building index page: " + outputFile.to_s
  
  # Get content HTML as a String.
  html = webSiteBuildIndexListForLabels(labels, pageShortPath, swatch)
  
  # Build the page. Here we pass the HTML data
  # as a String object using the pageHtml param.
  webSiteBuildPage(
    :outputFile => outputFile,
    :pageHtml => html,
    :menuFile => menuFile,
    :templateFile => pathPageTemplate(),
    :swatch => swatch,
    :pageHeading => pageTitle,
    :pageHeaderTags => "<title>" + pageTitle + "</title>",
    :selectedMenuItem => selectedMenuItem,
    :docVersion => docVersion
    )
end

# Returns HTML with list items for each label found in 
# pages of the given category and type.
# baseDir is a string naming the directory of the
# target page, e.g. "sdk/cpp/guides/".
def webSiteBuildIndexListForLabels(labels, baseDir, swatch)
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
      baseDir,
      swatch)
  end

  # Return the result String.
  html
end

# Return HTML for a list with links to the given pages.
# baseDir is a string naming the directory of the
# target page, e.g. "cpp/guides/".
# TODO: Sort list by title of pages.
def webSiteBuildLinkListForPages(pages, label, baseDir, swatch)
  # First collect data in an array so we can sort it by title.
  entries = pages.collect do |page|
    title = pageGetTitleFromTargetFile(page)
    target = pageTargetFile(page) + "/index.html"
    url = target.split(baseDir)[1]
	[title, url]
  end

  entries = entries.sort
  
  # Next generate the HTML list.
  html = "<ul data-role=\"listview\" data-inset=\"true\" data-theme=\"#{swatch}\">\n"
  html += "<li data-role=\"list-divider\" data-theme=\"#{swatch}\">#{label}</li>\n"
  entries.each do |title,url|
    html += "<li data-theme=\"#{swatchItem()}\"><a data-ajax=\"false\" href=\"#{url}\">#{title}</a></li>\n"
  end
  html += "</ul>\n"
  
  # Return the result.
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
  swatch = params[:swatch]
  pageHeading = params[:pageHeading]
  pageHeaderTags = params[:pageHeaderTags]
  selectedMenuItem = params[:selectedMenuItem]
  docVersion = params[:docVersion]

  # Create Pathname objects.
  outputPath = Pathname.new(outputFile)
  menuPath = Pathname.new(menuFile)
  templatePath = Pathname.new(templateFile)
  
  # Web site Pathname objects.
  webRootPath = Pathname.new(pathWebSite())
  webJsPath = Pathname.new(pathWebSiteJs())
  webImagePath = Pathname.new(pathWebSiteImages())

  # Read files.
  if (pageFile != nil) then
    pageData = fileReadContent(Pathname.new(pageFile))
  else
    pageData = pageHtml
  end
  menuData = fileReadContent(menuPath)
  templateData = fileReadContent(templatePath)
  
  # Relative paths used for links and js/css imports and images.
  relativeDocPath = webRootPath.relative_path_from(outputPath.dirname)
  relativeJsPath = webJsPath.relative_path_from(outputPath.dirname)
  relativeImagePath = webImagePath.relative_path_from(outputPath.dirname)

=begin
  puts "outputPath:  " + outputPath.dirname.to_s
  puts "webRootPath: " + webRootPath.to_s
  puts "webJsPath:   " + webJsPath.to_s
  puts "relDocPath:  " + relativeDocPath.to_s
  puts "relJsPath:   " + relativeJsPath.to_s
=end

  # Fill in template data.
  html = webSiteBuildPageFromTemplateData(
    :pageHeading => pageHeading,
    :pageHeaderTags => pageHeaderTags,
    :pageData => pageData,
    :menuData => menuData,
    :templateData => templateData,
    :swatch => swatch,
    :selectedMenuItem => selectedMenuItem,
    :relativeDocPath => relativeDocPath.to_s,
    :relativeJsPath => relativeJsPath.to_s,
    :relativeImagePath => relativeImagePath.to_s,
    :docVersion => docVersion
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
  pageHeaderTags = params[:pageHeaderTags]
  pageHeading = params[:pageHeading]
  pageData = params[:pageData]
  menuData = params[:menuData]
  templateData = params[:templateData]
  swatch = params[:swatch]
  selectedMenuItem = params[:selectedMenuItem]
  relativeDocPath = params[:relativeDocPath]
  relativeJsPath = params[:relativeJsPath]
  relativeImagePath = params[:relativeImagePath]
  docVersion = params[:docVersion]
  
  # Not all pages should display the documentation
  # version string.
  if nil == docVersion then
    docVersion = ""
  end
  
  # Substitute template placeholders.
  # Order of these statements is important since included
  # parts in turn contain placeholders to be replaced.
  
  # Insert content and title.
  html = templateData.gsub("TEMPLATE_HEADER_TAGS", pageHeaderTags)
  html = html.gsub("TEMPLATE_PAGE_HEADING", pageHeading)
  # Doc version info is now on the menu pages for SDK and Reload.
  # html = html.gsub("TEMPLATE_DOC_VERSION", docVersion)
  html = html.gsub("TEMPLATE_PAGE_CONTENT", pageData)
  
  # Insert menu at two places with different insets.
  html = html.gsub("TEMPLATE_PAGE_MENU", menuData)
  html = html.gsub("TEMPLATE_MENU_INSET", "true")
  html = html.gsub("TEMPLATE_PANEL_MENU", menuData)
  html = html.gsub("TEMPLATE_MENU_INSET", "false")
  
  # Set theme swatch letters.
  html = html.gsub("TEMPLATE_THEME_PAGE_MAIN", webSiteDataTheme(swatch))
  html = html.gsub("TEMPLATE_THEME_PAGE_HEADER", webSiteDataTheme(swatch))
  html = html.gsub("TEMPLATE_THEME_MENU_PANEL", webSiteDataTheme(swatch))
  html = html.gsub("TEMPLATE_THEME_MENU_LIST", webSiteDataTheme(swatch))
  html = html.gsub("TEMPLATE_THEME_MENU_DIVIDER", webSiteDataTheme(swatchMenuDivider()))
  html = html.gsub("TEMPLATE_THEME_MENU_ITEM", webSiteDataTheme(swatchItem()))
  html = html.gsub("TEMPLATE_THEME_MENU_SEARCH_BOX", webSiteDataTheme(swatchItem()))
  html = html.gsub("TEMPLATE_THEME_CONTENT_LIST", webSiteDataTheme(swatch))
  html = html.gsub("TEMPLATE_THEME_CONTENT_ITEM", webSiteDataTheme(swatchItem()))

  # Set selected menu item.
  MENU_ALL.each do |menuItem|
    if menuItem == selectedMenuItem then
      html = html.gsub(menuItem, webSiteDataTheme(swatch))
    else
      html = html.gsub(menuItem, webSiteDataTheme(swatchItem))
    end
  end
  
  # Special handling of the top highlight for the
  # top menu items for SDK and Reload.
  if docVersion == docVersionSdk() then
    # Highlight
    html = html.gsub(MENU_START_SDK, webSiteDataTheme(swatch))
  else
    html = html.gsub(MENU_START_SDK, webSiteDataTheme(swatchItem))
  end
  if docVersion == docVersionReload() then
    # Highlight
    html = html.gsub(MENU_START_RELOAD, webSiteDataTheme(swatch))
  else
    html = html.gsub(MENU_START_RELOAD, webSiteDataTheme(swatchItem))
  end
    
  # Insert relative paths for urls.
  html = html.gsub("TEMPLATE_JS_PATH", relativeJsPath)
  html = html.gsub("TEMPLATE_IMAGE_PATH", relativeImagePath)
  html = html.gsub("TEMPLATE_DOC_PATH", relativeDocPath)
  
  # Return generated HTML code.
  html
end

def webSiteDataTheme(swatchLetter)
  " data-theme=\"" + swatchLetter + "\" "
end

# Get the menu item template placeholder for a 
# documentation page.
def webSiteGetMenuItemTypeForPage(page)
  # Document type TUTORIAL is not used.
  if pageHasAllLabels?(page, [SDK,CPP,GUIDE]) then
    MENU_CPP_GUIDES
  #elsif pageHasAllLabels?(page, [SDK,CPP,TUTORIAL]) then
  #  MENU_CPP_TUTORIALS
  elsif pageHasAllLabels?(page, [SDK,CPP,EXAMPLE]) then
    MENU_CPP_EXAMPLES
  elsif pageHasAllLabels?(page, [SDK,JS,GUIDE]) then
    MENU_JS_GUIDES
  #elsif pageHasAllLabels?(page, [SDK,JS,TUTORIAL]) then
  # MENU_JS_TUTORIALS
  elsif pageHasAllLabels?(page, [SDK,JS,EXAMPLE]) then
    MENU_JS_EXAMPLES
  elsif pageHasAllLabels?(page, [SDK,TOOLS,GUIDE]) then
    MENU_SDK_GUIDES
  elsif pageHasAllLabels?(page, [SDK,TOOLS,REFERENCE]) then
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

# This code is not used any more, but is kept as a reference.

=begin

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

# Update links to point to new urls.
# This is a "one shot" operation done on 
# pages imported from Drupal.
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
    # TODO: This is unsafe for short urls like "contibutions",
    # this caused problems that is now fixed. In the future,
    # if using this code again, be aware of this! Added quote
    # marks to gsub, to make it a little safer. Even better
    # is to use full regexp that targets a-tags.
    html = html.gsub(
      '"' + pageOriginalFile(page) + '"', 
      "\"NEWDOC_UPDATED_URL_TEMPLATE_DOC_PATH/" + pageTargetFile(page) + "/index.html\"")
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

# TODO: Implement. Make a function that insert pre tags.
# What was the purpose of this?
def htmlClean(html)
  html
end

# This was used for a one-shot conversion on the Durpal pages.
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

# This was used for a one-shot conversion on the Drupal pages.
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

=end

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
  fileGetPageHeading(file)
end

# TODO: Fix titles, so that they are in variables,
# perferably in structure.rb? Title strings 
# are now duplicated.
def pageGetHeadingFromDocumentationType(page)
  if pageHasAllLabels?(page, [SDK,RELEASE_NOTE]) then
    "SDK Release Notes"
  elsif pageHasAllLabels?(page, [RELOAD,RELEASE_NOTE]) then
    "Reload Release Notes"
  elsif pageHasAllLabels?(page, [CPP,GUIDE]) then
    "C/C++ Guides"
  elsif pageHasAllLabels?(page, [CPP,EXAMPLE]) then
    "C/C++ Examples"
  elsif pageHasAllLabels?(page, [JS,GUIDE]) then
    "JavaScript Guides"
  elsif pageHasAllLabels?(page, [JS,EXAMPLE]) then
    "JavaScript Examples"
  elsif pageHasAllLabels?(page, [SDK,TOOLS,GUIDE]) then
    "SDK Tools Guides"
  elsif pageHasAllLabels?(page, [SDK,REFERENCE]) then
    "SDK Tools References"
  elsif pageHasAllLabels?(page, [RELOAD,GUIDE]) then
    "Reload Guides"
  elsif pageHasAllLabels?(page, [RELOAD,TOOLS]) then
    "Reload Tools"
  else
    puts "@@@@@@@ UNDEFINED TITLE @@@@@@@"
    "UNDEFINED TITLE"
  end
end

######################################################
#                  HTML PROCESSING                   #
######################################################

def htmlGetPageTitle(html)
  htmlGetTagContents(html, "title")
end

def htmlGetPageHeading(html)
  htmlGetTagContents(html, "h1")
end

def htmlGetPageContent(html)
  htmlGetTagContents(html, "body")
end

# Works for simple cases.
def htmlGetTagContents(html, tagName)
  result = html.split("<#{tagName}>")
  if result.size < 2 then
    return ""
  else
    result[1].split("</#{tagName}>")[0]
  end
end

def htmlAddSyntaxHighligting(html)
  # Replace mosync-code class attributes with syntaxhigligter attributes.
  html = html.gsub(/<pre class=\"mosync-code-cpp\">/, "<pre class=\"brush: cpp\">")
  html = html.gsub(/<pre class=\"mosync-code-js\">/, "<pre class=\"brush: js\">")
  html = html.gsub(/<pre class=\"mosync-code-xml\">/, "<pre class=\"brush: xml\">")
  html = html.gsub(/<pre class=\"mosync-code-css\">/, "<pre class=\"brush: css\">")
  
  # Replace <pre><code> begin and end tags (produced by Markdown).
  # TODO: This defaults to C++ until we found a better solution.
  html = html.gsub(/<pre><code>/, "<pre class=\"brush: css\">")
  html = html.gsub(/<\/code><\/pre>/, "<\/pre>")
  
  # Return the result string.
  html
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
  File.open(filePath, "rb") { |f| f.read.force_encoding("UTF-8") }
end

def fileSaveContent(destFile, content)
  File.open(destFile, "wb") { |f| f.write(content) }
end

def fileGetPageTitle(filePath)
  html = fileReadContent(filePath)
  htmlGetPageTitle(html)
end

def fileGetPageHeading(filePath)
  html = fileReadContent(filePath)
  htmlGetPageHeading(html)
end

# Get the custom header tags from a file.
# This is meta data enclosed in HTML-comments,
# and it is inserted into the head-element of
# the final web page.
def fileGetHeaderTags(filePath)
  html = fileReadContent(filePath)
  htmlGetTagContents(html, "mosyncheadertags")
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
    puts "Converting file " + n.to_s + ": " + path.to_s
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
#             ANALYSIS AND UPDATE TOOLS              #
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
#TODO: Change NOW() to: unix_timestamp(now())
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

# Generate a list of URLs that can be used with Google Search
# to index pages.
def generateListOfPageUrls
  urls = ""
  docPages().each do |page|
    targetPath = pageTargetFile(page)
    url = "http://www.mosync.com/docs/" + targetPath + "/index.html"
    urls += url + "\n"
  end
  puts urls
end

def renameTutorialPaths
  puts "Renaming tutorial path names"

  n = 0
  b = lambda do |filePath|
    n = n + 1
    #puts "Updating File " + n.to_s + ": " + filePath.to_s
    
    # Replace tutorial paths in file.
    htmlOrig = fileReadContent(filePath)
    html = htmlOrig.gsub("sdk/cpp/tutorials", "sdk/cpp/guides")
    html = html.gsub("sdk/js/tutorials", "sdk/js/guides")

    # Write the updated file.
    if (htmlOrig != html) then
      #puts "  ---> Updated!"
      puts filePath.to_s
      fileSaveContent(filePath, html)
    end
  end
  
  # Update all files.
  Pathname.glob(pathDocsSdk + "**/*.html").each &b
  #Pathname.glob(pathDocsReload + "**/*.html").each &b
end

def pagesReferingToMoSyncCom
  puts "Pages that refer to mosync.com"

  n = 0
  hits = []
  b = lambda do |filePath|
    n = n + 1
    html = fileReadContent(filePath)
    match = html.scan(/.{11}mosync\.com.*?>/)
    #if not match.empty? then 
    #  puts filePath.to_s + " " + match[0].to_s
    #end 
    hits += match.collect do |m|  
      m.to_s
    end
  end
  
  # Update all files.
  Pathname.glob(pathDocsSdk + "**/*.html").each &b
  Pathname.glob(pathDocsReload + "**/*.html").each &b
  
  puts hits.sort.uniq
end

def pageSearchTool(stringOrRegExp)
  puts "Pages that contain: " + stringOrRegExp.to_s

  n = 0
  hits = []
  b = lambda do |filePath|
    n = n + 1
    html = fileReadContent(filePath)
    match = html.scan(stringOrRegExp)
    hits += match.collect do |m|  
      filePath.to_s
    end
  end
  
  # Update all files.
  Pathname.glob(pathDocsSdk + "**/*.html").each &b
  Pathname.glob(pathDocsReload + "**/*.html").each &b
  
  puts hits.sort
end

# One time import and patching of meta tags from Drupal pages.
# This turned out to become quite truicky because of UTF-8
# encoding problems. When reading binary data, you need to
# use force_encoding to get strings in UTF-8. This is used below.
def patchPagesWithMetaTags
  # Iterate over entries in the page table that
  # are not REDIRECT or IGNORE.
  n = 0
  docPages().each do |page|
    n = n + 1
    url = "http://www.mosync.com/" + pageOriginalFile(page)
    if pageHasLabel?(page, SDK) then
      targetFile = "../docs/" + pageTargetFile(page) + "/index.html"
    elsif pageHasLabel?(page, RELOAD) then
      targetFile = "../../ReloadDoc/docs/" + pageTargetFile(page) + "/index.html"
    else
      puts "ERROR File has no category: " + pageTargetFile(page)
    end
    
    # Get meta tags.
    puts "Downloading " + n.to_s + ": " + url
    puts "TargetFile: " + targetFile
    htmlOnline = netDownloadFile(url)
    headerTags = helperGetHeaderTags(htmlOnline)
    
    # Read file.
    html = fileReadContent(targetFile)
    
    # Patch page.
    match = html.scan(/<title>.*?<\/title>/)
    if match.size == 1 then
      # Replace title tag with meta tags.
      # This is needed because we have read the file in binary format.
      html = html.force_encoding("UTF-8")
      html = html.gsub(/<title>.*?<\/title>/, headerTags)
      # Save target file.
      fileSaveContent(targetFile, html)
    else
      puts "UNEXPECTED NUMBER OF TITLE TAGS: " + match.size
    end
  end
end

def helperGetHeaderTags(html)
  metaDescription = helperGetFirstMatch(html, /<meta name="description".*?>/)
  # Use same content for "dcterms.description" as for "description".
  # This way documents do not have to specify "dcterms.description",
  # only "description".
  metaDescription2 = metaDescription.gsub(
    "name=\"description\"",
    "name=\"dcterms.description\"")
  metaKeywords = helperGetFirstMatch(html, /<meta name="keywords".*?>/)
  title = helperGetFirstMatch(html, /<title>.*?<\/title>/)
  "<!-- <mosyncheadertags>\n" + 
    metaDescription + "\n" + 
    metaDescription2 + "\n" + 
    metaKeywords + "\n" + 
    title + "\n" +
    "</mosyncheadertags> -->"
end

def helperGetFirstMatch(text, regexp)
  match = text.scan(regexp)
  if (match.size > 0) then
    match[0].to_s
  else
    ""
  end
end

def netDownloadFile(url)
  begin
    open(url) do |f|
      return f.read
    end
  rescue
    puts "*** CANNOT DOWNLOAD PAGE: " + url.to_s + " ***"
    return ""
  end
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
  webSiteCopyDocsForBuild
  webSiteConvertMarkdownToHtml
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
elsif (ARGV.include? "buildall")
  webSiteBuild
elsif (ARGV.include? "buildsdk")
  webSiteBuild ["sdk"]
elsif (ARGV.include? "buildreload")
  webSiteBuild ["reload"]
elsif (ARGV.include? "cleanweb")
  webSiteClean
elsif (ARGV.include? "listexports")
  #listExportedPagesNotInDocs
elsif (ARGV.include? "listtargets")
  #listTargetFileNames
elsif (ARGV.include? "redirects")
  generateRedirectSQL
elsif (ARGV.include? "renametutorialpaths")
  #renameTutorialPaths
elsif (ARGV.include? "findmosynccom")
  pagesReferingToMoSyncCom
elsif (ARGV.include? "patchmeta")
  patchPagesWithMetaTags
elsif (ARGV.include? "search")
  pageSearchTool ARGV[1]
elsif (ARGV.include? "pageurls")
  generateListOfPageUrls
else
  puts "Options:"
  #puts "  html2md"
  #puts "  cleanmd"
  #puts "  importall (importhtml + downloadimages + updateimagetags)"
  #puts "  importhtml (imports HTML from Drupal export)"
  #puts "  downloadimages (download images)"
  #puts "  updateimagetags (update img urls)"
  #puts "  cleandoc (cleans documentation folder)"
  puts "  buildall (builds SDK/Reload website)"
  puts "  buildsdk (builds SDK website)"
  puts "  buildreload (builds Reload website)"
  #puts "  redirects (generete SQL for Drupal redirects)"
  #puts "  cleanweb (cleans website output folder)"
end
